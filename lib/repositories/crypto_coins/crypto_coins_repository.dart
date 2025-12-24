import 'package:crypto_app/repositories/crypto_coins/crypto_coins.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_ce_flutter/adapters.dart';
import 'package:talker_flutter/talker_flutter.dart';

class CryptoCoinsRepository implements AbstractCryptoCoinsRepository {
  final Dio dio;
  final Box<CryptoCoin> cryptoCoinsBox;

  CryptoCoinsRepository({required this.dio, required this.cryptoCoinsBox});

  @override
  Future<List<CryptoCoin>> getCryptoCoins() async {
    var cryptoCoinList = <CryptoCoin>[];
    try {
      cryptoCoinList = await _fetchCoinsListFromApi();

      final cryptoCoinsMap = {for (var e in cryptoCoinList) e.name: e};
      await cryptoCoinsBox.putAll(cryptoCoinsMap);
    } catch (e, st) {
      GetIt.I.get<Talker>().handle(e, st);
      cryptoCoinList = cryptoCoinsBox.values.toList();
    }
    cryptoCoinList.sort(
      (a, b) => b.details.priceInUSD.compareTo(a.details.priceInUSD),
    );
    return cryptoCoinList;
  }

  Future<List<CryptoCoin>> _fetchCoinsListFromApi() async {
    final response = await dio.get(
      'https://min-api.cryptocompare.com/data/pricemultifull?fsyms=BTC,ETH,BNB,AID,SOL,DOV,DOT,TRUMP&tsyms=USD',
    );
    final data = response.data as Map<String, dynamic>;
    final dataRaw = data['RAW'] as Map<String, dynamic>;

    final cryptoCoinList = dataRaw.entries.map((e) {
      final usdData = e.value['USD'] as Map<String, dynamic>;
      final details = CryptoCoinDetails.fromJson(usdData);
      return CryptoCoin(name: e.key, details: details);
    }).toList();
    return cryptoCoinList;
  }

  @override
  Future<CryptoCoin> getCryptoCoinDetails(String currencyCode) async {
    try {
      final coin = await _fetchCoinFromApi(currencyCode);
      cryptoCoinsBox.put(currencyCode, coin);
      return coin;
    } catch (e, st) {
      GetIt.I.get<Talker>().handle(e, st);
      final coin = cryptoCoinsBox.get(currencyCode)!;
      return coin;
    }
  }

  Future<CryptoCoin> _fetchCoinFromApi(String currencyCode) async {
    final response = await dio.get(
      'https://min-api.cryptocompare.com/data/pricemultifull?fsyms=$currencyCode&tsyms=USD',
    );
    final data = response.data as Map<String, dynamic>;
    final dataRaw = data['RAW'] as Map<String, dynamic>;
    final coinData = dataRaw[currencyCode] as Map<String, dynamic>;
    final usdData = coinData['USD'] as Map<String, dynamic>;
    final details = CryptoCoinDetails.fromJson(usdData);
    return CryptoCoin(name: currencyCode, details: details);
  }
}

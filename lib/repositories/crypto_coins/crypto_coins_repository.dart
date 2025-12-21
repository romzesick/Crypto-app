import 'package:crypto_app/repositories/crypto_coins/crypto_coins.dart';
import 'package:dio/dio.dart';

class CryptoCoinsRepository implements AbstractCryptoCoinsRepository {
  final Dio dio;

  CryptoCoinsRepository({required this.dio});

  @override
  Future<List<CryptoCoin>> getCryptoCoins() async {
    final response = await dio.get(
      'https://min-api.cryptocompare.com/data/pricemultifull?fsyms=BTC,ETH,BNB,AID,SOL,DOV,DOT,TRUMP&tsyms=USD',
    );
    final data = response.data as Map<String, dynamic>;
    final dataRaw = data['RAW'] as Map<String, dynamic>;

    final cryptoCoinList = dataRaw.entries.map((e) {
      final usdData = e.value['USD'] as Map<String, dynamic>;
      final price = usdData['PRICE'];
      final imageUrl = usdData['IMAGEURL'];
      return CryptoCoin(
        name: e.key,
        priceInUSD: price,
        imageUrl: 'https://www.cryptocompare.com$imageUrl',
      );
    }).toList();
    return cryptoCoinList;
  }

  @override
  Future<CryptoCoinDetails> getCryptoCoinDetails(String currencyCode) async {
    final response = await dio.get(
      'https://min-api.cryptocompare.com/data/pricemultifull?fsyms=$currencyCode&tsyms=USD',
    );
    final data = response.data as Map<String, dynamic>;
    final dataRaw = data['RAW'] as Map<String, dynamic>;
    final coinData = dataRaw[currencyCode] as Map<String, dynamic>;
    final usdData = coinData['USD'] as Map<String, dynamic>;
    final price = usdData['PRICE'];
    final imageUrl = usdData['IMAGEURL'];
    final toSymbol = usdData['TOSYMBOL'];
    final lastUpdate = usdData['LASTUPDATE'];
    final high24Hour = usdData['HIGH24HOUR'];
    final low24Hour = usdData['LOW24HOUR'];
    return CryptoCoinDetails(
      name: currencyCode,
      priceInUSD: price,
      imagUrl: 'https://www.cryptocompare.com$imageUrl',
      toSymbol: toSymbol,
      lastUpdate: DateTime.fromMicrosecondsSinceEpoch(lastUpdate),
      high24Hour: high24Hour,
      low24Hour: low24Hour,
    );
  }
}

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
}

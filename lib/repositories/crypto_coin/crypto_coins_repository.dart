import 'package:crypto_app/repositories/models/crypto_model.dart';
import 'package:dio/dio.dart';

class CryptoCoinsRepository {
  Future<List<CryptoCoin>> getCryptoCoins() async {
    final dio = Dio();
    final response = await dio.get(
      'https://min-api.cryptocompare.com/data/pricemulti?fsyms=BTC,ETH,BNB&tsyms=USD',
    );
    final data = response.data as Map<String, dynamic>;
    final cryptoCoinList = data.entries
        .map(
          (e) => CryptoCoin(
            name: e.key,
            priceInUSD: (e.value as Map<String, dynamic>)['USD'],
          ),
        )
        .toList();
    return cryptoCoinList;
  }
}

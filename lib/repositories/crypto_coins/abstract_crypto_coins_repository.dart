import 'models/models.dart';

abstract class AbstractCryptoCoinsRepository {
  Future<List<CryptoCoin>> getCryptoCoins();
  Future<CryptoCoinDetails> getCryptoCoinDetails(String currencyCode);
}

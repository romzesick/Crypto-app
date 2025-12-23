import 'models/models.dart';

abstract class AbstractCryptoCoinsRepository {
  Future<List<CryptoCoin>> getCryptoCoins();
  Future<CryptoCoin> getCryptoCoinDetails(String currencyCode);
}

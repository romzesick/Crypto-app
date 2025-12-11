import 'package:crypto_app/repositories/crypto_coins/models/crypto_model.dart';

abstract class AbstractCryptoCoinsRepository {
  Future<List<CryptoCoin>> getCryptoCoins();
}

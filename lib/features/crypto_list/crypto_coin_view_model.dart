import 'package:crypto_app/repositories/crypto_coin/crypto_coins_repository.dart';
import 'package:crypto_app/repositories/models/crypto_model.dart';
import 'package:flutter/material.dart';

class CryptoCoinsViewModel extends ChangeNotifier {
  final cryptoCoinsRepository = CryptoCoinsRepository();

  List<CryptoCoin>? _cryptoCoinList;
  List<CryptoCoin>? get cryptoCoinList => _cryptoCoinList;

  void getCryptoCoinsList() async {
    _cryptoCoinList = await cryptoCoinsRepository.getCryptoCoins();
    notifyListeners();
  }
}

import 'package:crypto_app/repositories/crypto_coin/crypto_coins_repository.dart';
import 'package:crypto_app/repositories/models/crypto_model.dart';
import 'package:flutter/material.dart';

class CryptoCoinsViewModel extends ChangeNotifier {
  final CryptoCoinsRepository cryptoCoinsRepository;

  CryptoCoinsViewModel({required this.cryptoCoinsRepository});

  List<CryptoCoin> _cryptoCoinList = [];
  List<CryptoCoin> get cryptoCoinList => _cryptoCoinList;

  String? _error;
  String? get error => _error;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  void getCryptoCoinsList() async {
    try {
      _isLoading = true;
      _error = null;
      final result = await cryptoCoinsRepository.getCryptoCoins();
      _cryptoCoinList = result;
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      _error = 'Couldnt upload data';
      notifyListeners();
    }
  }
}

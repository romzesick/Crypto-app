import 'package:crypto_app/repositories/crypto_coins/crypto_coins.dart';
import 'package:equatable/equatable.dart';

abstract class CryptoCoinDetailsState extends Equatable {}

class CryptoCoinDetailsInitial extends CryptoCoinDetailsState {
  @override
  List<Object?> get props => [];
}

class LoadingCryptoCoinDetail extends CryptoCoinDetailsState {
  @override
  List<Object?> get props => [];
}

class LoadedCryptoCoinDetail extends CryptoCoinDetailsState {
  LoadedCryptoCoinDetail({required this.cryptoCoin});

  final CryptoCoinDetails cryptoCoin;

  @override
  List<Object?> get props => [cryptoCoin];
}

class FailureCryptoCoinDetail extends CryptoCoinDetailsState {
  FailureCryptoCoinDetail({required this.exception});

  final Object? exception;

  @override
  List<Object?> get props => [exception];
}

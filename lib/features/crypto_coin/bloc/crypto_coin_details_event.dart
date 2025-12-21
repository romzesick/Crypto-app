import 'dart:async';

import 'package:equatable/equatable.dart';

abstract class CryptoCoinDetailsEvent extends Equatable {}

class LoadCryptoCoinDetails extends CryptoCoinDetailsEvent {
  LoadCryptoCoinDetails({this.completer, required this.cryptoCoinName});
  final Completer? completer;
  final String cryptoCoinName;

  @override
  List<Object?> get props => [completer];
}

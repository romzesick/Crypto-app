part of 'crypto_list_bloc.dart';

abstract class CryptoListBlocEvent extends Equatable {}

class LoadCryptoList extends CryptoListBlocEvent {
  final Completer? completer;

  LoadCryptoList({this.completer});

  @override
  List<Object?> get props => [completer];
}

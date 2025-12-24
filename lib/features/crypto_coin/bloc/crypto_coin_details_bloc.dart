import 'package:crypto_app/repositories/crypto_coins/crypto_coins.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'bloc.dart';

class CryptoCoinDetailsBloc
    extends Bloc<LoadCryptoCoinDetails, CryptoCoinDetailsState> {
  CryptoCoinDetailsBloc({required this.cryptoCoinsRepository})
    : super(CryptoCoinDetailsInitial()) {
    on<LoadCryptoCoinDetails>(_load);
  }
  final AbstractCryptoCoinsRepository cryptoCoinsRepository;

  Future<void> _load(
    LoadCryptoCoinDetails event,
    Emitter<CryptoCoinDetailsState> emit,
  ) async {
    try {
      if (state is! LoadedCryptoCoinDetail) {
        emit(LoadingCryptoCoinDetail());
      }
      final cryptoCoin = await cryptoCoinsRepository.getCryptoCoinDetails(
        event.cryptoCoinName,
      );
      emit(LoadedCryptoCoinDetail(cryptoCoin: cryptoCoin));
    } catch (e, st) {
      emit(FailureCryptoCoinDetail(exception: e));
      GetIt.I.get<Talker>().handle(e, st);
    } finally {
      event.completer?.complete();
    }
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    super.onError(error, stackTrace);
    GetIt.I.get<Talker>().handle(error, stackTrace);
  }
}

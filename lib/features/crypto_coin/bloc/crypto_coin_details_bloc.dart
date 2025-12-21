import 'package:crypto_app/repositories/crypto_coins/crypto_coins.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc.dart';

class CryptoCoinDetailsBloc
    extends Bloc<LoadCryptoCoinDetails, CryptoCoinDetailsState> {
  CryptoCoinDetailsBloc({required this.cryptoCoinsRepository})
    : super(CryptoCoinDetailsInitial()) {
    on<LoadCryptoCoinDetails>((event, emit) async {
      try {
        if (state is! LoadedCryptoCoinDetail) {
          emit(LoadingCryptoCoinDetail());
        }
        final cryptoCoin = await cryptoCoinsRepository.getCryptoCoinDetails(
          event.cryptoCoinName,
        );
        emit(LoadedCryptoCoinDetail(cryptoCoin: cryptoCoin));
      } catch (e) {
        emit(FailureCryptoCoinDetail(exception: e));
      } finally {
        event.completer?.complete();
      }
    });
  }
  final AbstractCryptoCoinsRepository cryptoCoinsRepository;
}

// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:crypto_app/repositories/crypto_coins/crypto_coins.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'crypto_list_event.dart';
part 'crypto_list_state.dart';

class CryptoListBloc extends Bloc<CryptoListBlocEvent, CryptoListBlocState> {
  CryptoListBloc(this.coinsRepository) : super(CryptoListBlocInitial()) {
    on<LoadCryptoList>((event, emit) async {
      try {
        if (state is! CryptoListLoaded) {
          emit(CryptoListLoading());
        }
        final coinsList = await coinsRepository.getCryptoCoins();
        emit(CryptoListLoaded(coinsList: coinsList));
      } catch (e) {
        emit(CryptoListLoadingFailure(exception: e));
      } finally {
        event.completer?.complete();
      }
    });
  }
  final AbstractCryptoCoinsRepository coinsRepository;
}

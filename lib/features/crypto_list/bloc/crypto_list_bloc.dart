// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:crypto_app/repositories/crypto_coins/crypto_coins.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:talker_flutter/talker_flutter.dart';

part 'crypto_list_event.dart';
part 'crypto_list_state.dart';

class CryptoListBloc extends Bloc<CryptoListBlocEvent, CryptoListBlocState> {
  CryptoListBloc(this.coinsRepository) : super(CryptoListBlocInitial()) {
    on<LoadCryptoList>(_load);
  }

  final AbstractCryptoCoinsRepository coinsRepository;

  Future<void> _load(
    LoadCryptoList event,
    Emitter<CryptoListBlocState> emit,
  ) async {
    try {
      if (state is! CryptoListLoaded) {
        emit(CryptoListLoading());
      }
      final coinsList = await coinsRepository.getCryptoCoins();
      emit(CryptoListLoaded(coinsList: coinsList));
    } catch (e, st) {
      emit(CryptoListLoadingFailure(exception: e));
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

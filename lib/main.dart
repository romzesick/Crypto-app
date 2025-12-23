import 'dart:async';
import 'dart:ui';

import 'package:crypto_app/crypto_coins_list_app.dart';
import 'package:crypto_app/firebase_options.dart';
import 'package:crypto_app/repositories/crypto_coins/crypto_coins.dart';
import 'package:dio/dio.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:talker_bloc_logger/talker_bloc_logger_observer.dart';
import 'package:talker_bloc_logger/talker_bloc_logger_settings.dart';
import 'package:talker_dio_logger/talker_dio_logger_interceptor.dart';
import 'package:talker_dio_logger/talker_dio_logger_settings.dart';
import 'package:talker_flutter/talker_flutter.dart';

void main() {
  final talker = TalkerFlutter.init();
  GetIt.I.registerSingleton<Talker>(talker);

  PlatformDispatcher.instance.onError = (error, stack) {
    talker.handle(error, stack);
    return true;
  };

  runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();

      final app = await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );

      talker.info(app.options.projectId);

      await Hive.initFlutter();
      Hive.registerAdapter(CryptoCoinDetailsAdapter());
      Hive.registerAdapter(CryptoCoinAdapter());

      const String cryptoCoinsBoxName = 'crypto_coins_box';

      final cryptoCoinsBox = await Hive.openBox<CryptoCoin>(cryptoCoinsBoxName);

      final dio = Dio();
      dio.interceptors.add(
        TalkerDioLogger(
          talker: talker,
          settings: const TalkerDioLoggerSettings(printResponseData: false),
        ),
      );
      Bloc.observer = TalkerBlocObserver(
        talker: talker,
        settings: const TalkerBlocLoggerSettings(printStateFullData: false),
      );

      GetIt.I.registerLazySingleton<AbstractCryptoCoinsRepository>(
        () => CryptoCoinsRepository(dio: dio, cryptoCoinsBox: cryptoCoinsBox),
      );

      FlutterError.onError = (details) =>
          talker.handle(details.exception, details.stack);

      runApp(const CryptoCoinsListApp());
    },
    (e, st) {
      talker.handle(e, st);
    },
  );
}

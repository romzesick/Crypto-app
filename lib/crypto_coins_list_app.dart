import 'package:crypto_app/router/routes.dart';
import 'package:crypto_app/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:talker_flutter/talker_flutter.dart';

class CryptoCoinsListApp extends StatefulWidget {
  const CryptoCoinsListApp({super.key});

  @override
  State<CryptoCoinsListApp> createState() => _CryptoCoinsListAppState();
}

class _CryptoCoinsListAppState extends State<CryptoCoinsListApp> {
  final _appRouter = AppRouter();
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Demo',
      theme: theme,
      routerConfig: _appRouter.config(
        navigatorObservers: () => [TalkerRouteObserver(GetIt.I.get<Talker>())],
      ),
    );
  }
}

import 'package:auto_route/auto_route.dart';
import 'package:crypto_app/features/crypto_coin/crypto_coin.dart';
import 'package:crypto_app/features/crypto_list/crypto_list.dart';
import 'package:crypto_app/repositories/crypto_coins/models/models.dart';
import 'package:flutter/material.dart';

part 'routes.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Screen,Widget,Page,Route')
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
    AutoRoute(page: CryptoCurencyListRoute.page, initial: true, path: '/'),
    AutoRoute(page: CryptoCoinWidgetRoute.page),
  ];
}

// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'routes.dart';

/// generated route for
/// [CryptoCoinWidget]
class CryptoCoinWidgetRoute extends PageRouteInfo<CryptoCoinWidgetRouteArgs> {
  CryptoCoinWidgetRoute({
    Key? key,
    required CryptoCoin coin,
    List<PageRouteInfo>? children,
  }) : super(
         CryptoCoinWidgetRoute.name,
         args: CryptoCoinWidgetRouteArgs(key: key, coin: coin),
         initialChildren: children,
       );

  static const String name = 'CryptoCoinWidgetRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<CryptoCoinWidgetRouteArgs>();
      return CryptoCoinWidget(key: args.key, coin: args.coin);
    },
  );
}

class CryptoCoinWidgetRouteArgs {
  const CryptoCoinWidgetRouteArgs({this.key, required this.coin});

  final Key? key;

  final CryptoCoin coin;

  @override
  String toString() {
    return 'CryptoCoinWidgetRouteArgs{key: $key, coin: $coin}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! CryptoCoinWidgetRouteArgs) return false;
    return key == other.key && coin == other.coin;
  }

  @override
  int get hashCode => key.hashCode ^ coin.hashCode;
}

/// generated route for
/// [CryptoCurencyList]
class CryptoCurencyListRoute extends PageRouteInfo<void> {
  const CryptoCurencyListRoute({List<PageRouteInfo>? children})
    : super(CryptoCurencyListRoute.name, initialChildren: children);

  static const String name = 'CryptoCurencyListRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const CryptoCurencyList();
    },
  );
}

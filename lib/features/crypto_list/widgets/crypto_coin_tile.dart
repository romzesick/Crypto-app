import 'package:auto_route/auto_route.dart';
import 'package:crypto_app/repositories/crypto_coins/crypto_coins.dart';
import 'package:crypto_app/router/routes.dart';
import 'package:flutter/material.dart';

class CryptoCoinTile extends StatelessWidget {
  const CryptoCoinTile({super.key, required this.coin});

  final CryptoCoin coin;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ListTile(
      leading: Image.network(
        coin.details.fullImageUrl,
        height: 40,
        width: 40,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stack) => const Icon(Icons.error),
      ),
      title: Text(coin.name, style: theme.textTheme.bodyMedium),
      subtitle: Text(
        '${coin.details.priceInUSD}\$',
        style: theme.textTheme.labelSmall,
      ),
      trailing: const Icon(Icons.arrow_forward_ios),
      onTap: () {
        AutoRouter.of(context).push(CryptoCoinWidgetRoute(coin: coin));
        // Navigator.pushNamed(context, '/coin', arguments: coin);
      },
    );
  }
}

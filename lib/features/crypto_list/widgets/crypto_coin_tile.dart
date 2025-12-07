import 'package:flutter/material.dart';

class CryptoCoinTile extends StatelessWidget {
  const CryptoCoinTile({super.key, required this.coinName});

  final String coinName;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ListTile(
      leading: const Image(
        height: 30,
        width: 30,
        fit: BoxFit.cover,
        image: AssetImage('images/bitcoin_logo.png'),
      ),
      title: Text(coinName, style: theme.textTheme.bodyMedium),
      subtitle: Text('20000\$', style: theme.textTheme.labelSmall),
      trailing: const Icon(Icons.arrow_forward_ios),
      onTap: () {
        Navigator.pushNamed(context, '/coin', arguments: coinName);
      },
    );
  }
}

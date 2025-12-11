import 'package:crypto_app/repositories/crypto_coins/models/crypto_model.dart';
import 'package:flutter/material.dart';

class CryptoCoinWidget extends StatefulWidget {
  const CryptoCoinWidget({super.key});

  @override
  State<CryptoCoinWidget> createState() => _CryptoCoinWidgetState();
}

class _CryptoCoinWidgetState extends State<CryptoCoinWidget> {
  CryptoCoin? coin;

  @override
  void didChangeDependencies() {
    final args = ModalRoute.of(context)!.settings.arguments;
    assert(
      args != null && args is CryptoCoin,
      'You must provide CryptoCoin args',
    );
    coin = args as CryptoCoin;
    setState(() {});
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(coin!.name)),
      body: Center(child: Text(coin!.name)),
    );
  }
}

import 'package:crypto_app/features/crypto_list/widgets/widgets.dart';
import 'package:crypto_app/repositories/crypto_coin/crypto_coins_repository.dart';
import 'package:crypto_app/repositories/models/crypto_model.dart';
import 'package:flutter/material.dart';

class CryptoCurencyList extends StatefulWidget {
  const CryptoCurencyList({super.key});

  @override
  State<CryptoCurencyList> createState() => _CryptoCurencyListState();
}

class _CryptoCurencyListState extends State<CryptoCurencyList> {
  List<CryptoCoin>? _cryptoCoinList;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            const SliverAppBar(
              title: Text('CryptoCurencyList'),
              floating: true,
            ),
            (_cryptoCoinList == null)
                ? const SliverToBoxAdapter(child: SizedBox())
                : SliverList.separated(
                    itemCount: _cryptoCoinList!.length,
                    itemBuilder: (context, index) {
                      final coin = _cryptoCoinList![index];
                      return CryptoCoinTile(coin: coin);
                    },
                    separatorBuilder: (context, index) => const Divider(),
                  ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final cryptoCoinList = await CryptoCoinsRepository().getCryptoCoins();
          _cryptoCoinList = cryptoCoinList;
          setState(() {});
        },
        child: const Icon(Icons.download),
      ),
    );
  }
}

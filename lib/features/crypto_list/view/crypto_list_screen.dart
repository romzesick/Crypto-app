import 'package:crypto_app/features/crypto_list/crypto_coin_view_model.dart';
import 'package:crypto_app/features/crypto_list/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CryptoCurencyList extends StatefulWidget {
  const CryptoCurencyList({super.key});

  @override
  State<CryptoCurencyList> createState() => _CryptoCurencyListState();
}

class _CryptoCurencyListState extends State<CryptoCurencyList> {
  @override
  Widget build(BuildContext context) {
    final cryptoCoinList = context.watch<CryptoCoinsViewModel>().cryptoCoinList;
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            const SliverAppBar(
              title: Text('CryptoCurencyList'),
              floating: true,
            ),
            (cryptoCoinList == null)
                ? const SliverToBoxAdapter(child: SizedBox())
                : SliverList.separated(
                    itemCount: cryptoCoinList.length,
                    itemBuilder: (context, index) {
                      final coin = cryptoCoinList[index];
                      return CryptoCoinTile(coin: coin);
                    },
                    separatorBuilder: (context, index) => const Divider(),
                  ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () =>
            context.read<CryptoCoinsViewModel>().getCryptoCoinsList(),
        child: const Icon(Icons.download),
      ),
    );
  }
}

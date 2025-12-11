import 'package:crypto_app/features/crypto_list/widgets/widgets.dart';
import 'package:crypto_app/repositories/crypto_coins/crypto_coins.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class CryptoCurencyList extends StatefulWidget {
  const CryptoCurencyList({super.key});

  @override
  State<CryptoCurencyList> createState() => _CryptoCurencyListState();
}

class _CryptoCurencyListState extends State<CryptoCurencyList> {
  List<CryptoCoin>? _cryptoCoinList;

  @override
  void initState() {
    _loadData();
    super.initState();
  }

  Future<void> _loadData() async {
    final cryptoCoinList = await GetIt.instance<CryptoCoinsRepository>()
        .getCryptoCoins();
    _cryptoCoinList = cryptoCoinList;
    setState(() {});
  }

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
                ? const SliverToBoxAdapter(
                    child: Center(child: CircularProgressIndicator()),
                  )
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
    );
  }
}

import 'package:crypto_app/features/crypto_list/widgets/widgets.dart';
import 'package:flutter/material.dart';

class CryptoCurencyList extends StatelessWidget {
  const CryptoCurencyList({super.key});

  @override
  Widget build(BuildContext context) {
    const coinName = 'BNB';
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            const SliverAppBar(
              title: Text('CryptoCurencyList'),
              floating: true,
            ),
            SliverList.separated(
              itemCount: 20,
              itemBuilder: (context, index) {
                return const CryptoCoinTile(coinName: coinName);
              },
              separatorBuilder: (context, index) => const Divider(),
            ),
          ],
        ),
      ),
    );
  }
}

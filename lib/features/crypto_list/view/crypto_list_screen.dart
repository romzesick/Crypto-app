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
    final model = context.watch<CryptoCoinsViewModel>();
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            const SliverAppBar(
              title: Text('CryptoCurencyList'),
              floating: true,
            ),
            if (model.isLoading == true)
              const SliverToBoxAdapter(
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: CircularProgressIndicator(color: Colors.white),
                  ),
                ),
              )
            else if (model.error != null)
              SliverToBoxAdapter(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Text(model.error!),
                  ),
                ),
              )
            else if (model.cryptoCoinList.isEmpty)
              const SliverToBoxAdapter(
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Text('Нажми на кнопку, чтобы загрузить данные'),
                  ),
                ),
              )
            else
              SliverList.separated(
                itemCount: model.cryptoCoinList.length,
                itemBuilder: (context, index) {
                  final coin = model.cryptoCoinList[index];
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

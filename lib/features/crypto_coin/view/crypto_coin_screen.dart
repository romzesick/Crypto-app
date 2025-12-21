import 'dart:async';

import 'package:crypto_app/features/crypto_coin/crypto_coin.dart';
import 'package:crypto_app/repositories/crypto_coins/crypto_coins.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class CryptoCoinWidget extends StatefulWidget {
  const CryptoCoinWidget({super.key});

  @override
  State<CryptoCoinWidget> createState() => _CryptoCoinWidgetState();
}

class _CryptoCoinWidgetState extends State<CryptoCoinWidget> {
  final _cryptoCoinDetailsBloc = CryptoCoinDetailsBloc(
    cryptoCoinsRepository: GetIt.I.get<AbstractCryptoCoinsRepository>(),
  );
  CryptoCoin? coin;

  @override
  void didChangeDependencies() {
    final args = ModalRoute.of(context)!.settings.arguments;
    assert(
      args != null && args is CryptoCoin,
      'You must provide CryptoCoin args',
    );
    coin = args as CryptoCoin;

    _cryptoCoinDetailsBloc.add(
      LoadCryptoCoinDetails(cryptoCoinName: coin!.name),
    );
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            RefreshIndicator(
              onRefresh: () {
                final completer = Completer();
                _cryptoCoinDetailsBloc.add(
                  LoadCryptoCoinDetails(
                    completer: completer,
                    cryptoCoinName: coin!.name,
                  ),
                );
                return completer.future;
              },
              child: ListView(
                physics: const AlwaysScrollableScrollPhysics(),
                children: [
                  BlocBuilder<CryptoCoinDetailsBloc, CryptoCoinDetailsState>(
                    bloc: _cryptoCoinDetailsBloc,
                    builder: (context, state) {
                      if (state is LoadedCryptoCoinDetail) {
                        final coin = state.cryptoCoin;
                        return Center(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 50),
                            child: Column(
                              children: [
                                Image.network(
                                  coin.imagUrl,
                                  width: 150,
                                  height: 150,
                                  errorBuilder: (context, error, stack) =>
                                      const Icon(Icons.error),
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  coin.name,
                                  style: theme.textTheme.bodyMedium?.copyWith(
                                    fontSize: 22,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                BaseCard(
                                  child: Center(
                                    child: Text(
                                      '${coin.priceInUSD.toStringAsFixed(2)} \$',
                                      style: theme.textTheme.labelMedium,
                                    ),
                                  ),
                                ),
                                BaseCard(
                                  child: Column(
                                    children: [
                                      _DataRow(
                                        title: 'Hight 24 Hour',
                                        value:
                                            '${coin.high24Hour.toStringAsFixed(2)} \$',
                                      ),
                                      const SizedBox(height: 6),
                                      _DataRow(
                                        title: 'Low 24 Hour',
                                        value:
                                            '${coin.low24Hour.toStringAsFixed(2)} \$',
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }
                      if (state is FailureCryptoCoinDetail) {
                        return SizedBox(
                          height: MediaQuery.of(context).size.height,
                          child: Center(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(Icons.error_outline, size: 40),
                                const SizedBox(height: 12),
                                const Text('Something went wrong'),
                                const SizedBox(height: 12),
                                ElevatedButton(
                                  onPressed: () {
                                    _cryptoCoinDetailsBloc.add(
                                      LoadCryptoCoinDetails(
                                        cryptoCoinName: coin!.name,
                                      ),
                                    );
                                  },
                                  child: const Text('Retry'),
                                ),
                              ],
                            ),
                          ),
                        );
                      }
                      return SizedBox(
                        height: MediaQuery.of(context).size.height,
                        child: const Center(child: CircularProgressIndicator()),
                      );
                    },
                  ),
                ],
              ),
            ),
            Positioned(
              top: 10,
              left: 10,
              child: IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.arrow_back_ios_new),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _cryptoCoinDetailsBloc.close();
    super.dispose();
  }
}

class _DataRow extends StatelessWidget {
  const _DataRow({required this.title, required this.value});

  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 140,
          child: Text(title, style: theme.textTheme.labelMedium),
        ),
        const SizedBox(width: 32),
        Flexible(child: Text(value, style: theme.textTheme.labelMedium)),
      ],
    );
  }
}

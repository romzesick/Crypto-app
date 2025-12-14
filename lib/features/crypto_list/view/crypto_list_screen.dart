import 'dart:async';

import 'package:crypto_app/features/crypto_list/bloc/crypto_list_bloc.dart';
import 'package:crypto_app/features/crypto_list/widgets/crypto_coin_tile.dart';
import 'package:crypto_app/repositories/crypto_coins/crypto_coins.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class CryptoCurencyList extends StatefulWidget {
  const CryptoCurencyList({super.key});

  @override
  State<CryptoCurencyList> createState() => _CryptoCurencyListState();
}

class _CryptoCurencyListState extends State<CryptoCurencyList> {
  final _cryptoListBloc = CryptoListBloc(
    GetIt.I.get<AbstractCryptoCoinsRepository>(),
  );

  @override
  void initState() {
    super.initState();
    _cryptoListBloc.add(LoadCryptoList());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            RefreshIndicator(
              onRefresh: () async {
                final completer = Completer();
                _cryptoListBloc.add(LoadCryptoList(completer: completer));
                return completer.future;
              },
              child: CustomScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                slivers: [
                  const SliverAppBar(
                    title: Text('CryptoCurencyList'),
                    floating: true,
                  ),
                  BlocBuilder<CryptoListBloc, CryptoListBlocState>(
                    bloc: _cryptoListBloc,
                    builder: (context, state) {
                      if (state is CryptoListLoaded) {
                        return SliverList.separated(
                          itemCount: state.coinsList.length,
                          itemBuilder: (context, index) {
                            final coin = state.coinsList[index];
                            return CryptoCoinTile(coin: coin);
                          },
                          separatorBuilder: (context, index) => const Divider(),
                        );
                      }
                      return const SliverToBoxAdapter(child: SizedBox.shrink());
                    },
                  ),
                ],
              ),
            ),
            BlocBuilder<CryptoListBloc, CryptoListBlocState>(
              bloc: _cryptoListBloc,
              builder: (context, state) {
                if (state is CryptoListLoaded) return const SizedBox.shrink();
                if (state is CryptoListLoadingFailure) {
                  final theme = Theme.of(context);
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Something went wrong',
                            textAlign: TextAlign.center,
                            style: theme.textTheme.bodyMedium,
                          ),
                          Text(
                            'Try again later or check your internet',
                            textAlign: TextAlign.center,
                            style: theme.textTheme.labelSmall?.copyWith(
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 8),
                          TextButton(
                            onPressed: () =>
                                _cryptoListBloc.add(LoadCryptoList()),
                            child: const Text('Reload'),
                          ),
                        ],
                      ),
                    ),
                  );
                }

                return const Positioned.fill(
                  child: Center(child: CircularProgressIndicator()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _cryptoListBloc.close();
    super.dispose();
  }
}

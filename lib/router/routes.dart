import 'package:crypto_app/features/crypto_coin/crypto_coin.dart';
import 'package:crypto_app/features/crypto_list/crypto_coin_view_model.dart';
import 'package:crypto_app/features/crypto_list/crypto_list.dart';
import 'package:provider/provider.dart';

final routes = {
  '/': (context) => ChangeNotifierProvider(
    create: (context) => CryptoCoinsViewModel(),
    child: const CryptoCurencyList(),
  ),
  '/coin': (context) => const CryptoCoinWidget(),
};

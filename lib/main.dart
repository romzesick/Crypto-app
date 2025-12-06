import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    const primaryColor = Color.fromARGB(255, 31, 31, 31);
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        scaffoldBackgroundColor: primaryColor,
        primaryColor: primaryColor,
        colorScheme: .fromSeed(seedColor: primaryColor),
        dividerTheme: const DividerThemeData(color: Colors.white24),
        listTileTheme: const ListTileThemeData(iconColor: Colors.white24),
        appBarTheme: const AppBarTheme(
          centerTitle: true,
          backgroundColor: primaryColor,
          surfaceTintColor: Colors.transparent,
          elevation: 2,
          shadowColor: Colors.white24,
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w700,
            fontSize: 22,
          ),
          iconTheme: IconThemeData(color: Colors.white),
        ),
        textTheme: TextTheme(
          bodyMedium: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w500,
            fontSize: 20,
          ),
          labelSmall: TextStyle(
            color: Colors.white.withOpacity(0.6),
            fontWeight: FontWeight.w700,
            fontSize: 14,
          ),
        ),
      ),
      routes: {
        '/': (context) => const CryptoCurencyList(),
        '/coin': (context) => const CryptoCoin(),
      },
    );
  }
}

class CryptoCurencyList extends StatelessWidget {
  const CryptoCurencyList({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    const coinName = 'BNB';
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            const SliverAppBar(
              title: Text('CryptoCurencyList'),
              centerTitle: true,
              floating: true,
            ),
            SliverList.separated(
              itemCount: 20,
              itemBuilder: (context, index) {
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
              },
              separatorBuilder: (context, index) => const Divider(),
            ),
          ],
        ),
      ),
    );
  }
}

class CryptoCoin extends StatefulWidget {
  const CryptoCoin({super.key});

  @override
  State<CryptoCoin> createState() => _CryptoCoinState();
}

class _CryptoCoinState extends State<CryptoCoin> {
  String? coinName;

  @override
  void didChangeDependencies() {
    final args = ModalRoute.of(context)!.settings.arguments;
    if (args == null) {
      print('You must provide args');
      return;
    }
    if (args != String) {
      print('You must provide String');
      return;
    }
    coinName = args as String;
    setState(() {});
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(coinName ?? '...')),
      body: const Center(child: Text('Crypto coin')),
    );
  }
}

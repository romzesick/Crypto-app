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
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
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
                  title: Text('Bitcoin', style: theme.textTheme.bodyMedium),
                  subtitle: Text('20000\$', style: theme.textTheme.labelSmall),
                  trailing: const Icon(Icons.arrow_forward_ios),
                );
              },
              separatorBuilder: (context, index) => const Divider(),
            ),
          ],
        ),
      ),
      // appBar: AppBar(title: const Text('CryptoCurencyList'), centerTitle: true),
      // body: ListView.separated(
      //   itemCount: 20,
      //   itemBuilder: (context, index) {
      //     return ListTile(
      //       leading: const Image(
      //         height: 30,
      //         width: 30,
      //         fit: BoxFit.cover,
      //         image: AssetImage('images/bitcoin_logo.png'),
      //       ),
      //       title: Text('Bitcoin', style: theme.textTheme.bodyMedium),
      //       subtitle: Text('20000\$', style: theme.textTheme.labelSmall),
      //       trailing: const Icon(Icons.arrow_forward_ios),
      //     );
      //   },
      //   separatorBuilder: (context, index) => const Divider(),
      // ),
    );
  }
}

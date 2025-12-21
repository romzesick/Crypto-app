import 'package:flutter/material.dart';

const primaryColor = Color.fromARGB(255, 31, 31, 31);
final theme = ThemeData(
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
    labelMedium: const TextStyle(color: Colors.white, fontSize: 17),
  ),
  iconButtonTheme: const IconButtonThemeData(
    style: ButtonStyle(iconColor: WidgetStatePropertyAll(Colors.white)),
  ),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: Colors.white24,
    foregroundColor: Colors.white,
  ),
  progressIndicatorTheme: const ProgressIndicatorThemeData(color: Colors.white),
);

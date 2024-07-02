import 'package:flutter/material.dart';
import 'widgets/expenses.dart';
var kColorScheme= ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 108, 53, 227));
var kDarkColorScheme=ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 28, 6, 77));
void main(){
  runApp(MaterialApp(
    darkTheme: ThemeData.dark().copyWith(
      colorScheme: kDarkColorScheme
    ),
    theme: ThemeData().copyWith(
          colorScheme: kColorScheme,
          appBarTheme: AppBarTheme().copyWith(
            backgroundColor: kColorScheme.onPrimaryContainer,
            foregroundColor: kColorScheme.primaryContainer,
            ),
            cardTheme: CardTheme().copyWith(
              color: kColorScheme.secondaryContainer,
              margin: EdgeInsets.symmetric(vertical: 8,horizontal: 16),
            ),
            elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                backgroundColor: kColorScheme.primaryContainer

              )
            ),
            textTheme: ThemeData().textTheme.copyWith(
              titleLarge: TextStyle(
                fontWeight: FontWeight.normal,
                color: kColorScheme.onSecondaryContainer,
                fontSize: 18
              )
            )
    ),
    themeMode: ThemeMode.light,
    home:const Expenses(),
  
  ));
}
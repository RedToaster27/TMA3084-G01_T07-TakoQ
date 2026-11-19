import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'screens/kitchen_screen.dart';

void main() {
  runApp(const ProviderScope(child: TakoQApp()));
}

class TakoQApp extends StatelessWidget {
  const TakoQApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TakoQ Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF2F6B4F),
          primary: const Color(0xFF2F6B4F),
          secondary: const Color(0xFFE87524),
          surface: const Color(0xFFF7F4EF),
        ),
      ),
      home: const KitchenScreen(),
    );
  }
}
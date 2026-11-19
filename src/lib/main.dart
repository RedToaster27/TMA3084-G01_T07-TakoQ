import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'screens/customer_board_screen.dart';
import 'screens/kitchen_screen.dart';
import 'screens/new_order_screen.dart';
void main() {
  runApp(const ProviderScope(child: TakoQApp()));
}
class TakoQApp extends StatelessWidget {
  const TakoQApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TakoQ Demo 1',
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
      home: const DemoShell(),
    );
  }
}
class DemoShell extends StatefulWidget {
  const DemoShell({super.key});
  @override
  State<DemoShell> createState() => _DemoShellState();
}
class _DemoShellState extends State<DemoShell> {
  int index = 0;
  @override
  Widget build(BuildContext context) {
    final pages = [
      const NewOrderScreen(),
      const KitchenScreen(),
      const CustomerBoardScreen(),
    ];
    return Scaffold(
      body: pages[index],
      bottomNavigationBar: NavigationBar(
        selectedIndex: index,
        onDestinationSelected: (i) {
          if (i == 3) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text(
                  'Search — Coming soon (Demo 1 out of scope)',
                ),
              ),
            );
            return;
          }
          setState(() => index = i);
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.add_circle_outline),
            label: 'New Order',
          ),
          NavigationDestination(
            icon: Icon(Icons.list_alt),
            label: 'Kitchen',
          ),
          NavigationDestination(
            icon: Icon(Icons.tv),
            label: 'Board',
          ),
          NavigationDestination(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
        ],
      ),
    );
  }
}

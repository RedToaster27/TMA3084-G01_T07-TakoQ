import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/order.dart';
import '../providers/order_provider.dart';

class CustomerBoardScreen extends ConsumerWidget {
  const CustomerBoardScreen({super.key});
  
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final orders = ref.watch(orderListProvider);
    final preparing = orders
        .where((o) => o.status == OrderStatus.preparing)
        .map((o) => o.queueNumber)
        .toList();
    final ready = orders
        .where((o) => o.status == OrderStatus.readyForPickup)
        .map((o) => o.queueNumber)
        .toList();

    return Scaffold(
      backgroundColor: const Color(0xFF1A1A1A),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
              child: Row(
                children: [
                  const Text(
                    'TakoQ',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFE8F5E9),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Text(
                        'AI SMART QUEUE ESTIMATE  ·  Approx. 8–12 minutes\n(Static for Demo 1 — Gemini later)',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xFF2F6B4F),
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    'NOW SERVING',
                    style: TextStyle(
                      color: Colors.grey.shade400,
                      fontSize: 11,
                      letterSpacing: 1,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: _StatusColumn(
                      title: 'PREPARING',
                      headerColor: const Color(0xFFE87524),
                      numbers: preparing,
                      numberColor: const Color(0xFFE87524),
                    ),
                  ),
                  Expanded(
                    child: _StatusColumn(
                      title: 'READY FOR PICKUP',
                      subtitle: 'PLEASE COLLECT AT COUNTER',
                      headerColor: const Color(0xFF2F6B4F),
                      numbers: ready,
                      numberColor: const Color(0xFF81C784),
                      boxed: true,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StatusColumn extends StatelessWidget {
  const _StatusColumn({
    required this.title,
    required this.headerColor,
    required this.numbers,
    required this.numberColor,
    this.subtitle,
    this.boxed = false,
  });

  final String title;
  final String? subtitle;
  final Color headerColor;
  final List<String> numbers;
  final Color numberColor;
  final bool boxed;
  
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 8),
          color: headerColor,
          child: Column(
            children: [
              if (subtitle != null)
                Text(
                  subtitle!,
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Container(
            color: Colors.black,
            child: numbers.isEmpty
                ? Center(
                    child: Text(
                      '—',
                      style: TextStyle(
                        color: Colors.grey.shade700,
                        fontSize: 40,
                      ),
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(vertical: 24),
                    itemCount: numbers.length,
                    itemBuilder: (context, index) {
                      final n = numbers[index];
                      final text = Text(
                        n,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: numberColor,
                          fontSize: 56,
                          fontWeight: FontWeight.bold,
                          height: 1.1,
                        ),
                      );
                      if (!boxed) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          child: text,
                        );
                      }
                      return Container(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 10,
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: numberColor, width: 2),
                        ),
                        child: text,
                      );
                    },
                  ),
          ),
        ),
      ],
    );
  }
}

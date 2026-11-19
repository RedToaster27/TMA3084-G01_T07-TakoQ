import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/order.dart';
import '../providers/order_provider.dart';

class KitchenScreen extends ConsumerWidget {
    const KitchenScreen({super.key});

    @override
    Widget build(BuildContext context, WidgetRef ref){
        final order = ref.watch(orderListProvider);
        final preparing = 
            order.where((o) => o.status == OrderStatus.preparing).toList();

            return Scaffold(
                backgroundColor: const Color(0xFFF7F4EF),
                appBar: AppBar(
                    backgroundColor: const Color(0xFF2F6B4F),
                    foregroundColor: Colors.white,
                ),
                body: ListView(
                    padding: const EdgeInsets.all(16),
                    children: [
                        Card(
                            color: const Color(0xFFE8F5E9),
                            child: const ListTile(
                                title: Text (
                                    'Current queue updates live. Approx. 8-12 minutes.\n(Static banner for Demo 1 - Gemini later)',
                                ),
                            ),
                        ),
                        const SizedBox (height: 12),
                        if (preparing.isEmpty)
                        const Padding(
                            padding: EdgeInsets.all(24),
                            child: Text('No preparing orders yet. Use Create Order.'),

                        ),
                        for (final order in preparing)
                        Card(
                            child: ListTile(
                                leading: Text(
                                    '#${order.queueNumber}',
                                    style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xFFE87524),
                                    ),
                                ),
                                title: Text(order.customerName ?? 'Walk-in'),
                                subtitle: const Text('PREPARING'),
                                trailing: FilledButton(
                                    onPressed: (){
                                        ref.read(orderListProvider.notifier).markReady(order.id);
                                    },
                                    child: const Text('MARK AS READY'),
                                ),
                            ),
                        ),
                        const SizedBox(height: 16),
                        FilledButton.tonal(
                            onPressed: (){
                                ref
                                    .read(orderListProvider.notifier)
                                    .createOrder(customerName: 'Test');
                            },
                            child: const Text('TEMP: Add test order'),
                        ),
                    ],
                ),
            );
    }
}
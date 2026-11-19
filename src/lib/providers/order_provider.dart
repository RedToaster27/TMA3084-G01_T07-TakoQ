import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/order.dart';

class OrderListNotifier extends StateNotifier<List<Order>> {
    OrderListNotifier() : super(const []);
    int _next = 1;

    void createOrder({String? customerName}){
        final raw = customerName?.trim();
        final queue = _next.toString().padLeft(3,'0');
        _next++;
        state = [
            ...state,
            Order(
                id: DateTime.now().millisecondsSinceEpoch.toString(),
                queueNumber: queue,
                customerName: (raw == null || raw.isEmpty) ? null : raw,
                status: OrderStatus.preparing,
            ),

        ];

    }

    void markReady(String id) {
        state = [
            for (final order in state)
            if (order.id ==id)
            order.copyWith(status: OrderStatus.readyForPickup)
            else 
            order,
        ];
    }
}

final orderListProvider = 
StateNotifierProvider<OrderListNotifier, List<Order>>(
    (ref) => OrderListNotifier(),
);
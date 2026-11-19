enum OrderStatus {preparing, readyForPickup}

class Order{
    final String id;
    final String queueNumber;
    final String? customerName;
    final OrderStatus status;

    const Order({
        required this.id,
        required this.queueNumber,
        this.customerName,
        required this.status,
    });

    Order copyWith({OrderStatus? status}) {
        return Order(
            id: id,
            queueNumber: queueNumber,
            customerName: customerName,
            status: status ?? this.status,
        );
    }
}
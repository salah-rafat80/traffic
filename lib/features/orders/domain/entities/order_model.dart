enum OrderStatus {
  pending,
  completed,
  needsData,
  awaitingAppointment,
  passed,
  failed,
}

class OrderModel {
  final String id;
  final String title;
  final String date;
  final OrderStatus status;

  const OrderModel({
    required this.id,
    required this.title,
    required this.date,
    required this.status,
  });
}

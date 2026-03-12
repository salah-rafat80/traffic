enum OrderStatus {
  pending,
  completed,
  needsData,
  awaitingAppointment,
  passed,
  failed,
}

class OrderModel {
  final String title;
  final String date;
  final OrderStatus status;

  const OrderModel({
    required this.title,
    required this.date,
    required this.status,
  });
}

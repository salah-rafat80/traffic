import 'package:flutter/widgets.dart';
import 'package:traffic/core/features/payment/data/repositories/payment_repository.dart';
import 'package:traffic/injection_container.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  configureDependencies();
  final repo = getIt<PaymentRepository>();
  
  try {
    final response = await repo.createPayment(serviceRequestNumber: "DL-500");
    print("\n--- PAYMENT URL ---");
    print(response.paymentUrl);
    print("--- TOKEN ---");
    print(response.paymentToken);
  } catch (e) {
    print("Error: $e");
  }
}

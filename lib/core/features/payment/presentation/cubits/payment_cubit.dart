import 'dart:developer' as developer;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:traffic/core/features/payment/data/repositories/payment_repository.dart';
import 'package:traffic/core/features/payment/presentation/cubits/payment_state.dart';

@injectable
class PaymentCubit extends Cubit<PaymentState> {
  final PaymentRepository _repository;

  PaymentCubit(this._repository) : super(const PaymentInitial());

  Future<void> initiatePayment({
    String? serviceRequestNumber,
    List<int>? violationIds,
    double? amount,
  }) async {
    developer.log('State Transition: PaymentLoading emitted', name: 'PaymentCubit');
    emit(const PaymentLoading());
    try {
      final response = await _repository.createPayment(
        serviceRequestNumber: serviceRequestNumber,
        violationIds: violationIds,
        amount: amount,
      );
      developer.log('State Transition: PaymentInitSuccess emitted', name: 'PaymentCubit');
      emit(PaymentInitSuccess(response));
    } catch (e) {
      developer.log('State Transition: PaymentFailure emitted. Error: $e', name: 'PaymentCubit');
      emit(PaymentFailure(e.toString().replaceAll('Exception: ', '')));
    }
  }
}

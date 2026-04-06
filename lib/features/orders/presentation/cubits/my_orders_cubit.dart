import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/repositories/service_requests_repository.dart';
import 'my_orders_state.dart';

class MyOrdersCubit extends Cubit<MyOrdersState> {
  final ServiceRequestsRepository _repository;

  MyOrdersCubit(this._repository) : super(MyOrdersInitial());

  Future<void> fetchMyOrders() async {
    emit(MyOrdersLoading());
    final result = await _repository.fetchMyRequests();
    if (result.isSuccess) {
      emit(MyOrdersFetchSuccess(orders: result.data ?? []));
    } else {
      emit(MyOrdersFailure(message: result.error ?? 'حدث خطأ غير متوقع.'));
    }
  }
}

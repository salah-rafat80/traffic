import '../../domain/entities/order_model.dart';

abstract class MyOrdersState {}

class MyOrdersInitial extends MyOrdersState {}

class MyOrdersLoading extends MyOrdersState {}

class MyOrdersFetchSuccess extends MyOrdersState {
  final List<OrderModel> orders;
  MyOrdersFetchSuccess({required this.orders});
}

class MyOrdersFailure extends MyOrdersState {
  final String message;
  MyOrdersFailure({required this.message});
}

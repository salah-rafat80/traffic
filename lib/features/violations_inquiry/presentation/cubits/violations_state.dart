import 'package:traffic/features/violations_inquiry/data/models/violation_model.dart';

abstract class ViolationsState {}

class ViolationsInitial extends ViolationsState {}

class ViolationsLoading extends ViolationsState {}

class ViolationsLoaded extends ViolationsState {
  final ViolationsListModel violationsList;

  ViolationsLoaded({required this.violationsList});
}

class ViolationsFailure extends ViolationsState {
  final String message;

  ViolationsFailure({required this.message});
}

import '../../data/models/staff_appointment_model.dart';

abstract class ExaminerState {}

class ExaminerInitial extends ExaminerState {}

class ExaminerLoading extends ExaminerState {}

class ExaminerAppointmentsLoaded extends ExaminerState {
  final List<StaffAppointmentModel> appointments;
  ExaminerAppointmentsLoaded(this.appointments);
}

class ExaminerSubmitLoading extends ExaminerState {}

class ExaminerSubmitSuccess extends ExaminerState {
  final bool passed;
  ExaminerSubmitSuccess(this.passed);
}

class ExaminerFailure extends ExaminerState {
  final String message;
  ExaminerFailure(this.message);
}

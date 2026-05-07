import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../data/repositories/examiner_repository.dart';
import 'examiner_state.dart';

@injectable
class ExaminerCubit extends Cubit<ExaminerState> {
  final ExaminerRepository _repository;

  ExaminerCubit(this._repository) : super(ExaminerInitial());

  Future<void> getAppointments() async {
    print('🚀 ExaminerCubit: Fetching appointments...');
    emit(ExaminerLoading());
    final result = await _repository.getAppointments();
    if (result.isSuccess) {
      print('✅ ExaminerCubit: Loaded ${result.data?.length} appointments');
      emit(ExaminerAppointmentsLoaded(result.data ?? []));
    } else {
      print('❌ ExaminerCubit: Error - ${result.error}');
      emit(ExaminerFailure(result.error ?? 'حدث خطأ غير متوقع.'));
    }
  }

  Future<void> submitResult({
    required String requestNumber,
    required bool passed,
  }) async {
    emit(ExaminerSubmitLoading());
    final result = await _repository.submitResult(
      requestNumber: requestNumber,
      passed: passed,
    );
    if (result.isSuccess) {
      emit(ExaminerSubmitSuccess(passed));
    } else {
      emit(ExaminerFailure(result.error ?? 'حدث خطأ غير متوقع.'));
    }
  }
}

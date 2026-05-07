import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../data/models/issue_replacement_response_model.dart';
import '../../data/repositories/vehicle_license_repository.dart';
import '../../../driving_license/data/models/driving_renewal_model.dart';
import 'vehicle_renewal_state.dart';

@injectable
class VehicleRenewalCubit extends Cubit<VehicleRenewalState> {
  final VehicleLicenseRepository repository;

  VehicleRenewalCubit(this.repository) : super(VehicleRenewalInitial());

  Future<void> renewVehicleLicense({required String licenseNumber}) async {
    emit(VehicleRenewalLoading());
    final result = await repository.renewVehicleLicense(licenseNumber: licenseNumber);

    if (isClosed) return;

    if (result.isSuccess && result.data != null) {
      emit(VehicleRenewalSuccess(result.data!));
    } else {
      emit(VehicleRenewalFailure(result.error ?? 'حدث خطأ غير متوقع'));
    }
  }

  Future<void> bookAppointment({
    required String governorateId,
    required String trafficUnitId,
    required DateTime date,
    required String startTime,
    required String requestNumber,
  }) async {
    emit(VehicleRenewalLoading());

    final request = AppointmentBookingRequestModel(
      governorateId: governorateId,
      trafficUnitId: trafficUnitId,
      type: AppointmentType.technical,
      date: "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
      startTime: startTime,
      requestNumber: requestNumber,
    );

    final result = await repository.bookAppointment(request: request);

    if (isClosed) return;

    if (result.isSuccess) {
      emit(VehicleRenewalSuccess(IssueReplacementResponseModel(
        requestNumber: requestNumber,
        status: 'booked',
        citizenNationalId: '',
        serviceType: 'VehicleRenewal',
        message: 'تم حجز الموعد بنجاح',
      )));
    } else {
      emit(VehicleRenewalFailure(result.error ?? 'حدث خطأ في حجز الموعد'));
    }
  }

  Future<void> finalizeVehicleRenewal({
    required String requestNumber,
    required int method,
    String? governorate,
    String? city,
    String? details,
  }) async {
    emit(VehicleRenewalLoading());
    final result = await repository.finalizeVehicleRenewal(
      requestNumber: requestNumber,
      method: method,
      governorate: governorate,
      city: city,
      details: details,
    );

    if (isClosed) return;

    if (result.isSuccess && result.data != null) {
      emit(VehicleRenewalSuccess(result.data!));
    } else {
      emit(VehicleRenewalFailure(result.error ?? 'حدث خطأ غير متوقع'));
    }
  }
}

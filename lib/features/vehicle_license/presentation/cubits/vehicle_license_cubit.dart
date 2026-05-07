import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../data/repositories/vehicle_license_repository.dart';
import '../../data/models/vehicle_type_model.dart';
import 'package:traffic/features/profile/data/repositories/profile_repository.dart';
import 'vehicle_license_state.dart';

@injectable
class VehicleLicenseCubit extends Cubit<VehicleLicenseState> {
  final VehicleLicenseRepository _repository;
  final ProfileRepository _profileRepository;

  VehicleLicenseCubit(this._repository, this._profileRepository)
      : super(VehicleLicenseInitial());

  String? currentRequestNumber;

  List<VehicleTypeModel> cachedVehicleTypes = [];
  List<InsuranceCompanyModel> cachedInsuranceCompanies = [];

  Future<void> fetchInitData() async {
    emit(VehicleLicenseLoading());

    final typesResult = await _repository.getVehicleTypes();

    if (typesResult.isSuccess && typesResult.data != null) {
      cachedVehicleTypes = typesResult.data!;
      emit(VehicleLicenseInitDataSuccess(vehicleTypes: cachedVehicleTypes));
    } else {
      // Seed cache with static fallback so enum resolution works offline.
      cachedVehicleTypes = VehicleTypeModel.fallbackTypes;
      emit(
        VehicleLicenseFailure(
          message: typesResult.error ?? 'حدث خطأ في تحميل أنواع المركبات.',
        ),
      );
    }
  }

  /// Fetches insurance companies only — used by [VehicleInsuranceScreen].
  Future<void> fetchInsuranceCompanies() async {
    emit(VehicleLicenseInsuranceLoading());
    final result = await _repository.getInsuranceCompanies();
    if (isClosed) return;
    if (result.isSuccess && result.data != null && result.data!.isNotEmpty) {
      cachedInsuranceCompanies = result.data!;
      emit(VehicleLicenseInsuranceLoaded(companies: cachedInsuranceCompanies));
    } else if (result.isSuccess && (result.data?.isEmpty ?? true)) {
      emit(VehicleLicenseFailure(message: 'لا توجد شركات تأمين متاحة حاليًا.'));
    } else {
      emit(VehicleLicenseFailure(message: result.error ?? 'تعذر تحميل شركات التأمين.'));
    }
  }

  Future<void> uploadDocuments({
    required String vehicleType,
    required String brand,
    required String model,
    required String ownershipProofPath,
    required String vehicleDataCertificatePath,
    required String idCardPath,
    required String insuranceCompanyId,
    String? insuranceCertificatePath,
    String? customClearancePath,
  }) async {
    emit(VehicleLicenseLoading());
    final result = await _repository.uploadDocuments(
      vehicleType: vehicleType,
      brand: brand,
      model: model,
      ownershipProofPath: ownershipProofPath,
      vehicleDataCertificatePath: vehicleDataCertificatePath,
      idCardPath: idCardPath,
      insuranceCompanyId: insuranceCompanyId,
      insuranceCertificatePath: insuranceCertificatePath,
      customClearancePath: customClearancePath,
    );

    if (result.isSuccess && result.data != null) {
      currentRequestNumber = result.data;
      emit(VehicleLicenseUploadSuccess(requestNumber: result.data!));
    } else {
      emit(
        VehicleLicenseFailure(
          message: result.error ?? 'حدث خطأ أثناء رفع المستندات.',
        ),
      );
    }
  }

  Future<void> finalizeLicense({
    required int method,
    String? governorate,
    String? city,
    String? details,
  }) async {
    if (currentRequestNumber == null) {
      emit(
        VehicleLicenseFailure(
          message: 'رقم الطلب مفقود، يجب رفع المستندات أولاً.',
        ),
      );
      return;
    }

    emit(VehicleLicenseLoading());

    final result = await _repository.finalizeLicense(
      requestNumber: currentRequestNumber!,
      method: method,
      governorate: governorate,
      city: city,
      details: details,
    );

    if (result.isSuccess && result.data != null) {
      // Fetch user profile for the order review screen
      final profileResult = await _profileRepository.getProfile();
      if (profileResult.isSuccess && profileResult.data != null) {
        emit(VehicleLicenseFinalizeSuccess(
          response: result.data!,
          profile: profileResult.data!,
        ));
      } else {
        emit(VehicleLicenseFailure(
          message: profileResult.error ?? 'فشل استلام بيانات الملف الشخصي.',
        ));
      }
    } else {
      emit(
        VehicleLicenseFailure(
          message: result.error ?? 'حدث خطأ أثناء إتمام العملية.',
        ),
      );
    }
  }

  Future<void> getMyLicenses({bool forceRefresh = false}) async {
    if (!forceRefresh) {
      final cached = await _repository.getLocalLicenses();
      if (cached.isNotEmpty) {
        emit(
          VehicleLicenseLoadLicensesSuccess(licenses: cached, isCached: true),
        );
        // Soft refresh
        final result = await _repository.getMyLicenses();
        if (result.isSuccess && result.data != null) {
          await _repository.saveLicensesLocal(result.data!);
          emit(
            VehicleLicenseLoadLicensesSuccess(
              licenses: result.data!,
            ),
          );
        }
        return;
      }
    }

    emit(VehicleLicenseLoading());
    final result = await _repository.getMyLicenses();

    if (result.isSuccess && result.data != null) {
      await _repository.saveLicensesLocal(result.data!);
      emit(
        VehicleLicenseLoadLicensesSuccess(
          licenses: result.data!,
        ),
      );
    } else {
      emit(
        VehicleLicenseFailure(
          message: result.error ?? 'حدث خطأ أثناء استرجاع الرخص.',
        ),
      );
    }
  }
}

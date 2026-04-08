import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../core/api/api_client.dart';
import '../../../../../../core/widgets/generic_document_upload_screen.dart';
import '../../../data/repositories/driving_license_repository.dart';
import '../../cubits/driving_license_cubit.dart';
import '../../cubits/driving_license_state.dart';
import '../medical_check/medical_check_screen.dart';
import '../finalize/finalize_driving_license_screen.dart';

class DrivingLicenseUploadDocumentsScreen extends StatelessWidget {
  const DrivingLicenseUploadDocumentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => DrivingLicenseCubit(
        DrivingLicenseRepository(ApiClient()),
      ),
      child: const _DrivingLicenseUploadDocumentsContent(),
    );
  }
}

class _DrivingLicenseUploadDocumentsContent extends StatefulWidget {
  const _DrivingLicenseUploadDocumentsContent();

  @override
  State<_DrivingLicenseUploadDocumentsContent> createState() =>
      _DrivingLicenseUploadDocumentsContentState();
}

class _DrivingLicenseUploadDocumentsContentState
    extends State<_DrivingLicenseUploadDocumentsContent> {
  late final List<DocumentItemModel> _documents;

  @override
  void initState() {
    super.initState();
    // Initialize once to retain uploaded files during Cubit state rebuilds
    _documents = [
      DocumentItemModel(title: 'شهادة المؤهل الدراسي', isRequired: true),
      DocumentItemModel(title: 'صور شخصية حديثة', isRequired: true),
      DocumentItemModel(title: 'صورة البطاقة الشخصية (وجه + ظهر)', isRequired: true),
      DocumentItemModel(title: 'إثبات محل الإقامة', isRequired: false),
      DocumentItemModel(title: 'شهادة طبية', isRequired: false),
    ];
  }

  void _onProceed(Map<String, String> selectedDropdowns) {
    final personalPhoto = _documents.firstWhere((d) => d.title == 'صور شخصية حديثة').filePath;
    final idCard = _documents.firstWhere((d) => d.title == 'صورة البطاقة الشخصية (وجه + ظهر)').filePath;
    final educationalCertificate = _documents.firstWhere((d) => d.title == 'شهادة المؤهل الدراسي').filePath;
    final residenceProof = _documents.firstWhere((d) => d.title == 'إثبات محل الإقامة').filePath;

    if (personalPhoto == null || idCard == null || educationalCertificate == null) {
      // the generic screen validater should catch this but just in case
      return;
    }

    context.read<DrivingLicenseCubit>().uploadDocuments(
          category: selectedDropdowns['فئة الرخصة'] ?? '',
          governorate: selectedDropdowns['المحافظة'] ?? '',
          licensingUnit: selectedDropdowns['وحدة المرور'] ?? '',
          personalPhotoPath: personalPhoto,
          idCardPath: idCard,
          educationalCertificatePath: educationalCertificate,
          residenceProofPath: residenceProof,
        );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DrivingLicenseCubit, DrivingLicenseState>(
      listener: (context, state) {
        if (state is DrivingLicenseUploadSuccess) {
          // Pass the generated requestNumber through the rest of the flow
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => MedicalCheckScreen(
                appBarTitle: 'اصدار رخصة قيادة',
                onNextPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => BlocProvider.value(
                        value: context.read<DrivingLicenseCubit>(),
                        child: FinalizeDrivingLicenseScreen(
                          requestNumber: state.requestNumber,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          );
        } else if (state is DrivingLicenseFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                state.message,
                textDirection: TextDirection.rtl,
              ),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      builder: (context, state) {
        return Stack(
          children: [
            GenericDocumentUploadScreen(
              appBarTitle: 'اصدار رخصة قيادة',
              subtitle:
                  'يرجى رفع المستندات التالية لإتمام إجراءات إصدار رخصة قيادة. يجب أن تكون الصور واضحة ومقروءة.',
              dropdowns: const [
                DropdownConfig(
                  title: 'المحافظة',
                  hint: 'اختر المحافظة',
                  options: ['القاهرة', 'الجيزة', 'الإسكندرية'],
                ),
                DropdownConfig(
                  title: 'وحدة المرور',
                  hint: 'اختر وحدة المرور',
                  options: ['مدينة نصر', 'التجمع الخامس', 'الدقي'],
                ),
                DropdownConfig(
                  title: 'فئة الرخصة',
                  hint: 'اختر فئة الرخصة',
                  options: [
                    'قيادة خاصة',
                    'دراجة نارية',
                    'مهنية درجة ثالثة',
                    'مهنية درجة ثانية',
                    'مهنية درجة أولى',
                    'قيادة معدات ثقيلة',
                    'قيادة جرار زراعي',
                  ],
                ),
              ],
              documents: _documents,
              onNextPressed: _onProceed,
            ),
            if (state is DrivingLicenseLoading)
              Container(
                color: Colors.black.withOpacity(0.3),
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              ),
          ],
        );
      },
    );
  }
}

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:open_filex/open_filex.dart';
import 'package:traffic/core/widgets/app_drawer.dart';
import 'package:traffic/core/widgets/service_screen_appbar.dart';
import 'package:traffic/features/auth/presentation/screens/signup_screen/widgets/signup_step1_form/widgets/next_button_widget.dart';
import 'package:traffic/features/driving_license/presentation/screens/medical_check/medical_check_screen.dart';
import 'widgets/license_category_bottom_sheet.dart';
import 'widgets/upload_document_card.dart';

// ── Document model ────────────────────────────────────────────────────────────

/// Lightweight local model representing one uploadable document slot.
///
/// [filePath] and [fileName] are `null` while no file has been picked.
/// When migrated to a Cubit, promote this to the domain/data layer.
class _DocumentItem {
  final String title;
  final bool isRequired;

  /// Absolute path of the picked file on disk.
  String? filePath;

  /// Display name of the picked file (e.g. "resume.pdf").
  String? fileName;

  bool get isUploaded => filePath != null;

  _DocumentItem({required this.title, required this.isRequired});
}

// ── Screen ────────────────────────────────────────────────────────────────────

/// Document upload screen — step in the "إصدار رخصة قيادة" flow.
///
/// Opens the device's native file picker (images + PDFs) from gallery/storage.
/// Replace local state with a Cubit when ready.
class DocumentUploadScreen extends StatefulWidget {
  const DocumentUploadScreen({super.key});

  @override
  State<DocumentUploadScreen> createState() => _DocumentUploadScreenState();
}

class _DocumentUploadScreenState extends State<DocumentUploadScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  // ── State ──────────────────────────────────────────────────────────────────

  String? _selectedCategory;

  late final List<_DocumentItem> _documents = [
    _DocumentItem(title: 'شهادة المؤهل الدراسي', isRequired: true),
    _DocumentItem(title: 'صور شخصية حديثة', isRequired: true),
    _DocumentItem(title: 'صورة البطاقة الشخصية (وجه + ظهر)', isRequired: true),
    _DocumentItem(title: 'إثبات محل الإقامة', isRequired: false),
    _DocumentItem(title: 'شهادة طبية', isRequired: false),
  ];

  /// Enable proceed only when category is chosen + all required docs uploaded.
  bool get _canProceed {
    if (_selectedCategory == null) return false;
    return _documents.where((d) => d.isRequired).every((d) => d.isUploaded);
  }

  // ── Handlers ──────────────────────────────────────────────────────────────

  Future<void> _openCategorySheet() async {
    final result = await showModalBottomSheet<String>(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
      ),
      backgroundColor: Colors.white,
      builder: (_) => const LicenseCategoryBottomSheet(),
    );
    if (result != null) {
      setState(() => _selectedCategory = result);
    }
  }

  /// Opens the native file picker filtered to images & PDFs.
  /// On success, stores the picked file path + name in the document model.
  Future<void> _onUploadTapped(int index) async {
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['jpg', 'jpeg', 'png', 'pdf'],
        allowMultiple: false,
        withData: false, // keep memory usage low (use path)
        withReadStream: false,
      );

      if (result == null || result.files.isEmpty) return; // user cancelled

      final file = result.files.single;
      if (file.path == null) return;

      setState(() {
        _documents[index].filePath = file.path;
        _documents[index].fileName = file.name;
      });
    } catch (_) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'حدث خطأ أثناء اختيار الملف. يرجى المحاولة مجدداً.',
            textDirection: TextDirection.rtl,
            style: TextStyle(fontFamily: 'Cairo', fontSize: 13.sp),
          ),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  /// Removes the picked file from the slot.
  void _onDeleteTapped(int index) {
    setState(() {
      _documents[index].filePath = null;
      _documents[index].fileName = null;
    });
  }

  /// Opens the picked file in the device's default viewer.
  Future<void> _onPreviewTapped(int index) async {
    final path = _documents[index].filePath;
    if (path == null) return;
    await OpenFilex.open(path);
  }

  void _onNextPressed() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => MedicalCheckScreen(
          appBarTitle: 'اصدار رخصة قيادة',
          onNextPressed: () {
            // TODO: Navigate to the next step in the flow.
          },
        ),
      ),
    );
  }

  // ── Build ──────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: const Color(0xFFF5F5F5),
      drawer: const AppDrawer(),
      body: Column(
        children: [
          // ── App bar ────────────────────────────────────────────────────
          ServiceScreenAppBar(
            title: 'اصدار رخصة قيادة',
            onMenuPressed: () => _scaffoldKey.currentState?.openDrawer(),
          ),

          // ── Scrollable body ────────────────────────────────────────────
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(height: 16.h),

                  // ── Section title ───────────────────────────────────────
                  Text(
                    'رفع المستندات المطلوبة',
                    textAlign: TextAlign.right,
                    textDirection: TextDirection.rtl,
                    style: TextStyle(
                      color: const Color(0xFF222222),
                      fontSize: 17.sp,
                      fontFamily: 'Tajawal',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 8.h),

                  // ── Subtitle ─────────────────────────────────────────────
                  Text(
                    'يرجى رفع المستندات التالية لإتمام إجراءات إصدار رخصة قيادة. يجب أن تكون الصور واضحة ومقروءة.',
                    textAlign: TextAlign.right,
                    textDirection: TextDirection.rtl,
                    style: TextStyle(
                      color: const Color(0xFF333333),
                      fontSize: 14.sp,
                      fontFamily: 'Tajawal',
                      fontWeight: FontWeight.w500,
                      height: 1.5,
                    ),
                  ),
                  SizedBox(height: 16.h),

                  // ── Licence category picker ─────────────────────────────
                  Text(
                    'فئة الرخصة',
                    textAlign: TextAlign.right,
                    textDirection: TextDirection.rtl,
                    style: TextStyle(
                      color: const Color(0xFF222222),
                      fontSize: 16.sp,
                      fontFamily: 'Tajawal',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  _CategoryPickerField(
                    selectedCategory: _selectedCategory,
                    onTap: _openCategorySheet,
                  ),
                  SizedBox(height: 16.h),

                  // ── Document cards ─────────────────────────────────────
                  ...List.generate(_documents.length, (i) {
                    final doc = _documents[i];
                    return Padding(
                      padding: EdgeInsets.only(bottom: 12.h),
                      child: UploadDocumentCard(
                        title: doc.title,
                        isRequired: doc.isRequired,
                        isUploaded: doc.isUploaded,
                        fileName: doc.fileName,
                        onUploadTapped: () => _onUploadTapped(i),
                        onPreviewTapped: () => _onPreviewTapped(i),
                        onDeleteTapped: () => _onDeleteTapped(i),
                      ),
                    );
                  }),

                  SizedBox(height: 8.h),

                  // ── Primary action button ──────────────────────────────
                  NextButtonWidget(
                    onPressed: _onNextPressed,
                    isValid: _canProceed,
                    height: 48.h,
                  ),
                  SizedBox(height: 24.h),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Private sub-widget: category picker field
// ─────────────────────────────────────────────────────────────────────────────

class _CategoryPickerField extends StatelessWidget {
  final String? selectedCategory;
  final VoidCallback onTap;

  const _CategoryPickerField({
    required this.selectedCategory,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final hasSelection = selectedCategory != null;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 48.h,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.r),
          border: Border.all(color: const Color(0xFF27AE60), width: 1.w),
          color: Colors.white,
        ),
        padding: EdgeInsets.symmetric(horizontal: 12.w),
        child: Row(
          textDirection: TextDirection.rtl,
          children: [
            Expanded(
              child: Text(
                selectedCategory ?? 'اختر فئة الرخصة',
                textDirection: TextDirection.rtl,
                style: TextStyle(
                  color: hasSelection
                      ? const Color(0xFF222222)
                      : const Color(0xFFAEAEAE),
                  fontSize: 15.sp,
                  fontFamily: 'Cairo',
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Icon(
              Icons.keyboard_arrow_down_rounded,
              size: 22.r,
              color: const Color(0xFF27AE60),
            ),
          ],
        ),
      ),
    );
  }
}

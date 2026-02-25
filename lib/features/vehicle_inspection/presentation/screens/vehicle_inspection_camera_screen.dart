import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:traffic/core/widgets/app_drawer.dart';
import 'package:traffic/core/widgets/service_screen_appbar.dart';
import 'package:traffic/features/vehicle_inspection/presentation/screens/vehicle_inspection_preview_screen.dart';
import 'package:traffic/features/vehicle_inspection/presentation/widgets/viewfinder_painter.dart';

/// Screen 2 — In-app camera screen with live preview.
///
/// Shows a live camera feed with viewfinder corner brackets overlay,
/// a guidance message, and a capture button.
class VehicleInspectionCameraScreen extends StatefulWidget {
  const VehicleInspectionCameraScreen({super.key});

  @override
  State<VehicleInspectionCameraScreen> createState() =>
      _VehicleInspectionCameraScreenState();
}

class _VehicleInspectionCameraScreenState
    extends State<VehicleInspectionCameraScreen>
    with WidgetsBindingObserver {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  CameraController? _cameraController;
  bool _isCameraInitialized = false;
  bool _isCapturing = false;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _initCamera();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _cameraController?.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    final controller = _cameraController;
    if (controller == null || !controller.value.isInitialized) return;

    if (state == AppLifecycleState.inactive) {
      controller.dispose();
      setState(() {
        _isCameraInitialized = false;
        _cameraController = null;
      });
    } else if (state == AppLifecycleState.resumed) {
      _initCamera();
    }
  }

  Future<void> _initCamera() async {
    try {
      final cameras = await availableCameras();
      if (cameras.isEmpty) {
        setState(() => _errorMessage = 'لا توجد كاميرا متاحة على هذا الجهاز');
        return;
      }

      // Use the back camera
      final backCamera = cameras.firstWhere(
        (c) => c.lensDirection == CameraLensDirection.back,
        orElse: () => cameras.first,
      );

      final controller = CameraController(
        backCamera,
        ResolutionPreset.high,
        enableAudio: false,
        imageFormatGroup: ImageFormatGroup.jpeg,
      );

      await controller.initialize();

      if (!mounted) {
        controller.dispose();
        return;
      }

      setState(() {
        _cameraController = controller;
        _isCameraInitialized = true;
        _errorMessage = null;
      });
    } catch (e) {
      if (mounted) {
        setState(() {
          _errorMessage = 'تعذر فتح الكاميرا. تأكد من منح الإذن.';
        });
      }
    }
  }

  Future<void> _captureImage() async {
    final controller = _cameraController;
    if (controller == null || !controller.value.isInitialized || _isCapturing) {
      return;
    }

    setState(() => _isCapturing = true);

    try {
      final XFile photo = await controller.takePicture();

      // Save to a permanent path
      final dir = await getTemporaryDirectory();
      final fileName = 'vehicle_${DateTime.now().millisecondsSinceEpoch}.jpg';
      final savedPath = p.join(dir.path, fileName);
      await photo.saveTo(savedPath);

      if (mounted) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) =>
                VehicleInspectionPreviewScreen(imagePath: savedPath),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'حدث خطأ أثناء التقاط الصورة. حاول مرة أخرى.',
              textDirection: TextDirection.rtl,
              style: const TextStyle(fontFamily: 'Tajawal'),
            ),
            backgroundColor: Colors.red.shade700,
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _isCapturing = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      drawer: const AppDrawer(),
      body: Column(
        children: [
          ServiceScreenAppBar(
            title: 'فحص المركبة بالذكاء الاصطناعي',
            onMenuPressed: () => _scaffoldKey.currentState?.openDrawer(),
          ),          SizedBox(height: 5.h,),

          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(flex: 1),

                // ── Camera preview with viewfinder overlay ──
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30.w),
                  child: AspectRatio(
                    aspectRatio: 3 / 4,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16.r),
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          // Camera preview or placeholder
                          _buildCameraPreview(),

                          // Viewfinder corner brackets overlay
                          Positioned.fill(
                            child: Padding(
                              padding: EdgeInsets.all(20.w),
                              child: CustomPaint(
                                painter: ViewfinderPainter(
                                  color: const Color(0xFF2E7D32),
                                  strokeWidth: 3.5,
                                  cornerLength: 35.w,
                                  cornerRadius: 14.r,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 20.h),

                // ── Guidance text ──
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 8.h,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF0F0F0),
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    textDirection: TextDirection.rtl,
                    children: [
                      Text(
                        'تأكد من ظهور المركبة بالكامل',
                        textDirection: TextDirection.rtl,
                        style: TextStyle(
                          fontFamily: 'Tajawal',
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xFF666666),
                        ),
                      ),
                      SizedBox(width: 6.w),
                      Icon(
                        Icons.info_outline,
                        size: 16.w,
                        color: const Color(0xFF999999),
                      ),
                    ],
                  ),
                ),

                const Spacer(flex: 2),

                // ── Camera capture button ──
                GestureDetector(
                  onTap: _captureImage,
                  child: Container(
                    width: 70.w,
                    height: 70.w,
                    decoration: BoxDecoration(
                      color: const Color(0xFF2E7D32),
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF2E7D32).withValues(alpha: 0.3),
                          blurRadius: 12,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: _isCapturing
                        ? Padding(
                            padding: EdgeInsets.all(18.w),
                            child: const CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2.5,
                            ),
                          )
                        : Icon(
                            Icons.camera_alt,
                            size: 30.w,
                            color: Colors.white,
                          ),
                  ),
                ),

                SizedBox(height: 40.h),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCameraPreview() {
    if (_errorMessage != null) {
      return Container(
        color: const Color(0xFFF5F5F5),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.camera_alt_outlined,
                size: 50.w,
                color: const Color(0xFF9E9E9E),
              ),
              SizedBox(height: 12.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Text(
                  _errorMessage!,
                  textAlign: TextAlign.center,
                  textDirection: TextDirection.rtl,
                  style: TextStyle(
                    fontFamily: 'Tajawal',
                    fontSize: 14.sp,
                    color: const Color(0xFF999999),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }

    if (!_isCameraInitialized || _cameraController == null) {
      return Container(
        color: const Color(0xFFF5F5F5),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: 40.w,
                height: 40.w,
                child: const CircularProgressIndicator(
                  color: Color(0xFF2E7D32),
                  strokeWidth: 3,
                ),
              ),
              SizedBox(height: 16.h),
              Text(
                'جاري تشغيل الكاميرا...',
                textDirection: TextDirection.rtl,
                style: TextStyle(
                  fontFamily: 'Tajawal',
                  fontSize: 14.sp,
                  color: const Color(0xFF999999),
                ),
              ),
            ],
          ),
        ),
      );
    }

    return CameraPreview(_cameraController!);
  }
}

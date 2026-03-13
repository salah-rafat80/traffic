import 'package:flutter/material.dart';
import 'package:traffic/core/widgets/generic_booking_screen.dart';

class VehicleInspectionBookingScreen extends StatelessWidget {
  const VehicleInspectionBookingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GenericBookingScreen(
      appBarTitle: 'اصدار رخصة مركبة',
      headerTitle: 'الفحص الفني للمركبة',
      bookingCardTitle: 'حجز موعد الفحص الفني',
      appointmentCardTitle: 'موعد الفحص الفني',
      secondaryDropdown: const SecondaryDropdownConfig(
        label: 'وحدة المرور',
        hint: 'اختر وحدة المرور',
        sheetTitle: 'اختر وحدة المرور',
        items: [
          'منيا القمح',
          'العاشر من رمضان',
          'ههيا',
          'فاقوس',
          'الزقازيق',
          'بلبيس',
          'ابو حماد',
        ],
      ),
      onNextPressed: () {
        _showInspectionWarningDialog(context);
      },
    );
  }

  void _showInspectionWarningDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Directionality(
        textDirection: TextDirection.rtl,
        child: AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          backgroundColor: Colors.white,
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 20),
              Icon(
                Icons.warning_amber_rounded,
                color: Color(0xFFF1C40F),
                size: 80,
              ),
              SizedBox(height: 20),
              Text(
                'لا يمكن استكمال إصدار رخصة المركبة إلا بعد إجراء الفحص الفني بنجاح للمركبة',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Cairo',
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF222222),
                  height: 1.5,
                ),
              ),
              SizedBox(height: 30),
              OutlinedButton(
                onPressed: () {
                  // Navigate back to home or similar
                  Navigator.of(context).popUntil((route) => route.isFirst);
                },
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: Color(0xFF27AE60)),
                  minimumSize: Size(double.infinity, 48),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  'العودة للصفحة الرئيسية',
                  style: TextStyle(
                    fontFamily: 'Cairo',
                    color: Color(0xFF27AE60),
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}

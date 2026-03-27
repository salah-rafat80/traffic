import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:traffic/core/features/payment/screens/payment_method_screen.dart';
import 'package:traffic/core/features/payment/models/payment_intent.dart';
import 'package:traffic/core/widgets/app_drawer.dart';
import 'package:traffic/core/widgets/primary_button.dart';
import 'package:traffic/core/widgets/service_screen_appbar.dart';
import 'package:traffic/features/violations_inquiry/data/models/violation_model.dart';
import 'package:traffic/features/violations_inquiry/presentation/screens/violation_details_screen.dart';
import 'package:traffic/features/violations_inquiry/presentation/screens/violation_review_screen.dart';
import 'package:traffic/features/violations_inquiry/presentation/widgets/violation_filter_tabs.dart';
import 'package:traffic/features/violations_inquiry/presentation/widgets/violation_list_item.dart';
import 'package:traffic/features/violations_inquiry/presentation/widgets/violations_summary_card.dart';
import '../../../violations_inquiry/data/models/vehicle_license_violation_model.dart';

/// Step 2 – Violations list screen.
/// Mirrors [ViolationsListScreen] from the driving-license violations flow but
/// uses the vehicle-license app bar title and section heading.
class VehicleViolationsListScreen extends StatefulWidget {
  final VehicleLicenseViolationModel vehicle;

  const VehicleViolationsListScreen({super.key, required this.vehicle});

  @override
  State<VehicleViolationsListScreen> createState() =>
      _VehicleViolationsListScreenState();
}

class _VehicleViolationsListScreenState
    extends State<VehicleViolationsListScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final List<ViolationModel> _allViolations = ViolationModel.dummyViolations;
  bool _showPaid = false;
  final Set<String> _selectedViolationIds = {};

  List<ViolationModel> get _filteredViolations =>
      _allViolations.where((v) => v.isPaid == _showPaid).toList();

  double get _totalAmount =>
      _allViolations.fold(0, (sum, v) => sum + v.amount);

  double get _selectedAmount => _allViolations
      .where((v) => !v.isPaid && _selectedViolationIds.contains(v.id))
      .fold(0, (sum, v) => sum + v.amount);

  int get _selectedCount => _selectedViolationIds.length;

  void _toggleSelection(ViolationModel violation, bool selected) {
    setState(() {
      if (selected) {
        _selectedViolationIds.add(violation.id);
      } else {
        _selectedViolationIds.remove(violation.id);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final filtered = _filteredViolations;

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      drawer: const AppDrawer(),
      body: Column(
        children: [
          ServiceScreenAppBar(
            title: 'استعلام عن مخالفات رخصة المركبة',
            onMenuPressed: () => _scaffoldKey.currentState?.openDrawer(),
          ),
          SizedBox(height: 5.h),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  SizedBox(height: 16.h),
                  Text(
                    'مخالفات رخصة المركبة',
                    style: TextStyle(
                      fontFamily: 'Tajawal',
                      fontSize: 17.sp,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF1A1A1A),
                    ),
                  ),
                  SizedBox(height: 16.h),
                  ViolationsSummaryCard(
                    totalViolations: _allViolations.length,
                    totalAmount: _totalAmount,
                    lastUpdate: '12/3/2025',
                  ),
                  SizedBox(height: 16.h),
                  ViolationFilterTabs(
                    showPaid: _showPaid,
                    onChanged: (val) => setState(() {
                      _showPaid = val;
                      _selectedViolationIds.clear();
                    }),
                  ),
                  SizedBox(height: 16.h),
                  if (filtered.isEmpty)
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 40.h),
                      child: Center(
                        child: Text(
                          'لا توجد مخالفات',
                          style: TextStyle(
                            fontFamily: 'Tajawal',
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w500,
                            color: const Color(0xFF999999),
                          ),
                        ),
                      ),
                    )
                  else
                    ...filtered.map(
                      (violation) => ViolationListItem(
                        violation: violation,
                        isSelected:
                            _selectedViolationIds.contains(violation.id),
                        onSelect: (selected) =>
                            _toggleSelection(violation, selected),
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                                ViolationDetailsScreen(violation: violation),
                          ),
                        ),
                      ),
                    ),
                  SizedBox(height: 16.h),
                ],
              ),
            ),
          ),
          if (!_showPaid)
            SafeArea(
              top: false,
              child: Padding(
                padding: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 16.h),
                child: PrimaryButton(
                  label: _selectedCount > 0
                      ? 'سداد $_selectedCount مخالفات  (${_selectedAmount.toInt()} جنية)'
                      : 'سداد المخالفات',
                  onPressed: _selectedCount > 0
                      ? () {
                          final selected = _allViolations
                              .where(
                                (v) => _selectedViolationIds.contains(v.id),
                              )
                              .toList();
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => ViolationReviewScreen(
                                selectedViolations: selected,
                                onNext: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => PaymentMethodScreen(
                                      paymentIntent: PaymentIntent(
                                        orderType: 'مخالفات رخصة المركبة',
                                        amount: _selectedAmount,
                                        currency: 'جنية مصري',
                                      ),
                                    ),
                                  ),
                                ),
                                onEdit: () => Navigator.pop(context),
                              ),
                            ),
                          );
                        }
                      : null,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

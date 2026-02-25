import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:traffic/core/widgets/app_drawer.dart';
import 'package:traffic/core/widgets/service_screen_appbar.dart';
import 'package:traffic/features/violations_inquiry/data/models/license_model.dart';
import 'package:traffic/features/violations_inquiry/data/models/violation_model.dart';
import 'package:traffic/features/violations_inquiry/presentation/screens/violation_details_screen.dart';
import 'package:traffic/features/violations_inquiry/presentation/widgets/violation_filter_tabs.dart';
import 'package:traffic/features/violations_inquiry/presentation/widgets/violation_list_item.dart';
import 'package:traffic/features/violations_inquiry/presentation/widgets/violations_summary_card.dart';

class ViolationsListScreen extends StatefulWidget {
  final DrivingLicenseModel license;

  const ViolationsListScreen({super.key, required this.license});

  @override
  State<ViolationsListScreen> createState() => _ViolationsListScreenState();
}

class _ViolationsListScreenState extends State<ViolationsListScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final List<ViolationModel> _allViolations = ViolationModel.dummyViolations;
  bool _showPaid = false;

  /// Tracks which violations are currently selected by their unique id.
  final Set<String> _selectedViolationIds = {};

  List<ViolationModel> get _filteredViolations =>
      _allViolations.where((v) => v.isPaid == _showPaid).toList();

  double get _totalAmount => _allViolations.fold(0, (sum, v) => sum + v.amount);

  /// Total amount of the currently selected (unpaid) violations.
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
            title: 'استعلام عن مخالفات رخصة القيادة',
            onMenuPressed: () => _scaffoldKey.currentState?.openDrawer(),
          ),
          SizedBox(height: 5.h,),

          // ── Content ──
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  SizedBox(height: 16.h),

                  // ── Section title ──
                  Text(
                    'مخالفات رخصة القيادة',
                    style: TextStyle(
                      fontFamily: 'Tajawal',
                      fontSize: 17.sp,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF1A1A1A),
                    ),
                  ),
                  SizedBox(height: 16.h),

                  // ── Summary card ──
                  ViolationsSummaryCard(
                    totalViolations: _allViolations.length,
                    totalAmount: _totalAmount,
                    lastUpdate: '12/3/2025',
                  ),
                  SizedBox(height: 16.h),

                  // ── Filter tabs ──
                  ViolationFilterTabs(
                    showPaid: _showPaid,
                    onChanged: (val) => setState(() {
                      _showPaid = val;
                      // Clear selections when switching tabs
                      _selectedViolationIds.clear();
                    }),
                  ),
                  SizedBox(height: 16.h),

                  // ── Violations list ──
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
                        isSelected: _selectedViolationIds.contains(
                          violation.id,
                        ),
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

          // ── Bottom button (only for unpaid tab) ──
          if (!_showPaid)
            SafeArea(
              top: false,
              child: Padding(
                padding: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 16.h),
                child: SizedBox(
                  width: double.infinity,
                  height: 52.h,
                  child: ElevatedButton(
                    onPressed: _selectedCount > 0 ? () {} : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF2E7D32),
                      disabledBackgroundColor: const Color(
                        0xFF2E7D32,
                      ).withValues(alpha: 0.4),
                      foregroundColor: Colors.white,
                      disabledForegroundColor: Colors.white70,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      elevation: 0,
                    ),
                    child: Text(
                      _selectedCount > 0
                          ? 'سداد $_selectedCount مخالفات  (${_selectedAmount.toInt()} جنية)'
                          : 'سداد المخالفات',
                      style: TextStyle(
                        fontFamily: 'Tajawal',
                        fontSize: 17.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

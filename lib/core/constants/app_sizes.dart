import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Consistent spacing scale for the entire app.
/// Use these values instead of hardcoded numbers.
/// All values are automatically scaled using ScreenUtil.
class AppSpacing {
  AppSpacing._();

  static double get xxs => 2.w;
  static double get xs => 4.w;
  static double get s => 8.w;
  static double get m => 12.w;
  static double get l => 16.w;
  static double get xl => 24.w;
  static double get xxl => 32.w;
  static double get xxxl => 40.w;
}

/// Component size constants for consistent sizing.
/// All values are automatically scaled using ScreenUtil.
class AppSizes {
  AppSizes._();

  /// Base reference device dimensions (iPhone 14 Pro equivalent)
  static const double baseWidth = 390.0;
  static const double baseHeight = 844.0;

  /// SignupAppBar base values
  static double get signupAppBarContentHeight => 120.h;
  static double get signupAppBarTopPadding => 10.h;
  static double get signupAppBarPreferredHeight => 120.h;

  /// Icon sizes
  static double get iconXs => 16.r;
  static double get iconS => 20.r;
  static double get iconM => 24.r;
  static double get iconL => 28.r;
  static double get iconXl => 32.r;

  /// Button heights
  static double get buttonHeightS => 48.h;
  static double get buttonHeight => 55.h;
  static double get buttonHeightL => 56.h;

  /// Input/Form heights
  static double get inputHeight => 56.h;
  static double get checkboxSize => 24.r;
  static double get minTapTarget => 44.r;

  /// Logo sizes
  static double get logoSmall => 40.r;
  static double get logoMedium => 50.r;
  static double get logoLarge => 80.r;

  /// Text sizes (using .sp for font scaling)
  static double get textXs => 12.sp;
  static double get textS => 13.sp;
  static double get textM => 14.sp;
  static double get textBody => 16.sp;
  static double get textL => 18.sp;
  static double get textXl => 20.sp;
  static double get textXxl => 22.sp;
  static double get textTitle => 25.sp;

  /// Border radius
  static double get radiusS => 4.r;
  static double get radiusM => 8.r;
  static double get radiusL => 12.r;
  static double get radiusXl => 16.r;

  /// Content max widths
  static const double maxContentWidth = 600.0;
}

/// Extension on BuildContext for convenient responsive access.
extension ResponsiveContext on BuildContext {
  // ============ SCREEN INFO ============

  /// Screen width
  double get screenWidth => ScreenUtil().screenWidth;

  /// Screen height
  double get screenHeight => ScreenUtil().screenHeight;

  /// Status bar height
  double get statusBarHeight => ScreenUtil().statusBarHeight;

  /// Bottom bar height (safe area)
  double get bottomBarHeight => ScreenUtil().bottomBarHeight;

  // ============ APPBAR ============

  /// Get SignupAppBar content height
  double get signupAppBarContentHeight => AppSizes.signupAppBarContentHeight;

  /// Get SignupAppBar top padding
  double get appBarTopPadding => AppSizes.signupAppBarTopPadding;

  // ============ TEXT SIZES ============

  /// Extra small text (12sp)
  double get textXs => AppSizes.textXs;

  /// Small text (13sp)
  double get textS => AppSizes.textS;

  /// Medium text (14sp)
  double get textM => AppSizes.textM;

  /// Body text (16sp)
  double get textBody => AppSizes.textBody;

  /// Large text (18sp)
  double get textL => AppSizes.textL;

  /// Extra large text (20sp)
  double get textXl => AppSizes.textXl;

  /// XXL text (22sp)
  double get textXxl => AppSizes.textXxl;

  /// Title text (25sp)
  double get textTitle => AppSizes.textTitle;

  // ============ BUTTONS ============

  /// Small button height (48h)
  double get buttonHeightS => AppSizes.buttonHeightS;

  /// Regular button height (50h)
  double get buttonHeight => AppSizes.buttonHeight;

  /// Large button height (56h)
  double get buttonHeightL => AppSizes.buttonHeightL;

  // ============ SPACING ============

  /// Extra extra small spacing (2w)
  double get spacingXxs => AppSpacing.xxs;

  /// Extra small spacing (4w)
  double get spacingXs => AppSpacing.xs;

  /// Small spacing (8w)
  double get spacingS => AppSpacing.s;

  /// Medium spacing (12w)
  double get spacingM => AppSpacing.m;

  /// Large spacing (16w)
  double get spacingL => AppSpacing.l;

  /// Extra large spacing (24w)
  double get spacingXl => AppSpacing.xl;

  /// XXL spacing (32w)
  double get spacingXxl => AppSpacing.xxl;

  /// XXXL spacing (40w)
  double get spacingXxxl => AppSpacing.xxxl;

  // ============ ICONS ============

  /// Extra small icon (16r)
  double get iconXs => AppSizes.iconXs;

  /// Small icon (20r)
  double get iconS => AppSizes.iconS;

  /// Medium icon (24r)
  double get iconM => AppSizes.iconM;

  /// Large icon (28r)
  double get iconL => AppSizes.iconL;

  /// Extra large icon (32r)
  double get iconXl => AppSizes.iconXl;

  // ============ OTHER ============

  /// Logo small (40r)
  double get logoSmall => AppSizes.logoSmall;

  /// Logo medium (50r)
  double get logoMedium => AppSizes.logoMedium;

  /// Checkbox size (24r)
  double get checkboxSize => AppSizes.checkboxSize;

  /// Border radius small (4r)
  double get radiusS => AppSizes.radiusS;

  /// Border radius medium (8r)
  double get radiusM => AppSizes.radiusM;

  /// Border radius large (12r)
  double get radiusL => AppSizes.radiusL;

  // ============ DEVICE INFO ============

  /// Check if tablet (width > 600)
  bool get isTablet => ScreenUtil().screenWidth > 600;

  /// Check if large screen (width > 900)
  bool get isLargeScreen => ScreenUtil().screenWidth > 900;

  /// Check if small phone (width < 360)
  bool get isSmallPhone => ScreenUtil().screenWidth < 360;

  /// Check if device has small height (< 600)
  bool get isSmallHeight => ScreenUtil().screenHeight < 600;

  /// Check if device is a large phone (width > 400 and <= 600)
  bool get isLargePhone =>
      ScreenUtil().screenWidth > 400 && ScreenUtil().screenWidth <= 600;
}

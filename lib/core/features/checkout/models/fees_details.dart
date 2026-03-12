/// A single fee line item rendered inside [FeesDetailsCard].
class FeeItem {
  /// The label shown on the right (RTL), e.g. 'رسوم إصدار الرخصة'.
  final String label;

  /// The formatted amount shown on the left (RTL), e.g. '280 جنيه مصري'.
  final String amount;

  const FeeItem({required this.label, required this.amount});
}

/// Aggregated fees model consumed by [FeesDetailsCard].
class FeesDetails {
  /// The ordered list of fee line items.
  final List<FeeItem> items;

  /// The pre-formatted total displayed in the highlighted footer row.
  final String total;

  const FeesDetails({required this.items, required this.total});
}

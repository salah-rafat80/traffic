class ViolationModel {
  final String id;
  final String title;
  final String date;
  final String time;
  final String location;
  final String articleNumber;
  final String articleText;
  final double amount;
  final String violationNumber;
  final bool isPaid;
  final String? paymentDate;

  const ViolationModel({
    required this.id,
    required this.title,
    required this.date,
    required this.time,
    required this.location,
    required this.articleNumber,
    required this.articleText,
    required this.amount,
    required this.violationNumber,
    required this.isPaid,
    this.paymentDate,
  });

  /// Dummy data for UI development
  static List<ViolationModel> get dummyViolations => const [
    ViolationModel(
      id: '1',
      title: 'تجاوز السرعة المقررة',
      date: '2/3/2025',
      time: '01:32 AM',
      location: 'الطريق الدائري، القاهرة',
      articleNumber: 'المادة 72',
      articleText: 'تجاوز السرعة القصوى',
      amount: 500,
      violationNumber: 'VH3456789',
      isPaid: false,
    ),
    ViolationModel(
      id: '2',
      title: 'تجاوز السرعة المقررة',
      date: '2/3/2025',
      time: '01:32 AM',
      location: 'طريق النصر، القاهرة',
      articleNumber: 'المادة 72',
      articleText: 'تجاوز السرعة القصوى',
      amount: 300,
      violationNumber: 'VH3456789',
      isPaid: true,
      paymentDate: '01:32 AM, 2/3/2025',
    ),
    ViolationModel(
      id: '3',
      title: 'عدم الربط حزام الامان',
      date: '2/3/2025',
      time: '01:32 AM',
      location: 'طريق النصر، القاهرة',
      articleNumber: 'المادة 72',
      articleText: 'تجاوز السرعة القصوى',
      amount: 500,
      violationNumber: 'VH3456789',
      isPaid: false,
    ),
    ViolationModel(
      id: '4',
      title: 'انتظار خاطئ',
      date: '2/3/2025',
      time: '01:32 AM',
      location: 'طريق النصر، القاهرة',
      articleNumber: 'المادة 72',
      articleText: 'تجاوز السرعة القصوى',
      amount: 500,
      violationNumber: 'VH345789',
      isPaid: true,
      paymentDate: '01:32 AM, 2/3/2025',
    ),
  ];
}

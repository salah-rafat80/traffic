import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:traffic/core/widgets/service_screen_appbar.dart';

class FaqScreen extends StatefulWidget {
  const FaqScreen({super.key});

  @override
  State<FaqScreen> createState() => _FaqScreenState();
}

class _FaqScreenState extends State<FaqScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    // Dummy Data
    final List<Map<String, dynamic>> faqs = List.generate(
      5,
      (index) => {
        'question': 'كيف يمكنني تجديد رخصة القيادة ؟',
        'answer': Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text:
                    'لتجديد رخصة القيادة، يلزم توفير المستندات التالية:\n• بطاقة رقم قومي سارية  \n• رخصة القيادة الحالية  \n• شهادة الفحص الطبي (إن وُجدت)  \n• سداد الرسوم المقررة  \nيمكنك المتابعة من خلال خدمة ',
                style: TextStyle(
                  color: const Color(0xFF707070),
                  fontSize: 13.sp,
                  fontFamily: 'Cairo',
                  fontWeight: FontWeight.w600,
                  height: 1.6,
                ),
              ),
              TextSpan(
                text: 'تجديد رخصة القيادة',
                style: TextStyle(
                  color: const Color(0xFF27AE60),
                  fontSize: 13.sp,
                  fontFamily: 'Cairo',
                  fontWeight: FontWeight.w600,
                  decoration: TextDecoration.underline,
                  height: 1.6,
                ),
              ),
              TextSpan(
                text: ' داخل التطبيق لإتمام الإجراءات.\n',
                style: TextStyle(
                  color: const Color(0xFF707070),
                  fontSize: 13.sp,
                  fontFamily: 'Cairo',
                  fontWeight: FontWeight.w600,
                  height: 1.6,
                ),
              ),
            ],
          ),
          textAlign: TextAlign.start,
          textDirection: TextDirection.rtl,
        ),
      },
    );
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      key: _scaffoldKey,

      body: Column(
        textDirection: TextDirection.rtl,
        children: [
          ServiceScreenAppBar(
            title: "الاسئلة الشائعة",
            onMenuPressed: () {
              _scaffoldKey.currentState?.openDrawer();
            },
          ),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
              itemCount: faqs.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.only(bottom: 16.h),
                  child: _FaqItemCard(
                    question: faqs[index]['question'],
                    answerContent: faqs[index]['answer'],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _FaqItemCard extends StatefulWidget {
  final String question;
  final Widget answerContent;

  const _FaqItemCard({required this.question, required this.answerContent});

  @override
  State<_FaqItemCard> createState() => _FaqItemCardState();
}

class _FaqItemCardState extends State<_FaqItemCard> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFF8F9F9),
        border: Border.all(color: const Color(0xFFDADADA), width: 1.w),
        borderRadius: BorderRadius.circular(5.r),
        boxShadow: [
          BoxShadow(
            color: const Color(0x3F000000),
            blurRadius: 4.r,
            offset: Offset(0, 1.h),
          ),
        ],
      ),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          leading: Icon(
            _isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
            color: const Color(0xFF27AE60),
          ),
          title: Text(
            widget.question,
            textDirection: TextDirection.rtl,

            style: TextStyle(
              color: _isExpanded
                  ? const Color(0xFF27AE60)
                  : const Color(0xFF222222),
              fontSize: 14.sp,
              fontFamily: 'Cairo',
              fontWeight: FontWeight.w600,
            ),
          ),
          iconColor: const Color(0xFF27AE60),
          collapsedIconColor: const Color(0xFF27AE60),

          onExpansionChanged: (expanded) {
            setState(() {
              _isExpanded = expanded;
            });
          },
          trailing: const SizedBox.shrink(),
          children: [
            Padding(
              padding: EdgeInsets.only(left: 16.w, right: 16.w, bottom: 16.h),
              child: widget.answerContent,
            ),
          ],
        ),
      ),
    );
  }
}

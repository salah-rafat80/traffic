import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:traffic/core/widgets/app_drawer.dart';
import 'package:traffic/core/widgets/service_screen_appbar.dart';
import 'package:traffic/features/smart_assistant/presentation/widgets/chat_bubble.dart';
import 'package:traffic/features/smart_assistant/presentation/widgets/chat_input_field.dart';

/// Simple data model for a chat message.
class _ChatMessage {
  final String text;
  final bool isUser;

  const _ChatMessage({required this.text, required this.isUser});
}

/// Chat screen for the smart assistant feature.
///
/// Matches the provided design:
///   – AppBar: "محادثة المساعد الذكي" with hamburger + back arrow
///   – Messages list (bot greeting + user/bot conversation)
///   – Bottom input field with green send button
class SmartAssistantChatScreen extends StatefulWidget {
  const SmartAssistantChatScreen({super.key});

  @override
  State<SmartAssistantChatScreen> createState() =>
      _SmartAssistantChatScreenState();
}

class _SmartAssistantChatScreenState extends State<SmartAssistantChatScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final ScrollController _scrollController = ScrollController();

  final List<_ChatMessage> _messages = [
    const _ChatMessage(
      text: 'مرحباً، أنا المساعد الذكي لخدمات المرور. كيف أساعدك؟',
      isUser: false,
    ),
  ];

  /// Hardcoded bot responses for demo purposes.
  static const Map<String, String> _botResponses = {
    'ماهي الوثائق المطلوبة لتجديد الرخصة':
        'لتجديد رخصة القيادة، يلزم توفير المستندات التالية:\n'
        '• بطاقة رقم قومي سارية\n'
        '• رخصة القيادة الحالية\n'
        '• شهادة الفحص الطبي (إن وُجدت)\n'
        '• سداد الرسوم المقررة\n'
        'يمكنك المتابعة من خلال خدمة تجديد رخصة القيادة داخل التطبيق لإتمام الإجراءات.',
  };

  static const String _defaultResponse =
      'شكراً لسؤالك. يمكنني مساعدتك في استفسارات المرور المختلفة مثل تجديد الرخصة، الاستعلام عن المخالفات، وحجز الكشف الطبي. كيف يمكنني مساعدتك؟';

  void _onSend(String text) {
    setState(() {
      _messages.add(_ChatMessage(text: text, isUser: true));
    });
    _scrollToBottom();

    // Simulate bot response after a short delay
    Future.delayed(const Duration(milliseconds: 600), () {
      if (!mounted) return;
      setState(() {
        _messages.add(
          _ChatMessage(
            text: _botResponses[text] ?? _defaultResponse,
            isUser: false,
          ),
        );
      });
      _scrollToBottom();
    });
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      drawer: const AppDrawer(),
      body: Column(
        children: [
          // ── App bar ──
          ServiceScreenAppBar(
            title: 'محادثة المساعد الذكي',
            onMenuPressed: () => _scaffoldKey.currentState?.openDrawer(),
          ),
          SizedBox(height: 5.h,),

          // ── Messages list ──
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: EdgeInsets.symmetric(vertical: 16.h),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final msg = _messages[index];
                return ChatBubble(text: msg.text, isUser: msg.isUser);
              },
            ),
          ),

          // ── Input field ──
          ChatInputField(onSend: _onSend),
        ],
      ),
    );
  }
}

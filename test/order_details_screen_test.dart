import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:traffic/features/orders/domain/entities/order_model.dart';
import 'package:traffic/features/orders/presentation/order_details_screen.dart';

void main() {
  testWidgets(
    'finalize button opens renewal finalize delivery screen without Provider<ApiClient>',
    (WidgetTester tester) async {
      tester.view.physicalSize = const Size(1170, 2532);
      tester.view.devicePixelRatio = 3.0;
      addTearDown(() {
        tester.view.resetPhysicalSize();
        tester.view.resetDevicePixelRatio();
      });

      const OrderModel order = OrderModel(
        id: 'DR-801',
        title: 'تجديد رخصة قيادة',
        date: '2026-04-21T00:00:00Z',
        status: OrderStatus.pending,
        statusLabel: 'قيد التنفيذ',
      );

      await tester.pumpWidget(
        ScreenUtilInit(
          designSize: const Size(375, 812),
          builder: (_, __) {
            return const MaterialApp(
              home: OrderDetailsScreen(order: order),
            );
          },
        ),
      );

      expect(find.text('استكمال الإجراءات'), findsOneWidget);

      await tester.tap(find.text('استكمال الإجراءات'));
      await tester.pumpAndSettle();

      expect(find.text('استكمال تجديد رخصة القيادة'), findsOneWidget);
      final Object? exception = tester.takeException();
      if (exception != null) {
        expect(exception.toString(), isNot(contains('ProviderNotFoundException')));
      }
    },
  );
}


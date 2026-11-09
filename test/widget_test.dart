import 'package:flutter_test/flutter_test.dart';

import 'package:prak1/main.dart';

void main() {
  testWidgets('Заставка через 4 секунды сменяется экраном входа',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    expect(find.text('ВИДЕОКАРТЫ'), findsOneWidget);

    await tester.pump(const Duration(seconds: 4));
    await tester.pumpAndSettle();
    expect(find.text('Войти'), findsOneWidget);
  });
}

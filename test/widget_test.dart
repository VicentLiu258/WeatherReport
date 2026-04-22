import 'package:flutter_test/flutter_test.dart';

import 'package:weather_report/app/app.dart';

void main() {
  testWidgets('Weather placeholder renders', (WidgetTester tester) async {
    await tester.pumpWidget(const App());

    expect(find.text('Weather page placeholder'), findsOneWidget);
  });
}

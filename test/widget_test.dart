import 'package:flutter_test/flutter_test.dart';
import 'package:skillchain/main.dart';

void main() {
  testWidgets('SkillChain app renders login screen', (WidgetTester tester) async {
    await tester.pumpWidget(const SkillChainApp());

    expect(find.text('SkillChain'), findsOneWidget);
    expect(find.text('Login'), findsOneWidget);
  });
}

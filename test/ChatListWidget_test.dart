import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wechat/main.dart';

void main(){
  testWidgets('ChatListWidget UI Test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(WeChat());

    expect(find.byType(ListView),findsOneWidget);
  });
}
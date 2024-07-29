import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void showAllCreatedWidgets(WidgetTester tester) {
  print(tester.allWidgets
      .where((x) => x.runtimeType == Text)
      .map((x) => (x as Text).data)
      .toList());
}

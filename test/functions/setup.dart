import 'package:nock/nock.dart';
import 'package:flutter_test/flutter_test.dart';

void setup() {
  setUpAll(() {
    nock.init();
  });

  setUp(() {
    nock.cleanAll();
  });
}

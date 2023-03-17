import 'package:flutter_test/flutter_test.dart';
import 'package:testing_flutter/counter.dart';

void main() {
  test('Testing the increment counter', () {
    //setup
    Counter counter = Counter(value: 0);
    //do
    counter.incrementCounter();
    counter.incrementCounter();
    //test
    expect(counter.value, 2);
  });
}

import 'package:flutter_test/flutter_test.dart';
import 'package:unit_test_learning/calculator.dart';

void main() {
  group('Calculator test', () {
    final calculator = Calculator();

    test('Addition test', () {
      expect(calculator.addition(1, 1), 2);
      expect(calculator.addition(0, 0), 0);
      expect(calculator.addition(1, -10), -9);
    });

    test('Subtraction test', () {
      expect(calculator.subtraction(15, 3), 12);
      expect(calculator.subtraction(0, 0), 0);
      expect(calculator.subtraction(1, 9), -8);
    });
  });
}

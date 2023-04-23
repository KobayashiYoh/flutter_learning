import 'package:flutter_test/flutter_test.dart';
import 'package:github_actions/leap_year.dart';

void main() {
  group('Leap year around 0', () {
    test('value in 0', () {
      expect(LeapYear().isLeapYear(0), true);
    });
    test('value in 1', () {
      expect(LeapYear().isLeapYear(1), false);
    });
  });

  group('Leap year around 2000', () {
    test('value in 1999', () {
      expect(LeapYear().isLeapYear(1999), false);
    });
    test('value in 2000', () {
      expect(LeapYear().isLeapYear(2000), true);
    });
    test('value in 2001', () {
      expect(LeapYear().isLeapYear(2001), false);
    });
  });

  group('Leap year around 2004', () {
    test('value in 2003', () {
      expect(LeapYear().isLeapYear(2003), false);
    });
    test('value in 2004', () {
      expect(LeapYear().isLeapYear(2004), true);
    });
    test('value in 2005', () {
      expect(LeapYear().isLeapYear(2005), false);
    });
  });

  group('Leap year around 2100', () {
    test('value in 2099', () {
      expect(LeapYear().isLeapYear(2099), false);
    });
    test('value in 2100', () {
      expect(LeapYear().isLeapYear(2100), true);
    });
    test('value in 2101', () {
      expect(LeapYear().isLeapYear(2101), false);
    });
  });
}

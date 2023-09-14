import 'package:test/test.dart';
import 'package:unit_test2/utils/leap_year_util.dart';

void main() {
  group('閏年判定', () {
    test('1999年は平年である', () {
      expect(LeapYearUtil.isLeapYear(1999), false);
    });

    test('2000年は閏年である', () {
      expect(LeapYearUtil.isLeapYear(2000), true);
    });

    test('2001年は平年である', () {
      expect(LeapYearUtil.isLeapYear(2001), false);
    });

    test('2004年は閏年である', () {
      expect(LeapYearUtil.isLeapYear(2004), true);
    });

    test('2100年は閏年である', () {
      expect(LeapYearUtil.isLeapYear(2100), false);
    });
  });
}

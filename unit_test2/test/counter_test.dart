// Import the test package and Counter class
import 'package:test/test.dart';
import 'package:unit_test2/counter.dart';

void main() {
  test('Counterが1ずつ増えるか確認', () {
    final counter = Counter();

    counter.increment();

    expect(counter.value, 1);
  });
}

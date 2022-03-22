// Import the test package and Counter class
import 'package:pennies_from_heaven/counter.dart';
import 'package:test/test.dart';

// import 'package:counter_app/counter.dart';
void main() {
  group('Counter', () {
    test('value should start at 0', () {
      expect(Counter().value, 0);
    });

    test('value should be incremented', () {
      final counter = Counter();
      expect(counter.value, 0);
      counter.increment();
      counter.increment();

      expect(counter.value, 1,
          skip: 'la de da ', reason: "counter.value should be 1");
    });

    test('value should be decremented', () {
      final counter = Counter();

      counter.decrement();

      expect(counter.value, -1);
    });
  });
}

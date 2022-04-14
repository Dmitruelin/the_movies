import 'package:flutter_test/flutter_test.dart';
import 'package:the_movies/models/film.dart';

void main() {
  late Film sut;

  setUp(() {
    sut =
        Film(movieId: 123, name: 'AlohaDance', description: 'Some Description');
  });

  group('Films ', () {
    test('is method toString() works correctly', () {
      expect(sut.toString(), 'AlohaDance');
    });
  });
}

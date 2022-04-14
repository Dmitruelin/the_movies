import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:the_movies/bloc/get_films/get_now_playing_films_cubit.dart';
import 'package:the_movies/models/film.dart';
import 'package:the_movies/utils/data_service.dart';

class MockDataService extends Mock implements DataService {}

void main() {
  late GetFilmsCubit sut;
  late MockDataService mockDataService;

  setUp(() {
    mockDataService = MockDataService();
    sut = GetFilmsCubit(mockDataService);
  });

  group('Get films ', () {
    test('using DataService and calling method only once', () {
      when(() => mockDataService.getNowPlayingFilms('en-US'))
          .thenAnswer((_) => <Film>[]);
      sut.getFilms('en-US');
      verify(() => mockDataService.getNowPlayingFilms('en-US')).called(1);
      verifyNever(() => mockDataService.getPopularFilms('en-US'));
    });
  });
}

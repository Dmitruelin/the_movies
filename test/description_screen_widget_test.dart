import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:network_image_mock/network_image_mock.dart';
import 'package:the_movies/generated/l10n.dart';
import 'package:the_movies/models/film.dart';
import 'package:the_movies/screens/description_screen.dart';

Widget widgetForTest(Film film) => MaterialApp(
      localizationsDelegates: const [S.delegate],
      home: DescriptionScreen(film: film),
    );

void main() {
  late Film film;

  setUp(() {
    film = Film(
      movieId: 123,
      name: 'AlohaDance',
      description: 'Some Description',
      posterPath: "/1g0dhYtq4irTY1GPXvft6k4YLjm.jpg",
      launchOn: 'launchOn',
      bannerPath: '/iQFcwSGbZXMkeyKrxbPnwnRo5fl.jpg',
    );
  });

  group('Description Screen', () {
    testWidgets('finds some buttons on screen', (WidgetTester tester) async {
      await mockNetworkImagesFor(() => tester.pumpWidget(widgetForTest(film)));

      Finder button = find.byType(ElevatedButton);
      Finder text = find.text('Some Description');

      await expectLater(text, findsNothing);
      expect(button, findsNothing);
    });
  });
}

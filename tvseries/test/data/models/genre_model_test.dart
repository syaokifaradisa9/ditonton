import 'package:flutter_test/flutter_test.dart';
import 'package:tvseries/data/models/genre_model.dart';
import 'package:tvseries/domain/entities/genre.dart';

void main() {
  final tGenreModel = GenreModel(
      name: 'name',
      id: 1
  );

  final tGenre = Genre(
      name: 'name',
      id: 1
  );

  test('should be a subclass of Genre entity', () async {
    final result = tGenreModel.toEntity();
    expect(result, tGenre);
  });
}

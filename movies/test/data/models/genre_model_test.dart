import 'package:flutter_test/flutter_test.dart';
import 'package:movies/data/models/genre_model.dart';
import 'package:movies/domain/entities/genre.dart';

void main() {
  const tGenreModel = GenreModel(
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

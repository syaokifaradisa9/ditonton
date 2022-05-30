import 'package:tvseries/data/models/season_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tvseries/domain/entities/season.dart';

void main() {
  const tSeasonModel = SeasonModel(
    name: 'name',
    id: 1,
    airDate: 'airDate',
    seasonNumber: 1,
    overview: 'overview',
    posterPath: 'posterPath',
    episodeCount: 1
  );

  const tSeason = Season(
      name: 'name',
      id: 1,
      airDate: 'airDate',
      seasonNumber: 1,
      overview: 'overview',
      posterPath: 'posterPath',
      episodeCount: 1
  );

  test('should be a subclass of Season entity', () async {
    final result = tSeasonModel.toEntity();
    expect(result, tSeason);
  });
}

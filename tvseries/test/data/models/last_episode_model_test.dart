import 'package:flutter_test/flutter_test.dart';
import 'package:tvseries/data/models/last_episode_model.dart';
import 'package:tvseries/domain/entities/last_episode.dart';

void main() {
  const tLastEpisodeModel = LastEpisodeModel(
    id: 1,
    name: 'name',
    overview: 'overview',
    voteAverage: 1,
    voteCount: 1,
    stillPath: 'stillPath',
    seasonNumber: 1,
    productionCode: "productionCode",
    episodeNumber: 1,
    airDate: 'airDate'
  );

  const tLastEpisode = LastEpisode(
    id: 1,
    name: 'name',
    overview: 'overview',
    voteAverage: 1,
    voteCount: 1,
    stillPath: 'stillPath',
    seasonNumber: 1,
    productionCode: "productionCode",
    episodeNumber: 1,
    airDate: 'airDate'
  );

  test('should be a subclass of LastEpisode entity', () async {
    final result = tLastEpisodeModel.toEntity();
    expect(result, tLastEpisode);
  });
}

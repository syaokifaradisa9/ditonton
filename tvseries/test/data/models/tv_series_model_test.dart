import 'package:flutter_test/flutter_test.dart';
import 'package:tvseries/data/models/tv_series_model.dart';
import 'package:tvseries/domain/entities/tv_series.dart';

void main() {
  const tTvSeriesModel = TvSeriesModel(
      id: 1,
      name: 'name',
      overview: 'overview',
      firstAirDate: 'firstAirDate',
      originCountry: ['originCountry'],
      genreIds: [1],
      originalLanguage: 'originalLanguage',
      originalName: 'originalName',
      popularity: 1,
      voteAverage: 1,
      voteCount: 1,
      posterPath: 'posterPath',
      backdropPath: 'backdropPath'
  );

  final tTvSeries = TvSeries(
      id: 1,
      name: 'name',
      overview: 'overview',
      firstAirDate: 'firstAirDate',
      originCountry: const ['originCountry'],
      genreIds: const [1],
      originalLanguage: 'originalLanguage',
      originalName: 'originalName',
      popularity: 1,
      voteAverage: 1,
      voteCount: 1,
      posterPath: 'posterPath',
      backdropPath: 'backdropPath'
  );

  test('should be a subclass of Movie entity', () async {
    final result = tTvSeriesModel.toEntity();
    expect(result, tTvSeries);
  });
}

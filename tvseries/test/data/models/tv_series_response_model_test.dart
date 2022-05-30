import 'dart:convert';
import 'package:tvseries/data/models/tv_series_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tvseries/data/models/tv_series_response.dart';

import '../../json_reader.dart';

void main() {
  const tTvSeriesModel = TvSeriesModel(
      id: 11250,
      name: "Hidden Passion",
      overview: "The Reyes-Elizondo's idyllic lives are shattered by a murder charge against Eric and León.",
      firstAirDate: "2003-10-21",
      originCountry: ["CO"],
      genreIds: [18],
      originalLanguage: 'es',
      originalName: 'Pasión de gavilanes',
      popularity: 3224.751,
      voteAverage: 7.6,
      voteCount: 1805,
      posterPath: "/lWlsZIsrGVWHtBeoOeLxIKDd9uy.jpg",
      backdropPath: "/4g5gK5eGWZg8swIZl6eX2AoJp8S.jpg"
  );

  const tTvSeriesResponseModel = TvSeriesResponse(
    tvSeriesList: <TvSeriesModel>[tTvSeriesModel]
  );

  group('fromJson', () {
    test('should return a valid model from JSON', () async {
      // arrange
      final Map<String, dynamic> jsonMap = json.decode(
        readJson('dummy_data/now_playing_tv_series.json')
      );

      // act
      final result = TvSeriesResponse.fromJson(jsonMap);
      // assert
      expect(result, tTvSeriesResponseModel);
    });
  });

  group('toJson', () {
    test('should return a JSON map containing proper data', () async {
      // act
      final result = tTvSeriesResponseModel.toJson();
      // assert
      final expectedJsonMap = {
        "results": [
          {
            "backdrop_path": "/4g5gK5eGWZg8swIZl6eX2AoJp8S.jpg",
            "first_air_date": "2003-10-21",
            "genre_ids": [
              18
            ],
            "id": 11250,
            "name": "Hidden Passion",
            "origin_country": [
              "CO"
            ],
            "original_language": "es",
            "original_name": "Pasión de gavilanes",
            "overview": "The Reyes-Elizondo's idyllic lives are shattered by a murder charge against Eric and León.",
            "popularity": 3224.751,
            "poster_path": "/lWlsZIsrGVWHtBeoOeLxIKDd9uy.jpg",
            "vote_average": 7.6,
            "vote_count": 1805
          }
        ],
      };

      expect(result, expectedJsonMap);
    });
  });
}

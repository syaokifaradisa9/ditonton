import 'dart:io';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tvseries/data/models/creator_model.dart';
import 'package:tvseries/data/models/genre_model.dart';
import 'package:tvseries/data/models/last_episode_model.dart';
import 'package:tvseries/data/models/network_channel_model.dart';
import 'package:tvseries/data/models/production_company_model.dart';
import 'package:tvseries/data/models/production_country_model.dart';
import 'package:tvseries/data/models/season_model.dart';
import 'package:tvseries/data/models/spoken_language_model.dart';
import 'package:tvseries/data/models/tv_series_detail_model.dart';
import 'package:tvseries/data/models/tv_series_model.dart';
import 'package:tvseries/data/repositories/tv_series_repository_impl.dart';
import 'package:tvseries/domain/entities/tv_series.dart';
import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late TvSeriesRepositoryImpl repository;
  late MockTvSeriesRemoteDataSource mockRemoteDataSource;
  late MockTvSeriesLocalDataSource mockLocalDataSource;

  setUp(() {
    mockRemoteDataSource = MockTvSeriesRemoteDataSource();
    mockLocalDataSource = MockTvSeriesLocalDataSource();
    repository = TvSeriesRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
      localDataSource: mockLocalDataSource,
    );
  });

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

  final tTvSeriesModelList = <TvSeriesModel>[tTvSeriesModel];
  final tTvSeriesList = <TvSeries>[tTvSeries];

  group('Now Playing Tv Series', () {
    test(
        'should return remote data when the call to remote data source is successful',
            () async {
          // arrange
          when(mockRemoteDataSource.getNowPlayingTvSeries())
              .thenAnswer((_) async => tTvSeriesModelList);
          // act
          final result = await repository.getNowPlayingTvSeries();
          // assert
          verify(mockRemoteDataSource.getNowPlayingTvSeries());
          /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
          final resultList = result.getOrElse(() => []);
          expect(resultList, tTvSeriesList);
    });

    test(
        'should return server failure when the call to remote data source is unsuccessful',
            () async {
          // arrange
          when(mockRemoteDataSource.getNowPlayingTvSeries())
              .thenThrow(ServerException());
          // act
          final result = await repository.getNowPlayingTvSeries();
          // assert
          verify(mockRemoteDataSource.getNowPlayingTvSeries());
          expect(result, equals(const Left(ServerFailure(''))));
        });

    test(
        'should return connection failure when the device is not connected to internet',
            () async {
          // arrange
          when(mockRemoteDataSource.getNowPlayingTvSeries())
              .thenThrow(const SocketException('Failed to connect to the network'));
          // act
          final result = await repository.getNowPlayingTvSeries();
          // assert
          verify(mockRemoteDataSource.getNowPlayingTvSeries());
          expect(result,
              equals(const Left(ConnectionFailure('Failed to connect to the network'))));
        });
  });

  group('Popular Tv Series', () {
    test('should return movie list when call to data source is success',
            () async {
          // arrange
          when(mockRemoteDataSource.getPopularTvSeries())
              .thenAnswer((_) async => tTvSeriesModelList);
          // act
          final result = await repository.getPopularTvSeries();
          // assert
          /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
          final resultList = result.getOrElse(() => []);
          expect(resultList, tTvSeriesList);
        });

    test(
        'should return server failure when call to data source is unsuccessful',
            () async {
          // arrange
          when(mockRemoteDataSource.getPopularTvSeries())
              .thenThrow(ServerException());
          // act
          final result = await repository.getPopularTvSeries();
          // assert
          expect(result, const Left(ServerFailure('')));
        });

    test(
        'should return connection failure when device is not connected to the internet',
            () async {
          // arrange
          when(mockRemoteDataSource.getPopularTvSeries())
              .thenThrow(const SocketException('Failed to connect to the network'));
          // act
          final result = await repository.getPopularTvSeries();
          // assert
          expect(
              result, const Left(ConnectionFailure('Failed to connect to the network')));
        });
  });

  group('Top Rated Tv Series', () {
    test('should return tv series list when call to data source is successful',
            () async {
          // arrange
          when(mockRemoteDataSource.getTopRatedTvSeries())
              .thenAnswer((_) async => tTvSeriesModelList);
          // act
          final result = await repository.getTopRatedTvSeries();
          // assert
          final resultList = result.getOrElse(() => []);
          expect(resultList, tTvSeriesList);
        });

    test('should return ServerFailure when call to data source is unsuccessful',
            () async {
          // arrange
          when(mockRemoteDataSource.getTopRatedTvSeries())
              .thenThrow(ServerException());
          // act
          final result = await repository.getTopRatedTvSeries();
          // assert
          expect(result, const Left(ServerFailure('')));
        });

    test(
        'should return ConnectionFailure when device is not connected to the internet',
            () async {
          // arrange
          when(mockRemoteDataSource.getTopRatedTvSeries())
              .thenThrow(const SocketException('Failed to connect to the network'));
          // act
          final result = await repository.getTopRatedTvSeries();
          // assert
          expect(
              result, const Left(ConnectionFailure('Failed to connect to the network')));
        });
  });

  group('Get Tv Series Detail', () {
    const tId = 1;
    final tTvSeriesResponse = TvSeriesDetailResponse(
      backdropPath: 'backdropPath',
      country: const ['country'],
      creators: const [
        CreatorModel(
            id: 1,
            creditId: "creditId",
            name: 'name',
            gender: 1,
            profilePath: 'profilePath'
        )
      ],
      episodeRunTime: const [1, 2, 3],
      firstAirDate: 'firstAirDate',
      genres: [GenreModel(id: 1, name: 'name')],
      homepage: 'homepage',
      id: 1,
      inProduction: true,
      languages: const ['language'],
      lastAirDate: 'lastAirDate',
      lastEpisode: const LastEpisodeModel(
        id: 1,
        airDate: 'airDate',
        episodeNumber: 1,
        name: 'name',
        overview: 'overview',
        productionCode: 'productionCode',
        seasonNumber: 1,
        stillPath: 'stillPath',
        voteAverage: 1,
        voteCount: 1
      ),
      voteCount: 1,
      voteAverage: 1,
      overview: 'overview',
      name: 'name',
      networks: const [
        NetworkChannelModel(
            id: 1, name: 'name', country: 'country', logoPath: 'logoPath')
      ],
      numberOfEpisode: 1,
      numberOfSeason: 1,
      originalName: 'originamName',
      originLanguage: 'originLanguage',
      popularity: 1,
      posterPath: 'posterPath',
      productionCompanies: const [
        ProductionCompanyModel(
            id: 'id', name: 'name', country: 'country', logoPath: 'logoPath')
      ],
      productionCountries: const [ProductionCountryModel(code: 'code', name: 'name')],
      seasons: const [
        SeasonModel(
            id: 1, name: 'name', posterPath: 'posterPath',
            seasonNumber: 1, overview: 'overview', airDate: 'airDate',
            episodeCount: 1)
      ],
      spokenLanguages: const [
        SpokenLanguageModel(
            name: 'name', code: 'code', englishName: 'englishName')
      ],
      status: 'status',
      tagline: 'tagline',
      type: 'type'
    );

    test(
        'should return Tv Series data when the call to remote data source is successful',
            () async {
          // arrange
          when(mockRemoteDataSource.getTvSeriesDetail(tId))
              .thenAnswer((_) async => tTvSeriesResponse);
          // act
          final result = await repository.getDetailTvSeries(tId);
          // assert
          verify(mockRemoteDataSource.getTvSeriesDetail(tId));
          expect(result, equals(Right(testTvSeriesDetail)));
        });

    test(
        'should return Server Failure when the call to remote data source is unsuccessful',
            () async {
          // arrange
          when(mockRemoteDataSource.getTvSeriesDetail(tId))
              .thenThrow(ServerException());
          // act
          final result = await repository.getDetailTvSeries(tId);
          // assert
          verify(mockRemoteDataSource.getTvSeriesDetail(tId));
          expect(result, equals(const Left(ServerFailure(''))));
        });

    test(
        'should return connection failure when the device is not connected to internet',
            () async {
          // arrange
          when(mockRemoteDataSource.getTvSeriesDetail(tId))
              .thenThrow(const SocketException('Failed to connect to the network'));
          // act
          final result = await repository.getDetailTvSeries(tId);
          // assert
          verify(mockRemoteDataSource.getTvSeriesDetail(tId));
          expect(result,
              equals(const Left(ConnectionFailure('Failed to connect to the network'))));
        });
  });

  group('Get Tv Series Recommendations', () {
    final tTvSeriesList = <TvSeriesModel>[];
    const tId = 1;

    test('should return data (tv series list) when the call is successful',
            () async {
          // arrange
          when(mockRemoteDataSource.getRecommendations(tId))
              .thenAnswer((_) async => tTvSeriesList);
          // act
          final result = await repository.getTvSeriesRecommendations(tId);
          // assert
          verify(mockRemoteDataSource.getRecommendations(tId));

          final resultList = result.getOrElse(() => []);
          expect(resultList, equals(tTvSeriesList));
        });

    test(
        'should return server failure when call to remote data source is unsuccessful',
            () async {
          // arrange
          when(mockRemoteDataSource.getRecommendations(tId))
              .thenThrow(ServerException());
          // act
          final result = await repository.getTvSeriesRecommendations(tId);
          // assertbuild runner
          verify(mockRemoteDataSource.getRecommendations(tId));
          expect(result, equals(const Left(ServerFailure(''))));
        });

    test(
        'should return connection failure when the device is not connected to the internet',
            () async {
          // arrange
          when(mockRemoteDataSource.getRecommendations(tId))
              .thenThrow(const SocketException('Failed to connect to the network'));
          // act
          final result = await repository.getTvSeriesRecommendations(tId);
          // assert
          verify(mockRemoteDataSource.getRecommendations(tId));
          expect(result,
              equals(const Left(ConnectionFailure('Failed to connect to the network'))));
        });
  });

  group('Seach Movies', () {
    const tQuery = 'spiderman';

    test('should return movie list when call to data source is successful',
            () async {
          // arrange
          when(mockRemoteDataSource.searchTvSeries(tQuery))
              .thenAnswer((_) async => tTvSeriesModelList);
          // act
          final result = await repository.searchTvSeries(tQuery);
          // assert
          /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
          final resultList = result.getOrElse(() => []);
          expect(resultList, tTvSeriesList);
        });

    test('should return ServerFailure when call to data source is unsuccessful',
            () async {
          // arrange
          when(mockRemoteDataSource.searchTvSeries(tQuery))
              .thenThrow(ServerException());
          // act
          final result = await repository.searchTvSeries(tQuery);
          // assert
          expect(result, const Left(ServerFailure('')));
        });

    test(
        'should return ConnectionFailure when device is not connected to the internet',
            () async {
          // arrange
          when(mockRemoteDataSource.searchTvSeries(tQuery))
              .thenThrow(const SocketException('Failed to connect to the network'));
          // act
          final result = await repository.searchTvSeries(tQuery);
          // assert
          expect(
              result, const Left(ConnectionFailure('Failed to connect to the network')));
        });
  });

  group('save watchlist', () {
    test('should return success message when saving successful', () async {
      // arrange
      when(mockLocalDataSource.insertWatchlist(testTvSeriesTable))
          .thenAnswer((_) async => 'Added to Watchlist');
      // act
      final result = await repository.saveWatchList(testTvSeriesDetail);
      // assert
      expect(result, const Right('Added to Watchlist'));
    });

    test('should return DatabaseFailure when saving unsuccessful', () async {
      // arrange
      when(mockLocalDataSource.insertWatchlist(testTvSeriesTable))
          .thenThrow(DatabaseException('Failed to add watchlist'));
      // act
      final result = await repository.saveWatchList(testTvSeriesDetail);
      // assert
      expect(result, const Left(DatabaseFailure('Failed to add watchlist')));
    });
  });

  group('remove watchlist', () {
    test('should return success message when remove successful', () async {
      // arrange
      when(mockLocalDataSource.removeWatchlist(testTvSeriesTable))
          .thenAnswer((_) async => 'Removed from watchlist');
      // act
      final result = await repository.removeWatchList(testTvSeriesDetail);
      // assert
      expect(result, const Right('Removed from watchlist'));
    });

    test('should return DatabaseFailure when remove unsuccessful', () async {
      // arrange
      when(mockLocalDataSource.removeWatchlist(testTvSeriesTable))
          .thenThrow(DatabaseException('Failed to remove watchlist'));
      // act
      final result = await repository.removeWatchList(testTvSeriesDetail);
      // assert
      expect(result, const Left(DatabaseFailure('Failed to remove watchlist')));
    });
  });

  group('get watchlist status', () {
    test('should return watch status whether data is found', () async {
      // arrange
      const tId = 1;
      when(mockLocalDataSource.getTvSeriesById(tId))
          .thenAnswer((_) async => null);

      // act
      final result = await repository.isAddedToWatchlist(tId);
      // assert
      expect(result, false);
    });
  });

  group('get watchlist movies', () {
    test('should return list of Tv Series', () async {
      // arrange
      when(mockLocalDataSource.getWatchlistTvSeries())
          .thenAnswer((_) async => [testTvSeriesTable]);
      // act
      final result = await repository.getWatchlistTvSeries();
      // assert
      final resultList = result.getOrElse(() => []);
      expect(resultList, [testWatchlistTvSeries]);
    });
  });
}

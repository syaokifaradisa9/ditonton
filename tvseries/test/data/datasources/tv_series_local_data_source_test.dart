import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tvseries/data/datasources/tv_series_local_data_source.dart';
import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main(){
  late TvSeriesLocalDataSourceImpl dataSource;
  late MockTvSeriesDatabaseHelper mockDatabaseHelper;

  setUp((){
    mockDatabaseHelper = MockTvSeriesDatabaseHelper();
    dataSource = TvSeriesLocalDataSourceImpl(databaseHelper: mockDatabaseHelper);
  });

  group('save watchlist', () {
    test('should return success message when insert to database is success',
            () async {
          // Arrange
          when(mockDatabaseHelper.insertWatchlist(testTvSeriesTable))
              .thenAnswer((_) async => 1);

          // Act
          final result = await dataSource.insertWatchlist(testTvSeriesTable);
          // Assert
          expect(result, 'Added to Watchlist');
        });

    test('should throw DatabaseException when insert to database is failed',
            () async {

          // Arrange
          when(mockDatabaseHelper.insertWatchlist(testTvSeriesTable))
              .thenThrow(Exception());

          // Act
          final call = dataSource.insertWatchlist(testTvSeriesTable);
          // Assert
          expect(()=> call, throwsA(isA<DatabaseException>()));
        });
  });

  group('remove watchlist', () {
    test('should return success message when remove from database is success',
            () async {

          // Arrange
          when(mockDatabaseHelper.removeWatchlist(testTvSeriesTable))
              .thenAnswer((_) async => 1);

          // Act
          final result = await dataSource.removeWatchlist(testTvSeriesTable);

          // Assert
          expect(result, 'Removed from Watchlist');
        });

    test('should throw DatabaseException when remove database is failed',
            () async{

          // Arrange
          when(mockDatabaseHelper.removeWatchlist(testTvSeriesTable))
              .thenThrow(Exception());

          // Act
          final call = dataSource.removeWatchlist(testTvSeriesTable);
          // Assert
          expect(()=>call, throwsA(isA<DatabaseException>()));
        });
  });

  group('Get tv series Detail By Id', () {
    const tId = 1;

    test('should return Tv Series Detail Table when data is found', () async{
      // Arrange
      when(mockDatabaseHelper.getTvSeriesById(tId))
          .thenAnswer((_) async => testMovieTvSeriesMap);

      // Act
      final result = await dataSource.getTvSeriesById(tId);
      // Assert
      expect(result, testTvSeriesTable);
    });

    test('should return null when data is not found', () async {
      // Arrange
      when(mockDatabaseHelper.getTvSeriesById(tId))
          .thenAnswer((_) async => null);

      // Act
      final result = await dataSource.getTvSeriesById(tId);
      // Assert
      expect(result, null);
    });
  });

  group('get watchlist tv series', () {
    test('should return list of TvSeriesTable from database', () async {
      // Arrange
      when(mockDatabaseHelper.getWatchlistMovies())
          .thenAnswer((_) async => [testMovieTvSeriesMap]);

      // Act
      final result = await dataSource.getWatchlistTvSeries();
      // Assert
      expect(result, [testTvSeriesTable]);
    });
  });
}
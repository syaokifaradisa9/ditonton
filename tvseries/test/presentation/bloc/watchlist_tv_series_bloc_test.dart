import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tvseries/domain/usecases/get_watchlist_tv_series.dart';
import 'package:tvseries/presentation/bloc/watchlist/watchlist_tv_series_bloc.dart';

import '../../dummy_data/dummy_objects.dart';
import 'watchlist_tv_series_bloc_test.mocks.dart';

@GenerateMocks([GetWatchlistTvSeries])
void main(){
  late WatchlistTvSeriesBloc watchlistTvSeriesBloc;
  late MockGetWatchlistTvSeries mockGetWatchlistTvSeries;

  setUp((){
    mockGetWatchlistTvSeries = MockGetWatchlistTvSeries();
    watchlistTvSeriesBloc = WatchlistTvSeriesBloc(
      mockGetWatchlistTvSeries
    );
  });

  test('initial state should be empty', (){
    expect(watchlistTvSeriesBloc.state, WatchlistTvSeriesEmpty());
  });

  blocTest<WatchlistTvSeriesBloc, WatchlistTvSeriesState>(
      'should emit when data is loaded successfully',
      build: (){
        when(mockGetWatchlistTvSeries.execute())
            .thenAnswer((_) async => Right(testTvSeriesList));
        return watchlistTvSeriesBloc;
      },
      act: (bloc) => bloc.add(OnFetchWatchlistTvSeries()),
      expect: () => [
        WatchlistTvSeriesLoading(),
        WatchlistTvSeriesHasData(testTvSeriesList)
      ],
      verify: (bloc) => verify(mockGetWatchlistTvSeries.execute())
  );

  blocTest<WatchlistTvSeriesBloc, WatchlistTvSeriesState>(
      'should emit error when data is loaded unsuccessfully',
      build: (){
        when(mockGetWatchlistTvSeries.execute())
            .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
        return watchlistTvSeriesBloc;
      },
      act: (bloc) => bloc.add(OnFetchWatchlistTvSeries()),
      expect: () => [
        WatchlistTvSeriesLoading(),
        const WatchlistTvSeriesError('Server Failure')
      ],
      verify: (bloc) => verify(mockGetWatchlistTvSeries.execute())
  );
}
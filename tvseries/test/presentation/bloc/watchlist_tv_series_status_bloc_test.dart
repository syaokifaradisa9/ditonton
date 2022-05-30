import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tvseries/tvseries.dart';

import 'watchlist_tv_series_status_bloc_test.mocks.dart';

@GenerateMocks([
  GetWatchListTvSeriesStatus,
  SaveTvSeriesWatchlist,
  RemoveTvSeriesWatchlist
])
void main(){
  late WatchlistTvSeriesStatusBloc watchlistTvSeriesStatusBloc;
  late MockGetWatchListTvSeriesStatus mockGetWatchListTvSeriesStatus;
  late MockSaveTvSeriesWatchlist mockSaveTvSeriesWatchlist;
  late MockRemoveTvSeriesWatchlist mockRemoveTvSeriesWatchlist;

  setUp((){
    mockGetWatchListTvSeriesStatus = MockGetWatchListTvSeriesStatus();
    mockSaveTvSeriesWatchlist = MockSaveTvSeriesWatchlist();
    mockRemoveTvSeriesWatchlist = MockRemoveTvSeriesWatchlist();
    watchlistTvSeriesStatusBloc = WatchlistTvSeriesStatusBloc(
      mockSaveTvSeriesWatchlist,
      mockRemoveTvSeriesWatchlist,
      mockGetWatchListTvSeriesStatus
    );
  });

  test('initial state should be empty', (){
    expect(watchlistTvSeriesStatusBloc.state, WatchlistTvSeriesStatusEmpty());
  });

  const tId = 1;
  blocTest<WatchlistTvSeriesStatusBloc, WatchlistTvSeriesStatusState>(
      'should get watchlist status',
      build: (){
        when(mockGetWatchListTvSeriesStatus.execute(tId)).thenAnswer((_) async => true);
        return watchlistTvSeriesStatusBloc;
      },
      act: (bloc) => bloc.add(const OnFetchWatchlistStatus(tId)),
      expect: () => [
        WatchlistTvSeriesStatusLoading(),
        WatchlistTvSeriesStatusHasData(
            isAdded: true,
            message: ''
        )
      ],
      verify: (bloc) => mockGetWatchListTvSeriesStatus.execute(tId)
  );
}
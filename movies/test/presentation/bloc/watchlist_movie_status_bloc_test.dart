import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movies/movies.dart';
import 'watchlist_movie_status_bloc_test.mocks.dart';

@GenerateMocks([
  GetWatchListMovieStatus,
  SaveMovieWatchlist,
  RemoveMovieWatchlist
])
void main(){
  late WatchlistMovieStatusBloc watchlistMovieStatusBloc;
  late MockGetWatchListMovieStatus mockGetWatchListMovieStatus;
  late MockSaveMovieWatchlist mockSaveMovieWatchlist;
  late MockRemoveMovieWatchlist mockRemoveMovieWatchlist;

  setUp((){
    mockGetWatchListMovieStatus = MockGetWatchListMovieStatus();
    mockSaveMovieWatchlist = MockSaveMovieWatchlist();
    mockRemoveMovieWatchlist = MockRemoveMovieWatchlist();
    watchlistMovieStatusBloc = WatchlistMovieStatusBloc(
      mockSaveMovieWatchlist,
      mockRemoveMovieWatchlist,
      mockGetWatchListMovieStatus
    );
  });

  test('initial state should be empty', (){
    expect(watchlistMovieStatusBloc.state, WatchlistMovieStatusEmpty());
  });

  const tId = 1;
  blocTest<WatchlistMovieStatusBloc, WatchlistMovieStatusState>(
    'should get watchlist status',
    build: (){
      when(mockGetWatchListMovieStatus.execute(tId)).thenAnswer((_) async => true);
      return watchlistMovieStatusBloc;
    },
    act: (bloc) => bloc.add(const OnFetchWatchlistStatus(tId)),
    expect: () => [
      WatchlistMovieStatusLoading(),
      WatchlistMovieStatusHasData(
          isAdded: true,
          message: ''
      )
    ],
    verify: (bloc) => mockGetWatchListMovieStatus.execute(tId)
  );
}
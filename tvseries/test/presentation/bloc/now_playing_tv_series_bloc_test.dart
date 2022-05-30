import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tvseries/domain/usecases/get_now_playing_tv_series.dart';
import 'package:tvseries/presentation/bloc/now_playing/now_playing_tv_series_bloc.dart';

import '../../dummy_data/dummy_objects.dart';
import 'now_playing_tv_series_bloc_test.mocks.dart';

@GenerateMocks([GetNowPlayingTvSeries])
void main(){
  late NowPlayingTvSeriesBloc nowPlayingTvSeriesBloc;
  late MockGetNowPlayingTvSeries mockGetNowPlayingTvSeries;

  setUp((){
    mockGetNowPlayingTvSeries = MockGetNowPlayingTvSeries();
    nowPlayingTvSeriesBloc = NowPlayingTvSeriesBloc(
      mockGetNowPlayingTvSeries
    );
  });

  test('initial state should be empty', (){
    expect(nowPlayingTvSeriesBloc.state, NowPlayingTvSeriesEmpty());
  });

  blocTest<NowPlayingTvSeriesBloc, NowPlayingTvSeriesState>(
      'should emit when data is loaded successfully',
      build: (){
        when(mockGetNowPlayingTvSeries.execute())
            .thenAnswer((_) async => Right(testTvSeriesList));
        return nowPlayingTvSeriesBloc;
      },
      act: (bloc) => bloc.add(OnFetchNowPlayingTvSeries()),
      expect: () => [
        NowPlayingTvSeriesLoading(),
        NowPlayingHasData(testTvSeriesList)
      ],
      verify: (bloc) => verify(mockGetNowPlayingTvSeries.execute())
  );

  blocTest<NowPlayingTvSeriesBloc, NowPlayingTvSeriesState>(
      'should emit error when data is loaded unsuccessfully',
      build: (){
        when(mockGetNowPlayingTvSeries.execute())
            .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
        return nowPlayingTvSeriesBloc;
      },
      act: (bloc) => bloc.add(OnFetchNowPlayingTvSeries()),
      expect: () => [
        NowPlayingTvSeriesLoading(),
        const NowPlayingTvSeriesError('Server Failure')
      ],
      verify: (bloc) => verify(mockGetNowPlayingTvSeries.execute())
  );
}
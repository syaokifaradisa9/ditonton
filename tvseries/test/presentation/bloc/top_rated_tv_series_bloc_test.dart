import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tvseries/domain/usecases/get_top_rated_tv_series.dart';
import 'package:tvseries/presentation/bloc/top_rated/top_rated_tv_series_bloc.dart'
;import '../../dummy_data/dummy_objects.dart';
import 'top_rated_tv_series_bloc_test.mocks.dart';

@GenerateMocks([GetTopRatedTvSeries])
void main(){
  late TopRatedTvSeriesBloc topRatedTvSeriesBloc;
  late MockGetTopRatedTvSeries mockGetTopRatedTvSeries;

  setUp((){
    mockGetTopRatedTvSeries = MockGetTopRatedTvSeries();
    topRatedTvSeriesBloc = TopRatedTvSeriesBloc(
      mockGetTopRatedTvSeries
    );
  });

  test('initial state should be empty', (){
    expect(topRatedTvSeriesBloc.state, TopRatedTvSeriesEmpty());
  });

  blocTest<TopRatedTvSeriesBloc, TopRatedTvSeriesState>(
      'should emit when data is loaded successfully',
      build: (){
        when(mockGetTopRatedTvSeries.execute())
            .thenAnswer((_) async => Right(testTvSeriesList));
        return topRatedTvSeriesBloc;
      },
      act: (bloc) => bloc.add(OnFetchTopRatedTvSeries()),
      expect: () => [
        TopRatedTvSeriesLoading(),
        TopRatedTvSeriesHasData(testTvSeriesList)
      ],
      verify: (bloc) => verify(mockGetTopRatedTvSeries.execute())
  );

  blocTest<TopRatedTvSeriesBloc, TopRatedTvSeriesState>(
      'should emit error when data is loaded unsuccessfully',
      build: (){
        when(mockGetTopRatedTvSeries.execute())
            .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
        return topRatedTvSeriesBloc;
      },
      act: (bloc) => bloc.add(OnFetchTopRatedTvSeries()),
      expect: () => [
        TopRatedTvSeriesLoading(),
        const TopRatedTvSeriesError('Server Failure')
      ],
      verify: (bloc) => verify(mockGetTopRatedTvSeries.execute())
  );
}
import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tvseries/tvseries.dart';

import '../../dummy_data/dummy_objects.dart';
import 'popular_tv_series_bloc_test.mocks.dart';

@GenerateMocks([GetPopularTvSeries])
void main(){
  late PopularTvSeriesBloc popularTvSeriesBloc;
  late MockGetPopularTvSeries mockGetPopularTvSeries;

  setUp((){
    mockGetPopularTvSeries = MockGetPopularTvSeries();
    popularTvSeriesBloc = PopularTvSeriesBloc(
      mockGetPopularTvSeries
    );
  });

  test('initial state should be empty', (){
    expect(popularTvSeriesBloc.state, PopularTvSeriesEmpty());
  });

  blocTest<PopularTvSeriesBloc, PopularTvSeriesState>(
      'should emit when data is loaded successfully',
      build: (){
        when(mockGetPopularTvSeries.execute())
            .thenAnswer((_) async => Right(testTvSeriesList));
        return popularTvSeriesBloc;
      },
      act: (bloc) => bloc.add(OnFetchPopularTvSeries()),
      expect: () => [
        PopularTvSeriesLoading(),
        PopularTvSeriesHasData(testTvSeriesList)
      ],
      verify: (bloc) => verify(mockGetPopularTvSeries.execute())
  );

  blocTest<PopularTvSeriesBloc, PopularTvSeriesState>(
      'should emit error when data is loaded unsuccessfully',
      build: (){
        when(mockGetPopularTvSeries.execute())
            .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
        return popularTvSeriesBloc;
      },
      act: (bloc) => bloc.add(OnFetchPopularTvSeries()),
      expect: () => [
        PopularTvSeriesLoading(),
        const PopularTvSeriesError('Server Failure')
      ],
      verify: (bloc) => verify(mockGetPopularTvSeries.execute())
  );
}
import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tvseries/domain/usecases/get_tv_series_recommendations.dart';
import 'package:tvseries/presentation/bloc/recommendation/recommendation_tv_series_bloc.dart';

import '../../dummy_data/dummy_objects.dart';
import 'recommendation_tv_series_bloc_test.mocks.dart';

@GenerateMocks([GetTvSeriesRecommendations])
void main(){
  late RecommendationTvSeriesBloc recommendationTvSeriesBloc;
  late MockGetTvSeriesRecommendations mockGetTvSeriesRecommendations;

  setUp((){
    mockGetTvSeriesRecommendations = MockGetTvSeriesRecommendations();
    recommendationTvSeriesBloc = RecommendationTvSeriesBloc(
      mockGetTvSeriesRecommendations
    );
  });

  test('initial state should be empty', (){
    expect(recommendationTvSeriesBloc.state, RecommendationTvSeriesEmpty());
  });

  const tId = 1;
  blocTest<RecommendationTvSeriesBloc, RecommendationTvSeriesState>(
      'should emit when data is loaded successfully',
      build: (){
        when(mockGetTvSeriesRecommendations.execute(tId))
            .thenAnswer((_) async => Right(testTvSeriesList));
        return recommendationTvSeriesBloc;
      },
      act: (bloc) => bloc.add(const OnFetchRecommendationTvSeries(tId)),
      expect: () => [
        RecommendationTvSeriesLoading(),
        RecommendationTvSeriesHasData(testTvSeriesList)
      ],
      verify: (bloc) => verify(mockGetTvSeriesRecommendations.execute(tId))
  );

  blocTest<RecommendationTvSeriesBloc, RecommendationTvSeriesState>(
      'should emit error when data is loaded unsuccessfully',
      build: (){
        when(mockGetTvSeriesRecommendations.execute(tId))
            .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
        return recommendationTvSeriesBloc;
      },
      act: (bloc) => bloc.add(const OnFetchRecommendationTvSeries(tId)),
      expect: () => [
        RecommendationTvSeriesLoading(),
        const RecommendationMovieError('Server Failure')
      ],
      verify: (bloc) => verify(mockGetTvSeriesRecommendations.execute(tId))
  );
}
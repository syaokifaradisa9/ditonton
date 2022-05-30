
import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movies/movies.dart';

import '../../dummy_data/dummy_objects.dart';
import 'recommendation_movies_bloc_test.mocks.dart';

@GenerateMocks([GetMovieRecommendations])
void main(){
  late RecommendationMovieBloc recommendationMovieBloc;
  late MockGetMovieRecommendations mockGetMovieRecommendations;

  setUp((){
    mockGetMovieRecommendations = MockGetMovieRecommendations();
    recommendationMovieBloc = RecommendationMovieBloc(
      mockGetMovieRecommendations
    );
  });

  test('initial state should be empty', (){
    expect(recommendationMovieBloc.state, RecommendationMovieEmpty());
  });

  const tId = 1;
  blocTest<RecommendationMovieBloc, RecommendationMovieState>(
      'should emit when data is loaded successfully',
      build: (){
        when(mockGetMovieRecommendations.execute(tId))
            .thenAnswer((_) async => Right(testMovieList));
        return recommendationMovieBloc;
      },
      act: (bloc) => bloc.add(const OnFetchRecommendationMovie(tId)),
      expect: () => [
        RecommendationMovieLoading(),
        RecommendationMovieHasData(testMovieList)
      ],
      verify: (bloc) => verify(mockGetMovieRecommendations.execute(tId))
  );

  blocTest<RecommendationMovieBloc, RecommendationMovieState>(
      'should emit error when data is loaded unsuccessfully',
      build: (){
        when(mockGetMovieRecommendations.execute(tId))
            .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
        return recommendationMovieBloc;
      },
      act: (bloc) => bloc.add(const OnFetchRecommendationMovie(tId)),
      expect: () => [
        RecommendationMovieLoading(),
        const RecommendationMovieError('Server Failure')
      ],
      verify: (bloc) => verify(mockGetMovieRecommendations.execute(tId))
  );
}
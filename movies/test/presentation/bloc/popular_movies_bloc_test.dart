import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movies/movies.dart';

import '../../dummy_data/dummy_objects.dart';
import 'popular_movies_bloc_test.mocks.dart';

@GenerateMocks([GetPopularMovies])
void main(){
  late PopularMovieBloc popularMovieBloc;
  late MockGetPopularMovies mockGetPopularMovies;

  setUp((){
    mockGetPopularMovies = MockGetPopularMovies();
    popularMovieBloc = PopularMovieBloc(
      mockGetPopularMovies
    );
  });

  test('initial state should be empty', (){
    expect(popularMovieBloc.state, PopularMovieEmpty());
  });

  blocTest<PopularMovieBloc, PopularMovieState>(
      'should emit when data is loaded successfully',
      build: (){
        when(mockGetPopularMovies.execute())
            .thenAnswer((_) async => Right(testMovieList));
        return popularMovieBloc;
      },
      act: (bloc) => bloc.add(OnFetchPopularMovie()),
      expect: () => [
        PopularMovieLoading(),
        PopularMovieHasData(testMovieList)
      ],
      verify: (bloc) => verify(mockGetPopularMovies.execute())
  );

  blocTest<PopularMovieBloc, PopularMovieState>(
      'should emit error when data is loaded unsuccessfully',
      build: (){
        when(mockGetPopularMovies.execute())
            .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
        return popularMovieBloc;
      },
      act: (bloc) => bloc.add(OnFetchPopularMovie()),
      expect: () => [
        PopularMovieLoading(),
        const PopularMovieError('Server Failure')
      ],
      verify: (bloc) => verify(mockGetPopularMovies.execute())
  );
}
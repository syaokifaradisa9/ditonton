import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movies/movies.dart';

import '../../dummy_data/dummy_objects.dart';
import 'top_rated_movies_bloc_test.mocks.dart';

@GenerateMocks([GetTopRatedMovies])
void main(){
  late TopRatedMovieBloc topRatedMovieBloc;
  late MockGetTopRatedMovies mockGetTopRatedMovies;

  setUp((){
    mockGetTopRatedMovies = MockGetTopRatedMovies();
    topRatedMovieBloc = TopRatedMovieBloc(
      mockGetTopRatedMovies
    );
  });

  test('initial state should be empty', (){
    expect(topRatedMovieBloc.state, TopRatedMovieEmpty());
  });

  blocTest<TopRatedMovieBloc, TopRatedMovieState>(
      'should emit when data is loaded successfully',
      build: (){
        when(mockGetTopRatedMovies.execute())
            .thenAnswer((_) async => Right(testMovieList));
        return topRatedMovieBloc;
      },
      act: (bloc) => bloc.add(OnFetchTopRatedMovie()),
      expect: () => [
        TopRatedMovieLoading(),
        TopRatedMovieHasData(testMovieList)
      ],
      verify: (bloc) => verify(mockGetTopRatedMovies.execute())
  );

  blocTest<TopRatedMovieBloc, TopRatedMovieState>(
      'should emit error when data is loaded unsuccessfully',
      build: (){
        when(mockGetTopRatedMovies.execute())
            .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
        return topRatedMovieBloc;
      },
      act: (bloc) => bloc.add(OnFetchTopRatedMovie()),
      expect: () => [
        TopRatedMovieLoading(),
        const TopRatedMovieError('Server Failure')
      ],
      verify: (bloc) => verify(mockGetTopRatedMovies.execute())
  );
}
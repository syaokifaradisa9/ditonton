import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movies/movies.dart';

import '../../dummy_data/dummy_objects.dart';
import 'search_movies_bloc_test.mocks.dart';

@GenerateMocks([SearchMovies])
void main(){
  late SearchMovieBloc searchMovieBloc;
  late MockSearchMovies mockSearchMovies;

  setUp((){
    mockSearchMovies = MockSearchMovies();
    searchMovieBloc = SearchMovieBloc(
      mockSearchMovies
    );
  });

  test('initial state should be empty', (){
    expect(searchMovieBloc.state, SearchMovieEmpty());
  });

  const query = 'abc';
  blocTest<SearchMovieBloc, SearchMovieState>(
      'should emit when data is loaded successfully',
      build: (){
        when(mockSearchMovies.execute(query))
            .thenAnswer((_) async => Right(testMovieList));
        return searchMovieBloc;
      },
      act: (bloc) => bloc.add(const OnQueryMovieChanged(query)),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        SearchMovieLoading(),
        SearchMovieHasData(testMovieList)
      ],
      verify: (bloc) => verify(mockSearchMovies.execute(query))
  );

  blocTest<SearchMovieBloc, SearchMovieState>(
      'should emit error when data is loaded unsuccessfully',
      build: (){
        when(mockSearchMovies.execute(query))
            .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
        return searchMovieBloc;
      },
      act: (bloc) => bloc.add(const OnQueryMovieChanged(query)),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        SearchMovieLoading(),
        const SearchMovieError('Server Failure')
      ],
      verify: (bloc) => verify(mockSearchMovies.execute(query))
  );
}
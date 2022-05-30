import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movies/movies.dart';
import '../../dummy_data/dummy_objects.dart';
import 'detail_movie_bloc_test.mocks.dart';

@GenerateMocks([GetMovieDetail])
void main(){
  late DetailMovieBloc detailMovieBloc;
  late MockGetMovieDetail mockGetMovieDetail;

  setUp((){
    mockGetMovieDetail = MockGetMovieDetail();
    detailMovieBloc = DetailMovieBloc(
      mockGetMovieDetail
    );
  });

  test('initial state should be empty', (){
    expect(detailMovieBloc.state, DetailMovieEmpty());
  });

  const tId = 1;
  blocTest<DetailMovieBloc, DetailMovieState>(
      'should emit when data is loaded successfully',
      build: (){
        when(mockGetMovieDetail.execute(tId))
            .thenAnswer((_) async => Right(testMovieDetail));
        return detailMovieBloc;
      },
      act: (bloc) => bloc.add(const OnFetchMovieDetail(tId)),
      expect: () => [
        DetailMovieLoading(),
        DetailMovieHasData(testMovieDetail)
      ],
      verify: (bloc) => verify(mockGetMovieDetail.execute(tId))
  );

  blocTest<DetailMovieBloc, DetailMovieState>(
      'should emit error when data is loaded unsuccessfully',
      build: (){
        when(mockGetMovieDetail.execute(tId))
            .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
        return detailMovieBloc;
      },
      act: (bloc) => bloc.add(const OnFetchMovieDetail(tId)),
      expect: () => [
        DetailMovieLoading(),
        const DetailMovieError('Server Failure')
      ],
      verify: (bloc) => verify(mockGetMovieDetail.execute(tId))
  );
}
import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tvseries/domain/usecases/get_tv_series_detail.dart';
import 'package:tvseries/presentation/bloc/detail/detail_tv_series_bloc.dart';
import '../../dummy_data/dummy_objects.dart';
import 'detail_tv_series_bloc_test.mocks.dart';

@GenerateMocks([GetTvSeriesDetail])
void main(){
  late DetailTvSeriesBloc detailTvSeriesBloc;
  late MockGetTvSeriesDetail mockGetTvSeriesDetail;

  setUp((){
    mockGetTvSeriesDetail = MockGetTvSeriesDetail();
    detailTvSeriesBloc = DetailTvSeriesBloc(
      mockGetTvSeriesDetail
    );
  });

  test('initial state should be empty', (){
    expect(detailTvSeriesBloc.state, DetailTvSeriesEmpty());
  });

  const tId = 1;
  blocTest<DetailTvSeriesBloc, DetailTvSeriesState>(
      'should emit when data is loaded successfully',
      build: (){
        when(mockGetTvSeriesDetail.execute(tId))
            .thenAnswer((_) async => Right(testTvSeriesDetail));
        return detailTvSeriesBloc;
      },
      act: (bloc) => bloc.add(const OnFetchTvSeriesDetail(tId)),
      expect: () => [
        DetailTvSeriesLoading(),
        DetailTvSeriesHasData(testTvSeriesDetail)
      ],
      verify: (bloc) => verify(mockGetTvSeriesDetail.execute(tId))
  );

  blocTest<DetailTvSeriesBloc, DetailTvSeriesState>(
      'should emit error when data is loaded unsuccessfully',
      build: (){
        when(mockGetTvSeriesDetail.execute(tId))
            .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
        return detailTvSeriesBloc;
      },
      act: (bloc) => bloc.add(const OnFetchTvSeriesDetail(tId)),
      expect: () => [
        DetailTvSeriesLoading(),
        const DetailTvSeriesError('Server Failure')
      ],
      verify: (bloc) => verify(mockGetTvSeriesDetail.execute(tId))
  );
}
import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tvseries/domain/usecases/search_tv_series.dart';
import 'package:tvseries/presentation/bloc/search/search_tv_series_bloc.dart';

import '../../dummy_data/dummy_objects.dart';
import 'search_tv_series_bloc_test.mocks.dart';

@GenerateMocks([SearchTvSeries])
void main(){
  late SearchTvSeriesBloc searchTvSeriesBloc;
  late MockSearchTvSeries mockSearchTvSeries;

  setUp((){
    mockSearchTvSeries = MockSearchTvSeries();
    searchTvSeriesBloc = SearchTvSeriesBloc(
      mockSearchTvSeries
    );
  });

  test('initial state should be empty', (){
    expect(searchTvSeriesBloc.state, SearchTvSeriesEmpty());
  });

  const query = 'abc';
  blocTest<SearchTvSeriesBloc, SearchTvSeriesState>(
      'should emit when data is loaded successfully',
      build: (){
        when(mockSearchTvSeries.execute(query))
            .thenAnswer((_) async => Right(testTvSeriesList));
        return searchTvSeriesBloc;
      },
      wait: const Duration(milliseconds: 500),
      act: (bloc) => bloc.add(const OnQueryTvSeriesChanged(query)),
      expect: () => [
        SearchTvSeriesLoading(),
        SearchTvSeriesHasData(testTvSeriesList)
      ],
      verify: (bloc) => verify(mockSearchTvSeries.execute(query))
  );

  blocTest<SearchTvSeriesBloc, SearchTvSeriesState>(
      'should emit error when data is loaded unsuccessfully',
      build: (){
        when(mockSearchTvSeries.execute(query))
            .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
        return searchTvSeriesBloc;
      },
      wait: const Duration(milliseconds: 500),
      act: (bloc) => bloc.add(const OnQueryTvSeriesChanged(query)),
      expect: () => [
        SearchTvSeriesLoading(),
        const SearchTvSeriesError('Server Failure')
      ],
      verify: (bloc) => verify(mockSearchTvSeries.execute(query))
  );
}
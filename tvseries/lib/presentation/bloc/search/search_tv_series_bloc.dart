import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tvseries/domain/entities/tv_series.dart';
import 'package:tvseries/domain/usecases/search_tv_series.dart';

part 'search_tv_series_event.dart';
part 'search_tv_series_state.dart';

class SearchTvSeriesBloc extends Bloc<SearchTvSeriesEvent, SearchTvSeriesState>{
  final SearchTvSeries _searchTvSeries;

  EventTransformer<T> debounce<T>(Duration duration) {
    return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
  }

  SearchTvSeriesBloc(this._searchTvSeries) : super(SearchTvSeriesEmpty()){
    on<OnQueryTvSeriesChanged>((event, emit) async{
      emit(SearchTvSeriesLoading());

      final movies = await _searchTvSeries.execute(event.query);
      movies.fold((failure){
        emit(SearchTvSeriesError(failure.message));
      }, (moviesData){
        emit(SearchTvSeriesHasData(moviesData));
      });
    },
    transformer: debounce(const Duration(milliseconds: 500)));
  }
}
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tvseries/domain/entities/tv_series.dart';
import 'package:tvseries/domain/usecases/get_popular_tv_series.dart';

part 'popular_tv_series_event.dart';
part 'popular_tv_series_state.dart';

class PopularTvSeriesBloc extends Bloc<PopularTvSeriesEvent, PopularTvSeriesState>{
  final GetPopularTvSeries _getPopularTvSeries;
  PopularTvSeriesBloc(this._getPopularTvSeries) : super(PopularTvSeriesEmpty()){
    on<OnFetchPopularTvSeries>((event, emit) async{
      emit(PopularTvSeriesLoading());

      final movies = await _getPopularTvSeries.execute();
      movies.fold((failure){
        emit(PopularTvSeriesError(failure.message));
      }, (moviesData){
        emit(PopularTvSeriesHasData(moviesData));
      });
    });
  }
}
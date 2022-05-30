import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tvseries/domain/entities/tv_series.dart';
import 'package:tvseries/domain/usecases/get_watchlist_tv_series.dart';

part 'watchlist_tv_series_event.dart';
part 'watchlist_tv_series_state.dart';

class WatchlistTvSeriesBloc extends Bloc<WatchlistTvSeriesEvent, WatchlistTvSeriesState>{
  final GetWatchlistTvSeries _getWatchlistTvSeries;

  WatchlistTvSeriesBloc(this._getWatchlistTvSeries) : super(WatchlistTvSeriesEmpty()){
    on<OnFetchWatchlistTvSeries>((event, emit) async{
      emit(WatchlistTvSeriesLoading());

      var result = await _getWatchlistTvSeries.execute();
      result.fold((failure){
        emit(WatchlistTvSeriesError(failure.message));
      }, (moviesData){
        emit(WatchlistTvSeriesHasData(moviesData));
      });
    });
  }
}
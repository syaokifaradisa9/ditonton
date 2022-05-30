import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tvseries/domain/entities/tv_series.dart';
import 'package:tvseries/domain/usecases/get_now_playing_tv_series.dart';

part 'now_playing_tv_series_event.dart';
part 'now_playing_tv_series_state.dart';

class NowPlayingTvSeriesBloc extends Bloc<NowPlayingTvSeriesEvent, NowPlayingTvSeriesState>{
  final GetNowPlayingTvSeries _getNowPlayingTvSeries;

  NowPlayingTvSeriesBloc(this._getNowPlayingTvSeries) : super(NowPlayingTvSeriesEmpty()){
    on<OnFetchNowPlayingTvSeries>((event, emit) async{
      emit(NowPlayingTvSeriesLoading());

      final movies = await _getNowPlayingTvSeries.execute();
      movies.fold((failure){
        emit(NowPlayingTvSeriesError(failure.message));
      }, (moviesData){
        emit(NowPlayingHasData(moviesData));
      });
    });
  }
}
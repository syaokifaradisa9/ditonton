import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tvseries/domain/entities/tv_series.dart';
import 'package:tvseries/domain/usecases/get_top_rated_tv_series.dart';

part 'top_rated_tv_series_event.dart';
part 'top_rated_tv_series_state.dart';

class TopRatedTvSeriesBloc extends Bloc<TopRatedTvSeriesEvent, TopRatedTvSeriesState>{
  final GetTopRatedTvSeries _getTopRatedTvSeries;
  TopRatedTvSeriesBloc(this._getTopRatedTvSeries) : super(TopRatedTvSeriesEmpty()){
    on<OnFetchTopRatedTvSeries>((event, emit) async{
      emit(TopRatedTvSeriesLoading());

      final tvSeries = await _getTopRatedTvSeries.execute();
      tvSeries.fold((failure){
        emit(TopRatedTvSeriesError(failure.message));
      }, (tvSeriesData){
        emit(TopRatedTvSeriesHasData(tvSeriesData));
      });
    });
  }
}
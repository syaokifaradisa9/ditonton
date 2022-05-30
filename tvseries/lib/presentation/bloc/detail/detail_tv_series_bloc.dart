import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tvseries/domain/entities/tv_detail.dart';
import 'package:tvseries/domain/usecases/get_tv_series_detail.dart';

part 'detail_tv_series_event.dart';
part 'detail_tv_series_state.dart';

class DetailTvSeriesBloc extends Bloc<DetailTvSeriesEvent, DetailTvSeriesState>{
  final GetTvSeriesDetail _getTvSeriesDetail;

  DetailTvSeriesBloc(this._getTvSeriesDetail) : super(DetailTvSeriesEmpty()){
    on<OnFetchTvSeriesDetail>((event, emit) async{
      emit(DetailTvSeriesLoading());

      final tvSeries = await _getTvSeriesDetail.execute(event.id);
      tvSeries.fold((failure){
        emit(DetailTvSeriesError(failure.message));
      }, (moviesData){
        emit(DetailTvSeriesHasData(moviesData));
      });
    });
  }
}
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tvseries/domain/entities/tv_series.dart';
import 'package:tvseries/domain/usecases/get_tv_series_recommendations.dart';

part 'recommendation_tv_series_event.dart';
part 'recommendation_tv_series_state.dart';

class RecommendationTvSeriesBloc extends Bloc<RecommendationTvSeriesEvent, RecommendationTvSeriesState>{
  final GetTvSeriesRecommendations _getTvSeriesRecommendations;

  RecommendationTvSeriesBloc(this._getTvSeriesRecommendations) : super(RecommendationTvSeriesEmpty()){
    on<OnFetchRecommendationTvSeries>((event, emit) async{
       emit(RecommendationTvSeriesLoading());

       final tvSeries = await _getTvSeriesRecommendations.execute(event.id);
       tvSeries.fold((failure) {
         emit(RecommendationMovieError(failure.message));
       }, (tvSeriesData){
          emit(RecommendationTvSeriesHasData(tvSeriesData));
       });
    });
  }

}
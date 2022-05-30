part of 'recommendation_tv_series_bloc.dart';

abstract class RecommendationTvSeriesEvent extends Equatable{
  const RecommendationTvSeriesEvent();

  @override
  List<Object> get props => [];
}

class OnFetchRecommendationTvSeries extends RecommendationTvSeriesEvent{
  final int id;
  const OnFetchRecommendationTvSeries(this.id);

  @override
  List<Object> get props => [id];
}
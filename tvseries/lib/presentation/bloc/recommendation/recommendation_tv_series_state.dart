part of 'recommendation_tv_series_bloc.dart';

abstract class RecommendationTvSeriesState extends Equatable{
  const RecommendationTvSeriesState();

  @override
  List<Object> get props => [];
}

class RecommendationTvSeriesEmpty extends RecommendationTvSeriesState {}

class RecommendationTvSeriesLoading extends RecommendationTvSeriesState {}

class RecommendationTvSeriesHasData extends RecommendationTvSeriesState{
  final List<TvSeries> recommendationTvSeries;
  const RecommendationTvSeriesHasData(this.recommendationTvSeries);

  @override
  List<Object> get props => [recommendationTvSeries];
}

class RecommendationMovieError extends RecommendationTvSeriesState{
  final String message;
  const RecommendationMovieError(this.message);

  @override
  List<Object> get props => [message];
}
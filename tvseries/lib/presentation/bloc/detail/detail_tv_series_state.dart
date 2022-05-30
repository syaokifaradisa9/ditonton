part of 'detail_tv_series_bloc.dart';

abstract class DetailTvSeriesState extends Equatable{
  const DetailTvSeriesState();

  @override
  List<Object> get props => [];
}

class DetailTvSeriesEmpty extends DetailTvSeriesState{}

class DetailTvSeriesLoading extends DetailTvSeriesState{}

class DetailTvSeriesHasData extends DetailTvSeriesState{
  final TvSeriesDetail tvSeries;
  const DetailTvSeriesHasData(this.tvSeries);

  @override
  List<Object> get props => [tvSeries];
}

class DetailTvSeriesError extends DetailTvSeriesState{
  final String message;
  const DetailTvSeriesError(this.message);

  @override
  List<Object> get props => [message];
}
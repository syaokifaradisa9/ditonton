part of 'search_tv_series_bloc.dart';

abstract class SearchTvSeriesState extends Equatable{
  const SearchTvSeriesState();

  @override
  List<Object> get props => [];
}

class SearchTvSeriesEmpty extends SearchTvSeriesState{}

class SearchTvSeriesLoading extends SearchTvSeriesState{}

class SearchTvSeriesHasData extends SearchTvSeriesState{
  final List<TvSeries> tvSeries;
  const SearchTvSeriesHasData(this.tvSeries);

  @override
  List<Object> get props => [tvSeries];
}

class SearchTvSeriesError extends SearchTvSeriesState{
  final String message;
  const SearchTvSeriesError(this.message);

  @override
  List<Object> get props => [message];
}
part of 'watchlist_tv_series_status_bloc.dart';

abstract class WatchlistTvSeriesStatusState extends Equatable{
  const WatchlistTvSeriesStatusState();

  @override
  List<Object> get props => [];
}

class WatchlistTvSeriesStatusEmpty extends WatchlistTvSeriesStatusState{}

class WatchlistTvSeriesStatusLoading extends WatchlistTvSeriesStatusState{}

class WatchlistTvSeriesStatusError extends WatchlistTvSeriesStatusState{
  final String message;
  const WatchlistTvSeriesStatusError(this.message);

  @override
  List<Object> get props => [message];
}

class WatchlistTvSeriesStatusHasData extends WatchlistTvSeriesStatusState{
  bool isAdded;
  String message;
  WatchlistTvSeriesStatusHasData({required this.isAdded, required this.message});

  @override
  List<Object> get props => [isAdded, message];
}
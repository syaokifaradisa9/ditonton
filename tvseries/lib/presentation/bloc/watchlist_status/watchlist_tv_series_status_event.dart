part of 'watchlist_tv_series_status_bloc.dart';

abstract class WatchlistTvSeriesStatusEvent extends Equatable{
  const WatchlistTvSeriesStatusEvent();

  @override
  List<Object> get props => [];
}

class OnFetchWatchlistStatus extends WatchlistTvSeriesStatusEvent{
  final int id;
  const OnFetchWatchlistStatus(this.id);

  @override
  List<Object> get props => [id];
}

class OnAddedToWatchlist extends WatchlistTvSeriesStatusEvent{
  final TvSeriesDetail tvSeries;
  const OnAddedToWatchlist(this.tvSeries);

  @override
  List<Object> get props => [tvSeries];
}

class OnRemoveFromWatchList extends WatchlistTvSeriesStatusEvent{
  final TvSeriesDetail tvSeries;
  const OnRemoveFromWatchList(this.tvSeries);

  @override
  List<Object> get props => [tvSeries];
}
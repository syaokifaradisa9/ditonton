part of 'watchlist_movie_status_bloc.dart';

abstract class WatchlistMovieStatusEvent extends Equatable{
  const WatchlistMovieStatusEvent();

  @override
  List<Object> get props => [];
}

class OnFetchWatchlistStatus extends WatchlistMovieStatusEvent{
  final int id;
  const OnFetchWatchlistStatus(this.id);

  @override
  List<Object> get props => [id];
}

class OnAddedToWatchlist extends WatchlistMovieStatusEvent{
  final MovieDetail movie;
  const OnAddedToWatchlist(this.movie);

  @override
  List<Object> get props => [movie];
}

class OnRemoveFromWatchList extends WatchlistMovieStatusEvent{
  final MovieDetail movie;
  const OnRemoveFromWatchList(this.movie);

  @override
  List<Object> get props => [movie];
}
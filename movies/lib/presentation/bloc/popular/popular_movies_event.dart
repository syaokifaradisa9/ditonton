part of 'popular_movies_bloc.dart';

abstract class PopularMovieEvent extends Equatable{
  const PopularMovieEvent();

  @override
  List<Object> get props => [];
}

class OnFetchPopularMovie extends PopularMovieEvent{}
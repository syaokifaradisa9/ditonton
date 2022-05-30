part of 'recommendation_movie_bloc.dart';

abstract class RecommendationMovieState extends Equatable{
  const RecommendationMovieState();

  @override
  List<Object> get props => [];
}

class RecommendationMovieEmpty extends RecommendationMovieState {}

class RecommendationMovieLoading extends RecommendationMovieState {}

class RecommendationMovieHasData extends RecommendationMovieState{
  final List<Movie> recommendationMovie;
  const RecommendationMovieHasData(this.recommendationMovie);

  @override
  List<Object> get props => [recommendationMovie];
}

class RecommendationMovieError extends RecommendationMovieState{
  final String message;
  const RecommendationMovieError(this.message);

  @override
  List<Object> get props => [message];
}
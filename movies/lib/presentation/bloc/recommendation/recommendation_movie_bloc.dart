import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/domain/entities/movie.dart';
import 'package:movies/domain/usecases/get_movie_recommendations.dart';

part 'recommendation_movie_event.dart';
part 'recommendation_movie_state.dart';

class RecommendationMovieBloc extends Bloc<RecommendationMovieEvent, RecommendationMovieState>{
  final GetMovieRecommendations _getMovieRecommendations;

  RecommendationMovieBloc(this._getMovieRecommendations) : super(RecommendationMovieEmpty()){
    on<OnFetchRecommendationMovie>((event, emit) async{
       emit(RecommendationMovieLoading());

       final movies = await _getMovieRecommendations.execute(event.id);
       movies.fold((failure) {
         emit(RecommendationMovieError(failure.message));
       }, (moviesData){
          emit(RecommendationMovieHasData(moviesData));
       });
    });
  }

}
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/presentation/bloc/top_rated/top_rated_movies_bloc.dart';
import 'package:movies/presentation/widgets/movie_card_list.dart';

class TopRatedMoviesPage extends StatefulWidget {
  const TopRatedMoviesPage({Key? key}) : super(key: key);

  @override
  _TopRatedMoviesPageState createState() => _TopRatedMoviesPageState();
}

class _TopRatedMoviesPageState extends State<TopRatedMoviesPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => BlocProvider.of<TopRatedMovieBloc>(context).add(
      OnFetchTopRatedMovie())
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Top Rated Movies'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<TopRatedMovieBloc, TopRatedMovieState>(
            builder: (context, state){
              if(state is TopRatedMovieLoading){
                return const Center(child: CircularProgressIndicator());
              }else if(state is TopRatedMovieHasData){
                return ListView.builder(
                  itemBuilder: (context, index) {
                    final movie = state.topRatedMovies[index];
                    return MovieCard(movie);
                  },
                  itemCount: state.topRatedMovies.length,
                );
              }else{
                return const Text('Failed');
              }
            }
        )
      ),
    );
  }
}

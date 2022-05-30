import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/presentation/bloc/popular/popular_movies_bloc.dart';
import '../widgets/movie_card_list.dart';
import 'package:flutter/material.dart';

class PopularMoviesPage extends StatefulWidget {
  const PopularMoviesPage({Key? key}) : super(key: key);

  @override
  _PopularMoviesPageState createState() => _PopularMoviesPageState();
}

class _PopularMoviesPageState extends State<PopularMoviesPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => BlocProvider.of<PopularMovieBloc>(context).add(
      OnFetchPopularMovie())
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Popular Movies'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<PopularMovieBloc, PopularMovieState>(
            builder: (context, state){
              if(state is PopularMovieLoading){
                return const Center(child: CircularProgressIndicator());
              }else if(state is PopularMovieHasData){
                return ListView.builder(
                  itemBuilder: (context, index) {
                    final movie = state.popularMovies[index];
                    return MovieCard(movie);
                  },
                  itemCount: state.popularMovies.length,
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

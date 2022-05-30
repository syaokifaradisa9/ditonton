import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:movies/domain/entities/genre.dart';
import 'package:movies/presentation/bloc/detail/detail_movie_bloc.dart';
import 'package:movies/presentation/bloc/recommendation/recommendation_movie_bloc.dart';
import 'package:movies/presentation/bloc/watchlist_status/watchlist_movie_status_bloc.dart';
import '../../domain/entities/movie_detail.dart';
import 'package:flutter/material.dart';

class MovieDetailPage extends StatefulWidget {
  final int id;
  const MovieDetailPage({Key? key, required this.id}) : super(key: key);

  @override
  _MovieDetailPageState createState() => _MovieDetailPageState();
}

class _MovieDetailPageState extends State<MovieDetailPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      BlocProvider.of<DetailMovieBloc>(context).add(
        OnFetchMovieDetail(widget.id)
      );
      BlocProvider.of<WatchlistMovieStatusBloc>(context).add(
        OnFetchWatchlistStatus(widget.id)
      );
      BlocProvider.of<RecommendationMovieBloc>(context).add(
        OnFetchRecommendationMovie(widget.id)
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<DetailMovieBloc, DetailMovieState>(
        builder: (context, state){
          if(state is DetailMovieLoading){
            return const Center(child: CircularProgressIndicator());
          }else if(state is DetailMovieHasData){
            final movie = state.movie;
            return SafeArea(
              child: DetailContent(movie),
            );
          }else{
            return const Text('Failed');
          }
        }
      )
    );
  }
}

class DetailContent extends StatelessWidget {
  final MovieDetail movie;
  const DetailContent(this.movie, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Stack(
      children: [
        CachedNetworkImage(
          imageUrl: 'https://image.tmdb.org/t/p/w500${movie.posterPath}',
          width: screenWidth,
          placeholder: (context, url) => const Center(
            child: CircularProgressIndicator(),
          ),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        ),
        Container(
          margin: const EdgeInsets.only(top: 48 + 8),
          child: DraggableScrollableSheet(
            builder: (context, scrollController) {
              return Container(
                decoration: const BoxDecoration(
                  color: kRichBlack,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                ),
                padding: const EdgeInsets.only(
                  left: 16,
                  top: 16,
                  right: 16,
                ),
                child: Stack(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 16),
                      child: SingleChildScrollView(
                        controller: scrollController,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              movie.title,
                              style: kHeading5,
                            ),
                            BlocConsumer<WatchlistMovieStatusBloc, WatchlistMovieStatusState>(
                              listener: (context, state){
                                if(state is WatchlistMovieStatusHasData){
                                  if(state.message.isNotEmpty){
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(state.message),
                                        duration: const Duration(milliseconds: 700)
                                      )
                                    );
                                  }
                                }
                              },
                              builder: (context, state){
                                if(state is WatchlistMovieStatusHasData){
                                  return ElevatedButton(
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Icon(
                                            state.isAdded ? Icons.check : Icons.add
                                        ),
                                        const Text('Watchlist'),
                                      ],
                                    ),
                                    onPressed: (){
                                      if(state.isAdded){
                                        context.read<WatchlistMovieStatusBloc>().add(
                                          OnRemoveFromWatchList(movie)
                                        );
                                      }else{
                                        context.read<WatchlistMovieStatusBloc>().add(
                                          OnAddedToWatchlist(movie)
                                        );
                                      }
                                    },
                                  );
                                }else{
                                  return const Center(
                                    child: CircularProgressIndicator()
                                  );
                                }
                              }
                            ),
                            Text(
                              _showGenres(movie.genres),
                            ),
                            Text(
                              _showDuration(movie.runtime),
                            ),
                            Row(
                              children: [
                                RatingBarIndicator(
                                  rating: movie.voteAverage / 2,
                                  itemCount: 5,
                                  itemBuilder: (context, index) => const Icon(
                                    Icons.star,
                                    color: kMikadoYellow,
                                  ),
                                  itemSize: 24,
                                ),
                                Text('${movie.voteAverage}')
                              ],
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Overview',
                              style: kHeading6,
                            ),
                            Text(
                              movie.overview,
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Recommendations',
                              style: kHeading6,
                            ),
                            SizedBox(
                                height: 150,
                                child: BlocBuilder<RecommendationMovieBloc, RecommendationMovieState>(
                                    builder: (context, state){
                                      if(state is RecommendationMovieLoading){
                                        return const Center(child: CircularProgressIndicator());
                                      }else if(state is RecommendationMovieHasData){
                                        return ListView.builder(
                                          scrollDirection: Axis.horizontal,
                                          itemBuilder: (context, index) {
                                            final movie = state.recommendationMovie[index];
                                            return Padding(
                                              padding: const EdgeInsets.all(4.0),
                                              child: InkWell(
                                                onTap: () {
                                                  Navigator.pushReplacementNamed(
                                                    context,
                                                    MOVIE_DETAIL_ROUTE,
                                                    arguments: movie.id,
                                                  );
                                                },
                                                child: ClipRRect(
                                                  borderRadius: const BorderRadius.all(
                                                    Radius.circular(8),
                                                  ),
                                                  child: CachedNetworkImage(
                                                    imageUrl:
                                                    'https://image.tmdb.org/t/p/w500${movie.posterPath}',
                                                    placeholder: (context, url) =>
                                                    const Center(
                                                      child:
                                                      CircularProgressIndicator(),
                                                    ),
                                                    errorWidget:
                                                        (context, url, error) =>
                                                    const Icon(Icons.error),
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                          itemCount: state.recommendationMovie.length,
                                        );
                                      }else{
                                        return const Center(
                                          child: Text('Failed'),
                                        );
                                      }
                                    }
                                )
                            )
                          ],
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        color: Colors.white,
                        height: 4,
                        width: 48,
                      ),
                    ),
                  ],
                ),
              );
            },
            // initialChildSize: 0.5,
            minChildSize: 0.25,
            // maxChildSize: 1.0,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundColor: kRichBlack,
            foregroundColor: Colors.white,
            child: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        )
      ],
    );
  }

  String _showGenres(List<Genre> genres) {
    String result = '';
    for (var genre in genres) {
      result += '${genre.name}, ';
    }

    if (result.isEmpty) {
      return result;
    }

    return result.substring(0, result.length - 2);
  }

  String _showDuration(int runtime) {
    final int hours = runtime ~/ 60;
    final int minutes = runtime % 60;

    if (hours > 0) {
      return '${hours}h ${minutes}m';
    } else {
      return '${minutes}m';
    }
  }
}

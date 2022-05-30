import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:tvseries/domain/entities/genre.dart';
import 'package:tvseries/domain/entities/tv_detail.dart';
import 'package:tvseries/presentation/bloc/detail/detail_tv_series_bloc.dart';
import 'package:tvseries/presentation/bloc/recommendation/recommendation_tv_series_bloc.dart';
import 'package:tvseries/presentation/bloc/watchlist_status/watchlist_tv_series_status_bloc.dart';


class TvSeriesDetailPage extends StatefulWidget {
  final int id;
  const TvSeriesDetailPage({Key? key, required this.id}) : super(key: key);

  @override
  _TvSeriesDetailPageState createState() => _TvSeriesDetailPageState();
}

class _TvSeriesDetailPageState extends State<TvSeriesDetailPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      BlocProvider.of<DetailTvSeriesBloc>(context).add(
        OnFetchTvSeriesDetail(widget.id)
      );
      BlocProvider.of<WatchlistTvSeriesStatusBloc>(context).add(
        OnFetchWatchlistStatus(widget.id)
      );
      BlocProvider.of<RecommendationTvSeriesBloc>(context).add(
        OnFetchRecommendationTvSeries(widget.id)
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<DetailTvSeriesBloc, DetailTvSeriesState>(
          builder: (context, state){
            if(state is DetailTvSeriesLoading){
              return const Center(child: CircularProgressIndicator());
            }else if(state is DetailTvSeriesHasData){
              final tvSeries = state.tvSeries;
              return SafeArea(
                child: DetailContent(tvSeries),
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
  final TvSeriesDetail tvSeries;
  const DetailContent(this.tvSeries, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        CachedNetworkImage(
          imageUrl: 'https://image.tmdb.org/t/p/w500${tvSeries.posterPath}',
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
                              tvSeries.name,
                              style: kHeading5,
                            ),
                            BlocConsumer<WatchlistTvSeriesStatusBloc, WatchlistTvSeriesStatusState>(
                                listener: (context, state){
                                  if(state is WatchlistTvSeriesStatusHasData){
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
                                  if(state is WatchlistTvSeriesStatusHasData){
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
                                          context.read<WatchlistTvSeriesStatusBloc>().add(
                                            OnRemoveFromWatchList(tvSeries)
                                          );
                                        }else{
                                          context.read<WatchlistTvSeriesStatusBloc>().add(
                                            OnAddedToWatchlist(tvSeries)
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
                            Text(_showGenres(tvSeries.genres)),
                            Row(
                              children: [
                                RatingBarIndicator(
                                  rating: tvSeries.voteAverage / 2,
                                  itemCount: 5,
                                  itemBuilder: (context, index) => const Icon(
                                    Icons.star,
                                    color: kMikadoYellow,
                                  ),
                                  itemSize: 24,
                                ),
                                Text('${tvSeries.voteAverage}')
                              ],
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Overview',
                              style: kHeading6,
                            ),
                            Text(tvSeries.overview,),
                            const SizedBox(height: 16),
                            Text(
                              'Number of Episode',
                              style: kHeading6,
                            ),
                            Text("${tvSeries.numberOfEpisode.toString()} Episode"),
                            const SizedBox(height: 16),
                            Text(
                              'Last Episode',
                              style: kHeading6,
                            ),
                            Text(
                                "Episode ${tvSeries.lastEpisode.episodeNumber}"
                                " in season ${tvSeries.lastEpisode.seasonNumber}"
                                " \n${tvSeries.overview}"
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Homepage',
                              style: kHeading6,
                            ),
                            Text(tvSeries.homepage),
                            const SizedBox(height: 16),
                            Text(
                              'Seasons (${tvSeries.numberOfSeason.toString()})',
                              style: kHeading6,
                            ),
                            SizedBox(
                              height: 150,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: tvSeries.seasons.length,
                                itemBuilder: (context, index) {
                                  final tvSeriesSeason = tvSeries.seasons[index];
                                  return Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: InkWell(
                                      onTap: () {
                                        Navigator.pushReplacementNamed(
                                          context,
                                          TV_DETAIL_ROUTE,
                                          arguments: tvSeriesSeason.id,
                                        );
                                      },
                                      child: ClipRRect(
                                        borderRadius: const BorderRadius.all(
                                          Radius.circular(8),
                                        ),
                                        child: CachedNetworkImage(
                                          imageUrl:
                                          'https://image.tmdb.org/t/p/w500${tvSeriesSeason.posterPath}',
                                          placeholder: (context, url) =>
                                          const Center(
                                            child: CircularProgressIndicator(),
                                          ),
                                          errorWidget: (context, url, error) =>
                                            const Icon(Icons.error),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Recommendations',
                              style: kHeading6,
                            ),
                            SizedBox(
                                height: 150,
                                child: BlocBuilder<RecommendationTvSeriesBloc, RecommendationTvSeriesState>(
                                    builder: (context, state){
                                      if(state is RecommendationTvSeriesLoading){
                                        return const Center(child: CircularProgressIndicator());
                                      }else if(state is RecommendationTvSeriesHasData){
                                        return ListView.builder(
                                          scrollDirection: Axis.horizontal,
                                          itemBuilder: (context, index) {
                                            final movie = state.recommendationTvSeries[index];
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
                                          itemCount: state.recommendationTvSeries.length,
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
      result += genre.name + ', ';
    }

    if (result.isEmpty) {
      return result;
    }

    return result.substring(0, result.length - 2);
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tvseries/presentation/bloc/popular/popular_tv_series_bloc.dart';
import 'package:tvseries/presentation/widgets/tv_series_card_list.dart';

class PopularTvSeriesPage extends StatefulWidget {
  const PopularTvSeriesPage({Key? key}) : super(key: key);

  @override
  _PopularTvSeriesPageState createState() => _PopularTvSeriesPageState();
}

class _PopularTvSeriesPageState extends State<PopularTvSeriesPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => BlocProvider.of<PopularTvSeriesBloc>(context).add(
      OnFetchPopularTvSeries()
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Popular Tv Series'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<PopularTvSeriesBloc, PopularTvSeriesState>(
            builder: (context, state){
              if(state is PopularTvSeriesLoading){
                return const Center(child: CircularProgressIndicator());
              }else if(state is PopularTvSeriesHasData){
                return ListView.builder(
                  itemBuilder: (context, index) {
                    final movie = state.popularMovies[index];
                    return TvSeriesCard(movie);
                  },
                  itemCount: state.popularMovies.length,
                );
              }else{
                return const Text('Failed');
              }
            }
        ),
      ),
    );
  }
}

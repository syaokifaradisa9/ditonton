import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tvseries/presentation/bloc/top_rated/top_rated_tv_series_bloc.dart';
import 'package:tvseries/presentation/widgets/tv_series_card_list.dart';

class TopRatedTvSeriesPage extends StatefulWidget {
  const TopRatedTvSeriesPage({Key? key}) : super(key: key);

  @override
  _TopRatedTvSeriesPageState createState() => _TopRatedTvSeriesPageState();
}

class _TopRatedTvSeriesPageState extends State<TopRatedTvSeriesPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => BlocProvider.of<TopRatedTvSeriesBloc>(context).add(
      OnFetchTopRatedTvSeries())
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Top Rated Tv Series'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<TopRatedTvSeriesBloc, TopRatedTvSeriesState>(
            builder: (context, state){
              if(state is TopRatedTvSeriesLoading){
                return const Center(child: CircularProgressIndicator());
              }else if(state is TopRatedTvSeriesHasData){
                return ListView.builder(
                  itemBuilder: (context, index) {
                    final tvSeries = state.topRatedTvSeries[index];
                    return TvSeriesCard(tvSeries);
                  },
                  itemCount: state.topRatedTvSeries.length,
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

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tvseries/presentation/bloc/now_playing/now_playing_tv_series_bloc.dart';
import 'package:tvseries/presentation/widgets/tv_series_card_list.dart';

class NowPlayingTvSeriesPage extends StatefulWidget {

  const NowPlayingTvSeriesPage({Key? key}) : super(key: key);

  @override
  _NowPlayingTvSeriesPageState createState() => _NowPlayingTvSeriesPageState();
}

class _NowPlayingTvSeriesPageState extends State<NowPlayingTvSeriesPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(()=> BlocProvider.of<NowPlayingTvSeriesBloc>(context).add(
      OnFetchNowPlayingTvSeries()
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Now Playing Tv Series'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<NowPlayingTvSeriesBloc, NowPlayingTvSeriesState>(
            builder: (context, state){
              if(state is NowPlayingTvSeriesLoading){
                return const Center(child: CircularProgressIndicator());
              }else if(state is NowPlayingHasData){
                return ListView.builder(
                  itemBuilder: (context, index) => TvSeriesCard(
                    state.tvSeries[index]
                  ),
                  itemCount: state.tvSeries.length,
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

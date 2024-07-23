import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify_app/core/config/constans/app_url.dart';
import 'package:spotify_app/presentation/home/bloc/news_songs_cubit.dart';
import 'package:spotify_app/presentation/home/bloc/news_songs_state.dart';

import '../../../domain/entities/song/song.dart';

class NewsSongs extends StatelessWidget {
  const NewsSongs({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_)=>NewsSongsCubit()..getNewsSongs(),
      child: SizedBox(
        height: 200,
        child: BlocBuilder(
          builder: (context, state) {
            if(state is NewsSongsLoading){
              return Container(
                alignment: Alignment.center,
                child: CircularProgressIndicator());
            }
            if(state is NewsSongsLoad){
              return _song(state.songs);
            }
            return Center();
          },
          )
      ),);
  }
  Widget _song(List<SongEntity> song){
    return ListView.separated(
      scrollDirection: Axis.horizontal,
      shrinkWrap: true,
          itemBuilder: (context, index) {
            return SizedBox(
              width: 160,
              child: Column(
                children: [
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage(
                                  AppUrl.firestorage+song[index].artist+'.jfif?'+AppUrl.mediaAlt
                                )
                              )
                            ),
                          ),
                        )
                ],
              ),
            );
          }, 
          separatorBuilder: (context, index) => SizedBox(width: 14,), 
          itemCount: song.length);
  }
}
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify_app/common/helper/is_dark.dart';
import 'package:spotify_app/core/config/themes/app_color.dart';
import 'package:spotify_app/domain/entities/song/song.dart';
import 'package:spotify_app/presentation/song_player/bloc/song_player_cubit.dart';
import 'package:spotify_app/presentation/song_player/bloc/song_player_state.dart';

import '../../../common/widget/favorite/favorite_button.dart';
import '../../../core/config/constans/app_url.dart';

class SongPlayerPage extends StatelessWidget {
  final SongEntity songEntity;
  const SongPlayerPage({super.key, required this.songEntity});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColor.darkBackground,
        leading: IconButton(
          onPressed: (){
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios,color:context.isDarkMode? Colors.white:Colors.black,),
        ),
        title: Text("Now Playing", style: TextStyle(
          fontWeight: FontWeight.bold, fontSize: 22,
          color: context.isDarkMode?Colors.white:Colors.black
        ),),
        actions: [IconButton(onPressed: (){}, icon: Icon(Icons.more_vert_rounded,color: context.isDarkMode?Colors.white:Colors.black))],
      ),
      body: BlocProvider(
        create: (_)=>SongPlayerCubit()..loadSong(AppUrl.songfirestorage+songEntity.title+'.mp3?'+AppUrl.mediaAlt),
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(vertical: 16,horizontal: 16),
          child: Column(
            children: [
              _songCover(context),
              SizedBox(height: 20,),
              Row(
        
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(songEntity.name,style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: context.isDarkMode?Colors.white:Colors.black
                      ),),
                      SizedBox(height: 8,),
                      Text(songEntity.artist,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: context.isDarkMode?Colors.white:Colors.black
                      ))
                    ],
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: FavoriteButton(songEntity: songEntity))
                ],
              ),
              SizedBox(height: 30,),
              _songPlayer(context)
            ],
          ),
        ),
      ),
    );
  }
  Widget _songCover(BuildContext context){
    return Container(
      height: MediaQuery.of(context).size.height/2.2,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        image: DecorationImage(
          fit: BoxFit.cover,
          image: NetworkImage(
            AppUrl.firestorage+songEntity.title+'.jfif?'+AppUrl.mediaAlt
          ))
      ),
    );
  }
  Widget _songPlayer(BuildContext context){
    return BlocBuilder<SongPlayerCubit,SongPlayerState>(
      builder: (context, state) {
        if(state is SongPlayerLoading){
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if(state is SongPlayerLoaded){
          return Column(
            children: [
              Slider(
                value: context.read<SongPlayerCubit>().songPosition.inSeconds.toDouble(),
                min: 0,
                max: context.read<SongPlayerCubit>().songDuration.inSeconds.toDouble(),
                onChanged: (value){}),
                const SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      formatDuration(
                        context.read<SongPlayerCubit>().songPosition
                      )
                    ),
                    Text(
                      formatDuration(
                        context.read<SongPlayerCubit>().songDuration
                      )
                    ),
                  ],
                ),
                
                GestureDetector(
                  onTap: (){
                    context.read<SongPlayerCubit>().playOrPauseSong();
                  },
                  child: Container(
                    width: 60,
                    height: 60,
                    child: Icon(
                      context.read<SongPlayerCubit>().audioPlayer.playing? Icons.pause : Icons.play_arrow
                    ),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColor.primary
                    ),
                  ),
                )
            ],

          );
        }
        return Container();
      },
      );
  }
  String formatDuration(Duration duration){
    final minutes = duration.inMinutes.remainder(60);
    final seconds = duration.inSeconds.remainder(60);
    return '${minutes.toString().padLeft(2,'0')}:${seconds.toString().padLeft(2,'0')}';
  }
}
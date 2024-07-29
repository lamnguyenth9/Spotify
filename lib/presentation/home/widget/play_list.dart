import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify_app/common/helper/is_dark.dart';
import 'package:spotify_app/common/widget/favorite/favorite_button.dart';
import 'package:spotify_app/core/config/themes/app_color.dart';
import 'package:spotify_app/presentation/home/bloc/play_list_cubit.dart';
import 'package:spotify_app/presentation/home/bloc/play_list_state.dart';

import '../../../domain/entities/song/song.dart';
import '../../song_player/pages/song_player.dart';

class PlayList extends StatelessWidget {
  const PlayList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_)=>PlayListCubit()..getPlayList(),
      child: BlocBuilder<PlayListCubit,PlayListState>(
        builder: (context, state) {
          if(state is PlayListLoading){
            return const Center(child: CircularProgressIndicator(),);
          }
          if(state is PlayListLoad){
            return  Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16, vertical: 40  
              ),
              child: Column(
                children: [
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Playlist",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16
                      ),),
                      Text("See more",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 14
                      ))
                    ],
                  ),
                  // ignore: prefer_const_constructors
                  SizedBox(height: 20,),
                  _song(state.songs)
                ],
              ),
            );
          }
          if(state is PlayListLoadingFailure){
              return const Text("2");
            }
          return const Text("hi");
        },
        ),
      );
  }
 Widget _song(List<SongEntity> songs){
  return ListView.separated(
    shrinkWrap: true,
    itemBuilder: (context, index) {
      return GestureDetector(
        onTap: (){
          Navigator.push(context, MaterialPageRoute(builder: (_)=>SongPlayerPage(songEntity: songs[index],)));
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Row(
                children: [
                  Container(
                    height: 30,
                    width: 30,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: context.isDarkMode?AppColor.darkGrey:const Color(0xffE6E6E6)
                    ),
                    child: Icon(Icons.play_arrow_rounded,
                    color: context.isDarkMode?Color(0xff959595):Color(0xff555555),),
                  ),
                  SizedBox(width: 5,),
                  Container(
                    width: MediaQuery.of(context).size.width-120,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(songs[index].name,style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16
                        ),),
                        Text(songs[index].artist,style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 12
                        ))
                      ],
                    ),
                  )
                ],
              ),
            ),
            FavoriteButton(songEntity: songs[index  ])
          ],
        ),
      );
    }, 
    separatorBuilder: (context, index) => const SizedBox(height: 20,), 
    itemCount: songs.length);
 }
}
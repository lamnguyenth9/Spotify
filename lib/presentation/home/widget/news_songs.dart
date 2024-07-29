import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify_app/common/helper/is_dark.dart';
import 'package:spotify_app/core/config/constans/app_url.dart';
import 'package:spotify_app/core/config/themes/app_color.dart';
import 'package:spotify_app/presentation/home/bloc/news_songs_cubit.dart';
import 'package:spotify_app/presentation/home/bloc/news_songs_state.dart';
import 'package:spotify_app/presentation/song_player/pages/song_player.dart';

import '../../../domain/entities/song/song.dart';

class NewsSongs extends StatelessWidget {
  const NewsSongs({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_)=>NewsSongsCubit()..getNewsSongs(),
      child: SizedBox(
        height: 185,
        width: 147,
        child: BlocBuilder<NewsSongsCubit,NewsSongsState>(
          builder: (context, state) {
            if(state is NewsSongsLoading){
              return Container(
                alignment: Alignment.center,
                child: const CircularProgressIndicator());
            }
            if(state is NewsSongsLoad){
              return _song(state.songs);
            }
            return const Center();
          },
          )
      ),);
  }
  Widget _song(List<SongEntity> song){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (_)=>SongPlayerPage(songEntity: song[index],)));
                },
                child: SizedBox(
                  width: 140,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16),
                                  image: DecorationImage(
                                   fit: BoxFit.cover,
                                    image: NetworkImage(
                                      AppUrl.firestorage+song[index].title+'.jfif?'+AppUrl.mediaAlt,
                                      
                                      
                                    )
                                  )
                                ),
                                child: Align(
                                  alignment: Alignment.bottomRight,
                                  child: Container(
                                    height: 40,
                                    width: 40,
                                    transform: Matrix4.translationValues(10, 10, 0),
                                    decoration:BoxDecoration(
                                      shape: BoxShape.circle,
                                      color:context.isDarkMode? AppColor.darkGrey :const Color(0xffE6E6E6)
                                    ),
                                    child: Icon(
                                      Icons.play_arrow_rounded,
                                      color:context.isDarkMode? const Color(0xff959595):const Color(0xff555555),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 10,),
                            Text(song[index].name, style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600
                            ),),
                            const SizedBox(height: 10,),
                            Text(song[index].artist, style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w400
                            ),)
                    ],
                  ),
                ),
              );
            }, 
            separatorBuilder: (context, index) => const SizedBox(width: 14,), 
            itemCount: song.length),
    );
  }
}
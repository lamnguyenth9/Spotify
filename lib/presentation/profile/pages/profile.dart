import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify_app/common/bloc/favorite_button/favorite_button_state.dart';
import 'package:spotify_app/common/helper/is_dark.dart';
import 'package:spotify_app/common/widget/app_bar.dart';
import 'package:spotify_app/common/widget/favorite/favorite_button.dart';
import 'package:spotify_app/core/config/themes/app_color.dart';
import 'package:spotify_app/presentation/profile/bloc/favorite_song_cubit.dart';
import 'package:spotify_app/presentation/profile/bloc/favotire_song_state.dart';
import 'package:spotify_app/presentation/profile/bloc/profie_infor_cubit.dart';
import 'package:spotify_app/presentation/profile/bloc/profile_infor_state.dart';
import 'package:spotify_app/presentation/song_player/pages/song_player.dart';

import '../../../core/config/constans/app_url.dart';


class  ProfilePage extends StatelessWidget {
  const  ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BasicAppBar(
        backgroundColor: AppColor.darkGrey,
        title: Text('Profile'),
      ),
      body: Column(
        children: [
          _profileInfor(context),
          SizedBox(height: 30,),
          _favoriteSong()
        ],
      ),
    );
  }
  Widget _profileInfor(BuildContext context){
     return BlocProvider(
      create: (_)=>ProfieInforCubit()..getUser(),
      child: Container(
        height: MediaQuery.of(context).size.height/2.8,
        width: double.infinity,
        decoration: BoxDecoration(
          color: context.isDarkMode?AppColor.darkGrey:Colors.white,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(60),
            bottomRight: Radius.circular(60)
          )
        ),
        child: BlocBuilder<ProfieInforCubit,ProfileInforState>(
        builder: (context, state) {
          if(state is ProfileInforLoading){
            return Center(child: CircularProgressIndicator(),);
          }
          if(state is ProfileInforLoaded){
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: NetworkImage(state.userEntity.imageUrl!))
                    ),
                  ),
                  SizedBox(height: 15,),
                  Text(state.userEntity.email!),
                  SizedBox(height: 10,),
                  Text(state.userEntity.fullName!,style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold
                  ),)
                ],
              );
          }
          if(state is ProfileInforFailure){
            return Text("Please try again");
          }
          return Container();
        },),
      )
      );
  }
Widget _favoriteSong(){
  return BlocProvider(
    create: (_)=>FavoriteSongsCubit()..getFavoriteSongs(),
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("FAVORITE SONGS"),
        BlocBuilder<FavoriteSongsCubit,FavoriteSongsState>(
          builder: (context, state) {
            if(state is FavoriteSongsLoading){
              return Center(child: CircularProgressIndicator(),);
            }
            if(state is FavoriteSongsLoaded){
              return ListView.separated(
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (_)=>SongPlayerPage(songEntity: state.favoriteSongs[index])));
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                    
                        Row(
                          children: [
                            Container(
                              width: 70,
                              height: 70,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                image: DecorationImage(
                                  image: NetworkImage(AppUrl.firestorage+state.favoriteSongs[index].title+'.jfif?'+AppUrl.mediaAlt))
                              ),
                            ),
                            SizedBox(width: 5,),
                            Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(state.favoriteSongs[index].name,style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16
                              ),),
                              SizedBox(width: 5,),
                              Text(state.favoriteSongs[index].artist,style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 12
                              ))
                            ],
                          ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              state.favoriteSongs[index].duration.toString().replaceAll('.', ':')
                            ),
                            SizedBox(width: 20,),
                            FavoriteButton(
                              songEntity: state.favoriteSongs[index],
                              key: UniqueKey(),
                              function: (){
                                context.read<FavoriteSongsCubit>().removeSong(index);
                              },
                              )
                          ],
                        )
                      ],
                    ),
                  );
                }, 
                separatorBuilder: (context, index) => SizedBox(height: 20,), 
                itemCount: state.favoriteSongs.length);
            }
            if(state is FavoriteSongsFailure){
              return Text("Please try again");
            }
            return Container();
          },)
        
      ],
        ),
    ),);
}
    
}
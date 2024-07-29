import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify_app/common/bloc/favorite_button/favorite_button_cubit.dart';
import 'package:spotify_app/common/bloc/favorite_button/favorite_button_state.dart';
import 'package:spotify_app/domain/entities/song/song.dart';

import '../../../core/config/themes/app_color.dart';

class FavoriteButton extends StatelessWidget {
  final Function? function;
  final SongEntity songEntity;
  const FavoriteButton({super.key, required this.songEntity,this.function});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (_)=>FavoriteButtonCubit(),
    child: BlocBuilder<FavoriteButtonCubit,FavoriteButtonState>(
      builder: (context, state) {
        if(state is FavoriteButtonInit){
          return IconButton(
              onPressed: ()async{
             context.read<FavoriteButtonCubit>().favoriteButtonUpdated(songEntity.songId);
                if(function!=null){
                  function!();
                }
              }, 
              icon: Icon(
               songEntity.isFavorite? Icons.favorite : Icons.favorite_outline_outlined, 
                color: AppColor.darkGrey,));
        }
        if(state is FavoriteButtonUpdated){
          return IconButton(
              onPressed: (){
                context.read<FavoriteButtonCubit>().favoriteButtonUpdated(songEntity.songId);
              }, 
              icon: Icon(
               state.isFavorite? Icons.favorite : Icons.favorite_outline_outlined, 
                color: AppColor.darkGrey,));
        }
        return Container();
      },
      ),);
  }
}
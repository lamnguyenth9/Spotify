import 'package:flutter/material.dart';
import 'package:spotify_app/common/helper/is_dark.dart';

class BasicAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget? title;
  final bool hideBack;
  const BasicAppBar({super.key, this.title,this.hideBack=false});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: title,
      backgroundColor: Colors.transparent,
      elevation: 0.30,
      leading: hideBack ? null: IconButton(
        onPressed: (){
          Navigator.pop(context);
        }, 
        icon: Container(
          height: 50,
          width: 50,
          decoration: BoxDecoration(
            color: context.isDarkMode ?Colors.white.withOpacity(0.03):Colors.black.withOpacity(0.04),
            shape: BoxShape.circle
          ),
          child:  Icon(Icons.arrow_back_ios_new,size: 15,
          color: context.isDarkMode ?Colors.white:Colors.black,),
        )),
    );
  }
  
  @override
  
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
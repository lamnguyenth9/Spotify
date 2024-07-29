import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:spotify_app/common/helper/is_dark.dart';
import 'package:spotify_app/common/widget/app_bar.dart';
import 'package:spotify_app/core/config/assets/app_image.dart';
import 'package:spotify_app/core/config/assets/app_vector.dart';
import 'package:spotify_app/core/config/themes/app_color.dart';
import 'package:spotify_app/presentation/home/widget/news_songs.dart';
import 'package:spotify_app/presentation/home/widget/play_list.dart';
import 'package:spotify_app/presentation/profile/pages/profile.dart';

class HomePage extends StatefulWidget {
   HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
 late TabController tabController ;
 @override
  void initState() {
    
    super.initState();
    tabController=TabController(length: 4,vsync: this);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.darkBackground,
      appBar: BasicAppBar(
        action: IconButton(
          onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (_)=>ProfilePage()));
          }, 
          icon: Icon(Icons.person)),
        hideBack: false,
        title: SvgPicture.asset(
          AppVector.logo,
          height: 40,
          width: 40,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _homeArtistCard(),
            
            _tab(),
            SizedBox(
              height: 260,
              child: TabBarView(
                controller: tabController,
                children: [
                const NewsSongs(),
                Container(),
                Container(),
                Container(),
              ]),
            ),
            
            PlayList()
            ],
        ),
      ),
    );
  }

  Widget _homeArtistCard() {
    return Center(
      child: SizedBox(
        height: 140,
        child: Stack(
          children: [
            Align(
              alignment: Alignment.bottomCenter,
              child: SvgPicture.asset(AppVector.homeArtist),
            ),
            Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                  padding: const EdgeInsets.only(right: 40.0),
                  child: Image.asset(AppImage.artistImage),
                ))
          ],
        ),
      ),
    );
  }

  Widget _tab(){
    return TabBar(
      isScrollable: true,
      indicatorColor: AppColor.primary,
      controller: tabController,
      labelColor: context.isDarkMode?Colors.white:Colors.black ,
      padding: const EdgeInsets.symmetric(vertical: 40,horizontal: 16),
      tabs: [
         const Text("News",
         style: TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 16
         ),),
         const Text("Videos",
         style: TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 16
         ),),
         const Text("Artists",
         style: TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 16
         ),),
         const Text("Podcasts",
         style: TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 16
         ),)
    ]);
  }
}

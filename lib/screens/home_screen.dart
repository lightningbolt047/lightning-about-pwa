import 'dart:async';

import 'package:flutter/material.dart';
import 'package:myresume/widgets/home_banners/android_toolbox_banner.dart';
import 'package:myresume/widgets/home_banners/fallback_banner.dart';

import '../widgets/home_banners/bio_banner.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  late final TabController _bannerTabController;
  bool automaticallySwitchBanner=true;
  int maxAppBarBanners=3;

  @override
  void initState() {
    _bannerTabController=TabController(
      length: maxAppBarBanners,
      animationDuration: Duration(seconds: 1),
      vsync: this,
    );
    super.initState();
    Timer.periodic(Duration(seconds: 10), (timer) {
      if(automaticallySwitchBanner){
        _bannerTabController.index=(_bannerTabController.index+1)%_bannerTabController.length;
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            toolbarHeight: MediaQuery.of(context).size.height*0.5,
            flexibleSpace: Stack(
              children: [
                Positioned.fill(
                  child: TabBarView(
                    controller: _bannerTabController,
                    children: [
                      BioBanner(),
                      AndroidToolboxBanner(),
                      FallbackBanner(),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}



import 'dart:async';

import 'package:flutter/material.dart';
import 'package:myresume/widgets/home_banners/android_toolbox_banner.dart';
import 'package:myresume/widgets/home_banners/fallback_banner.dart';
import 'package:myresume/widgets/small_round_material_button.dart';

import '../widgets/home_banners/bio_banner.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late final TabController _bannerTabController;
  late final TabController _pageContentTabController;
  bool _automaticallySwitchBanner=true;
  int _maxAppBarBanners=3;
  late AnimationController _animationController;
  late Animation<double> _bannerControlsAnimation;

  @override
  void initState() {
    _bannerTabController=TabController(
      length: _maxAppBarBanners,
      animationDuration: Duration(seconds: 1),
      vsync: this,
    );
    _pageContentTabController=TabController(
      length: 2,
      vsync: this,
    );

    _animationController=AnimationController(
      duration: Duration(milliseconds: 250),
      vsync: this,
    );

    _bannerControlsAnimation=Tween<double>(
      begin: 0,
      end: 1
    ).animate(CurvedAnimation(parent: _animationController, curve: Curves.easeIn));
    super.initState();
    Timer.periodic(Duration(seconds: 10), (timer) {
      if(_automaticallySwitchBanner){
        _bannerTabController.index=(_bannerTabController.index+1)%_bannerTabController.length;
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Container(
              height: MediaQuery.of(context).size.height*0.5,
              child: Stack(
                children: [
                  Positioned(
                    child: Stack(
                      children: [
                        Positioned(
                          child: Container(
                            height: (MediaQuery.of(context).size.height*0.5)-27,
                            child: TabBarView(
                              controller: _bannerTabController,
                              children: [
                                BioBanner(),
                                AndroidToolboxBanner(),
                                FallbackBanner(),
                              ],
                            ),
                          ),
                        ),
                        Positioned.fill(
                          child: MouseRegion(
                            onEnter: (pointerEvent){
                              _automaticallySwitchBanner=false;
                              Timer(Duration(seconds: 10),() {
                                _automaticallySwitchBanner=true;
                              });
                              _animationController.forward();
                            },
                            onExit: (pointerEvent){
                              _automaticallySwitchBanner=false;
                              Timer(Duration(seconds: 10),() {
                                _automaticallySwitchBanner=true;
                              });
                              _animationController.reverse();
                            },
                            child: FadeTransition(
                              opacity: _bannerControlsAnimation,
                              child: Row(
                                children: [
                                  SmallRoundMaterialButton(
                                    child: Icon(Icons.keyboard_arrow_left,color: Colors.blue,),
                                    onPressed: (){
                                      _bannerTabController.index=(_bannerTabController.index-1)%_maxAppBarBanners;
                                    },
                                  ),
                                  Spacer(),
                                  SmallRoundMaterialButton(
                                    child: Icon(Icons.keyboard_arrow_right,color: Colors.blue,),
                                    onPressed: (){
                                      _bannerTabController.index=(_bannerTabController.index+1)%_maxAppBarBanners;
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: Align(
                      alignment: Alignment.center,
                      child: Material(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25)
                        ),
                        elevation: 20,
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: TabBar(
                            controller: _pageContentTabController,
                            indicator: BoxDecoration(
                                color: Color(0xFF1973BA),
                                borderRadius: BorderRadius.circular(25)
                            ),
                            unselectedLabelColor: Colors.black,
                            isScrollable: true,
                            splashBorderRadius: BorderRadius.circular(25),
                            splashFactory: InkRipple.splashFactory,
                            tabs: [
                              Tab(text: "Blog Posts",),
                              Tab(text: "About",)
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}



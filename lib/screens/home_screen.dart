import 'dart:async';
import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/ic.dart';
import 'package:iconify_flutter/icons/mdi.dart';
import 'package:myresume/const.dart';
import 'package:myresume/screens/about_me_section.dart';
import 'package:myresume/screens/blog_posts.dart';
import 'package:myresume/screens/github_repo_section.dart';
import 'package:myresume/services/ui_services.dart';
import 'package:myresume/services/url_launcher.dart';
import 'package:myresume/widgets/buttons/label_icon_button.dart';
import 'package:myresume/widgets/home_banners/android_toolbox_banner.dart';
import 'package:myresume/widgets/home_banners/fallback_banner.dart';
import 'package:myresume/widgets/buttons/small_round_material_button.dart';
import 'package:web_smooth_scroll/web_smooth_scroll.dart';
import 'package:iconify_flutter/icons/ph.dart';
import '../widgets/home_banners/bio_banner.dart';
import 'package:iconify_flutter/icons/ant_design.dart';
import 'package:package_info_plus/package_info_plus.dart';

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
  final ScrollController _scrollController=ScrollController();
  bool mousePresent=false;
  bool mobileContactsOpen=false;
  Function? pageSetState;

  @override
  void initState() {
    _bannerTabController=TabController(
      length: _maxAppBarBanners,
      animationDuration: Duration(seconds: 1),
      vsync: this,
    );
    _pageContentTabController=TabController(
      length: 3,
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

    _pageContentTabController.addListener(() {
      if(pageSetState!=null){
        pageSetState!((){});
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (pointerEvent){
        setState((){
          mousePresent=true;
        });
      },
      onExit: (pointerEvent){
        setState((){
          mousePresent=false;
        });
      },
      child: Scaffold(
        body: WebSmoothScroll(
          controller: _scrollController,
          child: CustomScrollView(
            controller: _scrollController,
            physics: mousePresent?NeverScrollableScrollPhysics():null,
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
                              child: Material(
                                elevation: 10,
                                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20),bottomRight: Radius.circular(20)),
                                child: Container(
                                  height: (MediaQuery.of(context).size.height*0.5)-27,
                                  child: Stack(
                                    children: [
                                      Positioned(
                                        child: TabBarView(
                                          controller: _bannerTabController,
                                          children: [
                                            BioBanner(),
                                            AndroidToolboxBanner(),
                                            FallbackBanner(),
                                          ],
                                        ),
                                      ),
                                      Positioned(
                                        child: Container(
                                          color: Colors.transparent.withOpacity(0.4),
                                          height: 50,
                                          child: LayoutBuilder(
                                              builder: (context,constraints) {
                                                // if(isMobileDevice(constraints)){
                                                //   return Row(
                                                //     mainAxisAlignment: mobileContactsOpen?MainAxisAlignment.spaceEvenly:MainAxisAlignment.spaceBetween,
                                                //     children: [
                                                //       if(mobileContactsOpen)...[
                                                //
                                                //       ],
                                                //       if(!mobileContactsOpen)
                                                //         LabelIconButton(
                                                //           label: "Download Resume",
                                                //           iconData: Icons.download,
                                                //         ),
                                                //     ],
                                                //   );
                                                // }
                                                return AnimatedSwitcher(
                                                  duration: Duration(milliseconds: 250),
                                                  transitionBuilder: (child,animation){
                                                    return ScaleTransition(
                                                      scale: animation,
                                                      child: FadeTransition(
                                                        opacity: animation,
                                                        child: child,
                                                      ),
                                                    );
                                                  },
                                                  child: Row(
                                                    key: ValueKey<bool>(mobileContactsOpen),
                                                    mainAxisAlignment: isMobileDevice(constraints: constraints)?mobileContactsOpen?MainAxisAlignment.spaceEvenly:MainAxisAlignment.spaceBetween:MainAxisAlignment.end,
                                                    children: [
                                                      // Text("",style: TextStyle(
                                                      //   color: Colors.white,
                                                      //   fontSize: 18,
                                                      // ),),
                                                      if(isMobileDevice(constraints: constraints))
                                                        IconButton(
                                                          icon: Icon(mobileContactsOpen?Icons.arrow_back:Icons.menu,color: Colors.white,),
                                                          onPressed: (){
                                                            setState((){
                                                              mobileContactsOpen=!mobileContactsOpen;
                                                            });
                                                          },
                                                        )
                                                      else...[
                                                        FutureBuilder(
                                                          future: PackageInfo.fromPlatform(),
                                                          builder: (BuildContext context, AsyncSnapshot<PackageInfo> snapshot){
                                                            if(snapshot.connectionState==ConnectionState.waiting){
                                                              return Container();
                                                            }
                                                            return Row(
                                                              children: [
                                                                Image.asset("assets/site_logo.png"),
                                                                Text(snapshot.data!.version,style: TextStyle(
                                                                    color: Colors.white
                                                                ),),
                                                              ],
                                                            );
                                                          },
                                                        ),
                                                        Spacer(),
                                                      ],
                                                      if(!isMobileDevice(constraints: constraints) || (isMobileDevice(constraints: constraints) && mobileContactsOpen))...[
                                                        IconButton(
                                                          icon: Iconify(Ic.baseline_email,color: Colors.white,size: 30,),
                                                          onPressed: (){
                                                            launchURL("mailto:$email");
                                                          },
                                                        ),
                                                        IconButton(
                                                          icon: Iconify(Ph.instagram_logo_bold,color: Colors.white,size: 30,),
                                                          onPressed: (){
                                                            launchURL(instagramProfileURL);
                                                          },
                                                        ),
                                                        IconButton(
                                                          icon: Iconify(Ic.round_discord,color: Colors.white,size: 30,),
                                                          onPressed: (){
                                                            launchURL(discordProfileURL);
                                                          },
                                                        ),
                                                        IconButton(
                                                          icon: Iconify(Mdi.github,color: Colors.white,size: 30,),
                                                          onPressed: (){
                                                            launchURL(githubProfileURL);
                                                          },
                                                        ),
                                                        IconButton(
                                                          icon: Iconify(AntDesign.linkedin_filled,color: Colors.white,size: 30,),
                                                          onPressed: (){
                                                            launchURL(linkedInProfileURL);
                                                          },
                                                        ),
                                                      ],
                                                      if(!isMobileDevice(constraints: constraints) || (isMobileDevice(constraints: constraints) && !mobileContactsOpen))
                                                        LabelIconButton(
                                                          label: "Download Resume",
                                                          iconData: Icons.download,
                                                          onPressed: (){
                                                            launchURL(resumeURL);
                                                          },
                                                        ),
                                                      if(!isMobileDevice(constraints: constraints))
                                                        SizedBox(
                                                          width: 8,
                                                        ),
                                                    ],
                                                  ),
                                                );
                                              }
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Positioned.fill(
                              child: MouseRegion(
                                opaque: false,
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
                                  Tab(text: "About Me",),
                                  Tab(text: "GitHub Repo(s)",),
                                  Tab(text: "Blog Posts",),
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
              Builder(
                builder: (context){
                  return StatefulBuilder(
                    builder: (context,setState){
                      pageSetState=setState;
                      switch(_pageContentTabController.index){
                        case 0: return AboutMeSection();
                        case 1: return GithubRepoSection();
                        case 2: return BlogPosts();
                        default: return Container();
                      }
                    },
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}



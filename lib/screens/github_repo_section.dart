import 'package:card_loading/card_loading.dart';
import 'package:flutter/material.dart';
import 'package:myresume/services/http_services.dart';
import 'package:myresume/widgets/cards/github_repo_card.dart';
import 'package:web_smooth_scroll/web_smooth_scroll.dart';
import '../services/ui_services.dart';

class GithubRepoSection extends StatelessWidget {
  GithubRepoSection({Key? key}) : super(key: key);

  final GitServices _gitServices=GitServices();
  final ScrollController _scrollController=ScrollController();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _gitServices.getGithubProjects(),
      builder: (BuildContext context,AsyncSnapshot<List<dynamic>> snapshot){
        if(!snapshot.hasData){
          return SliverList(
            delegate: SliverChildBuilderDelegate((context,i){
              return LayoutBuilder(
                builder: (context,constraints) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CardLoading(
                      height: 150,
                      width: isMobileDevice(constraints)?constraints.maxWidth:constraints.maxWidth*0.75,
                      borderRadius: BorderRadius.circular(20),
                    ),
                  );
                }
              );
            },childCount: 5),
          );
        }
        return SliverList(
          delegate: SliverChildBuilderDelegate(
            (context,i)=>GithubRepoCard(projectInfo: snapshot.data![i]),
            childCount: snapshot.data!.length
          ),
        );
      },
    );
  }
}



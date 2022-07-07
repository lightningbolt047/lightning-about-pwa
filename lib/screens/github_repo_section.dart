import 'package:card_loading/card_loading.dart';
import 'package:flutter/material.dart';
import 'package:myresume/services/http_services.dart';
import 'package:myresume/widgets/cards/github_repo_card.dart';
import '../services/ui_services.dart';

class GithubRepoSection extends StatelessWidget {
  GithubRepoSection({Key? key}) : super(key: key);

  final GitServices _gitServices=GitServices();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context,constraints) {
        return FutureBuilder(
          future: _gitServices.getGithubProjects(),
          builder: (BuildContext context,AsyncSnapshot<List<dynamic>> snapshot){
            if(!snapshot.hasData){
              return ListView(
                physics: NeverScrollableScrollPhysics(),
                children: [
                  for(int i=0;i<5;i++)
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CardLoading(
                        height: 150,
                        width: isMobileDevice(constraints)?constraints.maxWidth:constraints.maxWidth*0.75,
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                ],
              );
            }
            return ListView(
              physics: NeverScrollableScrollPhysics(),
              children: [
                for(int i=0;i<snapshot.data!.length;i++)
                  GithubRepoCard(projectInfo: snapshot.data![i]),
              ],
            );
          },
        );
      }
    );
  }
}

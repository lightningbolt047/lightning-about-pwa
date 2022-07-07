import 'package:flutter/material.dart';
import 'package:myresume/services/http_services.dart';
import 'package:myresume/widgets/cards/github_repo_card.dart';

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
              return CircularProgressIndicator();
            }
            return Column(
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

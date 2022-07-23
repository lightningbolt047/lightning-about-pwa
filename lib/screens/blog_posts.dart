import 'package:card_loading/card_loading.dart';
import 'package:flutter/material.dart';
import 'package:myresume/services/blog_services.dart';
import 'package:myresume/widgets/cards/blog_post_card.dart';


class BlogPosts extends StatelessWidget {
  const BlogPosts({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: BlogServices.getBlogPostMetadata(),
      builder: (BuildContext context,AsyncSnapshot<List<dynamic>> snapshot) {

        if(!snapshot.hasData){
          return SliverList(
            delegate: SliverChildBuilderDelegate((context,i){
              return LayoutBuilder(
                  builder: (context,constraints) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CardLoading(
                        height: 150,
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
            (context,index){
              return BlogPostCard(createdOn: snapshot.data![index]['createdOn']!, greeting: snapshot.data![index]['greeting']!, heading: snapshot.data![index]['heading']!,user: snapshot.data![index]['user'],);
            },
            childCount: snapshot.data!.length
          ),
        );
      }
    );
  }
}

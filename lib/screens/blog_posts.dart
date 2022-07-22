import 'package:flutter/material.dart';
import 'package:myresume/widgets/cards/blog_post_card.dart';


class BlogPosts extends StatelessWidget {
  const BlogPosts({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverList(
        delegate: SliverChildListDelegate([
          BlogPostCard(),
          BlogPostCard(),
          BlogPostCard(),
        ]));
  }
}

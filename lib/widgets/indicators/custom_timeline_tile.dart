import 'package:flutter/material.dart';
import 'package:timeline_tile/timeline_tile.dart';

class CustomTimelineTile extends StatelessWidget {
  final String assetPath,name;
  final bool inProgress;
  const CustomTimelineTile({Key? key,required this.name,required this.assetPath,this.inProgress=false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context,constraints) {
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            TimelineTile(
              axis: TimelineAxis.horizontal,
              alignment: TimelineAlign.start,
              indicatorStyle: IndicatorStyle(
                drawGap: true,
                width: 50,
                indicator: Stack(
                  children: [
                    CircleAvatar(
                      radius: 20,
                      child: Image.network("https://www.learningcontainer.com/wp-content/uploads/2020/08/Small-Sample-png-Image-File-Download.jpg"),
                    ),
                    CircularProgressIndicator(
                      strokeWidth: 2,
                    )
                  ],
                )
              ),
            ),
          ],
        );
      }
    );
  }
}

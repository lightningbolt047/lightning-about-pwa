import 'package:flutter/material.dart';

import '../content.dart';

class AboutMeSection extends StatelessWidget {
  const AboutMeSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context,constraints){
        if(constraints.maxWidth<600){
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SafeArea(
                  child: CircleAvatar(
                    backgroundImage: AssetImage("assets/me.jpg"),
                    maxRadius: constraints.maxHeight*0.07,
                    minRadius: 10,
                  ),
                ),
                SizedBox(
                  width: constraints.maxHeight*0.05,
                ),
                Flexible(
                  child: LayoutBuilder(
                    builder: (context,constraints){
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Center(
                              child: Text(
                                aboutText,
                                style: TextStyle(
                                  fontSize: 20
                                ),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 25,
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        }
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CircleAvatar(
                backgroundImage: AssetImage("assets/me.jpg"),
                maxRadius: MediaQuery.of(context).size.width*0.05,
                minRadius: 10,
              ),
              SizedBox(
                width: constraints.maxWidth*0.1,
              ),
              Flexible(
                child: LayoutBuilder(
                  builder: (context,constraints){
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Center(
                            child: Text(
                              aboutText,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 20
                              ),
                              maxLines: 25,
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
              SizedBox(
                width: constraints.maxWidth*0.1,
              ),
            ],
          ),
        );
      },
    );
  }
}

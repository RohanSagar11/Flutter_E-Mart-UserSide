import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:velocity_x/velocity_x.dart';

class Home_Page extends StatelessWidget {
  const Home_Page({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color.fromARGB(255, 116, 13, 200),
            Color.fromARGB(255, 218, 235, 234),
          ],
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 200,
            child: Column(
              children: [
                50.heightBox,
                RotatedBox(
                  quarterTurns: 1,
                  child: RichText(
                    text: const TextSpan(
                        text: 'Welcome',
                        style: TextStyle(
                            fontSize: 150, fontWeight: FontWeight.bold)),
                  ),
                ),
                20.widthBox,
              ],
            ),
          ),
          Image.asset(
            'assets/images/png.png',
            height: 1000,
            width: 150,
          )
        ],
      ),
    )

        // backgroundColor: Color.fromRGBO(160, 100, 218, 1),
        );
  }
}

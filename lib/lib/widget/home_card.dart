import 'package:ai_chatbot/helper/global.dart';
import 'package:ai_chatbot/model/home_type.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class HomeCard extends StatelessWidget {
  final HomeType homeType;
  const HomeCard({super.key, required this.homeType});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.blue.withOpacity(.2),
      elevation: 0,
      margin: EdgeInsets.only(bottom: mq.height * .040),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      child: InkWell(
        onTap: homeType.onTap,
        borderRadius: BorderRadius.all(Radius.circular(20)),
        child:
            homeType.leftAlign
                ? Row(
                  children: [
                    SizedBox(
                      width: mq.width * .35,
                      child: Padding(
                        padding: homeType.padding,
                        child: Lottie.asset('assets/${homeType.lottie}'),
                      ),
                    ),
                    Spacer(),
                    Text(
                      homeType.title,
                      style: TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 0.5,
                      ),
                    ),
                    Spacer(flex: 2),
                  ],
                )
                : Row(
                  children: [
                    Spacer(flex: 2),
                    Text(
                      homeType.title,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 0.5,
                      ),
                    ),
                    Spacer(flex: 2),
                    SizedBox(
                      width: mq.width * .35,
                      child: Padding(
                        padding: homeType.padding,
                        child: Lottie.asset('assets/${homeType.lottie}'),
                      ),
                    ),
                    Spacer(),
                  ],
                ),
      ),
    );
  }
}

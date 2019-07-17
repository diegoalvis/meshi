import 'package:flutter/material.dart';
import 'package:meshi/utils/custom_widgets/premium_page.dart';
import 'package:speech_bubble/speech_bubble.dart';
import '../app_icons.dart';

class PremiumSpeechBubble extends StatefulWidget{
  bool isRecommendation = false;

  PremiumSpeechBubble(this.isRecommendation);

  @override
  State<StatefulWidget> createState() => PremiumSpeechBubbleState();
}

class PremiumSpeechBubbleState extends State<PremiumSpeechBubble>{

  bool isPremium = false;

  PremiumSpeechBubbleState();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        widget.isRecommendation ? SizedBox()
        : isPremium ?
        GestureDetector(
          onTap: () {
            setState(() {
              isPremium = false;
            });
            showDialog(
                barrierDismissible: true,
                context: context,
                builder: (BuildContext context) {
                  return PremiumPage();
                });
          },
          child: SpeechBubble(
            child: Text("Usuario premium", style: TextStyle(color: Theme.of(context).accentColor)),
            color: Colors.white,
            nipLocation: NipLocation.RIGHT,
          ),
        ): SizedBox(),
        GestureDetector(
          onTap: () {
            setState(() {
              isPremium = !isPremium;
            });
          },
          child: Container(
            color: Colors.transparent,
            padding: const EdgeInsets.all(4.0),
            child: Icon(AppIcons.crown, color: Theme.of(context).accentColor, size: 16),
          ),
        ),
      ],
    );
  }

}
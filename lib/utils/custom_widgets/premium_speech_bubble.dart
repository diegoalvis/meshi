import 'package:flutter/material.dart';
import 'package:meshi/utils/custom_widgets/premium_page.dart';
import 'package:speech_bubble/speech_bubble.dart';
import '../app_icons.dart';

class PremiumSpeechBubble extends StatefulWidget{
  final bool isPremium;

  const PremiumSpeechBubble(this.isPremium);

  @override
  State<StatefulWidget> createState() => PremiumSpeechBubbleState(this.isPremium);
}

class PremiumSpeechBubbleState extends State<PremiumSpeechBubble>{

  bool isPremium;

  PremiumSpeechBubbleState(this.isPremium);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        isPremium ?
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
            //_bloc.dispatch(InterestsProfileEvents.premium);
            /*isPremium ? showDialog(context: context, builder: (context){
                                                    return premiumSpeechBubble(context);
                                                  }
                                                  ): SizedBox();*/
          },
          child: Icon(AppIcons.crown, color: Theme.of(context).accentColor, size: 15),
        ),
      ],
    );
  }

}
import 'package:flutter/material.dart';
import 'package:meshi/utils/custom_widgets/premium_page.dart';
import 'package:speech_bubble/speech_bubble.dart';
import '../app_icons.dart';

class PremiumSpeechBubble extends StatefulWidget {
  bool isRecommendation = false;

  PremiumSpeechBubble({this.isRecommendation});

  @override
  State<StatefulWidget> createState() => PremiumSpeechBubbleState(this.isRecommendation);
}

class PremiumSpeechBubbleState extends State<PremiumSpeechBubble> {
  bool isRecommendation = true;
  bool isPremium = false;

  PremiumSpeechBubbleState(this.isRecommendation);

  @override
  Widget build(BuildContext context) {
    return widget.isRecommendation
        ? GestureDetector(
            onTap: () {
              showDialog(
                  barrierDismissible: true,
                  context: context,
                  builder: (BuildContext context) {
                    return PremiumPage(false);
                  });
            },
            child: Container(
              color: Colors.transparent,
              padding: const EdgeInsets.all(4.0),
              child: Icon(AppIcons.crown, color: Theme.of(context).accentColor, size: 16),
            ),
          )
        : Row(
            children: <Widget>[
              isPremium
                  ? GestureDetector(
                      onTap: () {
                        setState(() {
                          isPremium = false;
                        });
                        showDialog(
                            barrierDismissible: true,
                            context: context,
                            builder: (BuildContext context) {
                              return PremiumPage(false);
                            });
                      },
                      child: SpeechBubble(
                        child: Text("Usuario premium", style: TextStyle(color: Theme.of(context).accentColor)),
                        color: Colors.white,
                        nipLocation: NipLocation.RIGHT,
                      ),
                    )
                  : SizedBox(),
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

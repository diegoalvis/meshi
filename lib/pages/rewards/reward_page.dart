import 'package:flutter/material.dart';
import 'package:meshi/blocs/form_bloc.dart';
import 'package:meshi/blocs/rewards_bloc.dart';
import 'package:meshi/data/models/reward_model.dart';
import 'package:meshi/data/models/user_model.dart';
import 'package:meshi/pages/forms/form_page.dart';
import 'package:meshi/utils/custom_widgets/option_selector.dart';
import 'package:meshi/utils/localiztions.dart';

// Widget
class RewardPage extends StatefulWidget {
  @override
  RewardPageState createState() => new RewardPageState(RewardBloc());
}

class RewardPageState extends State<RewardPage> {
  final RewardBloc _bloc;
  Reward reward;
  bool showProgress = false;

  RewardPageState(this._bloc);

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    setState(() => showProgress = true);
    _bloc.getRewards();
    _bloc.rewardStream.listen((reward) => setState(() => this.reward = reward),
        onDone: () => setState(() => showProgress = false));
  }

  Future<Null> _fetchRewardData() async {
    _bloc.getRewards();
  }

  @override
  Widget build(BuildContext context) {
    final strings = MyLocalizations.of(context);
    return Container(
      color: Colors.white,
      child: RefreshIndicator(
          onRefresh: _fetchRewardData,
          child: ListView(
            children: [
              Center(
                child: Column(children: [
                    Image.network(
                    reward?.image ??
                        "",
                        height: 280.0,
                        fit: BoxFit.cover),
                  SizedBox(height: 30.0),
                  SizedBox(height: 24.0),
                  Text("Meshi"),
                  // body of above
                ]),
              ),
            ]
          )),
    );
  }
}

//            RefreshIndicator(
//          onRefresh: _refreshStockPrices,
//          child: reward == null
//              ? SizedBox()
//              : Column(children: [
//                  Expanded(child: Text(reward.description)),
//                  SizedBox(height: 20),
//                ]),
//        )

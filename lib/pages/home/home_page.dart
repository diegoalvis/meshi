import 'package:flutter/material.dart';
import 'package:meshi/blocs/home_bloc.dart';
import 'package:meshi/pages/home/menu_page.dart';
import 'package:meshi/pages/rewards/reward_page.dart';
import 'package:meshi/utils/custom_widgets/backdrop_menu.dart';
import 'package:meshi/utils/localiztions.dart';
import 'package:meshi/utils/view_utils/diamond_border.dart';

class HomeBlocProvider extends InheritedWidget {
  final HomeBloc bloc;
  final Widget child;

  HomeBlocProvider({Key key, @required this.bloc, this.child}) : super(key: key, child: child);

  static HomeBlocProvider of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(HomeBlocProvider) as HomeBlocProvider);
  }

  @override
  bool updateShouldNotify(HomeBlocProvider oldWidget) => true;
}

class HomePage extends StatefulWidget {
  @override
  HomePageState createState() => new HomePageState(HomeBloc());
}

class HomePageState extends State<HomePage> {
  final HomeBloc _bloc;
  String _currentCategory;

  HomePageState(this._bloc);

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final strings = MyLocalizations.of(context);
    final _rewardPage = RewardPage();
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        top: false,
        child: HomeBlocProvider(
          bloc: _bloc,
          child: BackdropMenu(
            backLayer: MenuPage(
              currentCategory: _currentCategory ?? strings.homeSections[0],
              onCategoryTap: (category) => setState(() {
                    _currentCategory = category;
                    _bloc.category = category;
                  }),
              categories: strings.homeSections,
            ),
            frontTitle: Text("Cita de la semana"),
            backTitle: Text('MENU'),
            frontLayer: _rewardPage,
            floatingActionButton: _rewardPage.showFloatingButton()
                ? FloatingActionButton(
                    shape: DiamondBorder(),
                    onPressed: null,
                    tooltip: 'Increment',
                    child: Image.asset(
                      'res/icons/logo.png',
                      scale: 5.5,
                      color: Colors.white,
                    ),
                  )
                : null, // This trailing comma makes auto-formatting nicer for build methods.
          ),
        ),
      ),
    );
  }
}

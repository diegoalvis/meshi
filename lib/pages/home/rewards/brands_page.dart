/*
 * Created by Diego Alvis.
 * Copyright (c) 2019 - All rights reserved.
 */

import 'package:dependencies/dependencies.dart';
import 'package:dependencies_flutter/dependencies_flutter.dart';
import 'package:flutter/material.dart';
import 'package:meshi/bloc/rewards_bloc.dart';
import 'package:meshi/data/api/base_api.dart';
import 'package:meshi/data/models/brand.dart';
import 'package:meshi/data/models/reward_model.dart';
import 'package:meshi/data/repository/reward_repository.dart';
import 'package:meshi/managers/session_manager.dart';
import 'package:meshi/utils/localiztions.dart';

class BrandsPage extends StatelessWidget with InjectorWidgetMixin {
  @override
  Widget buildWithInjector(BuildContext context, Injector injector) {
    final bloc = RewardBloc(injector.get<RewardRepository>(), injector.get<SessionManager>());
    return BrandContainer(bloc);
  }
}

class BrandContainer extends StatefulWidget {
  final RewardBloc _bloc;

  const BrandContainer(this._bloc) : super();

  @override
  BrandPageState createState() => new BrandPageState(_bloc);
}

class BrandPageState extends State<BrandContainer> {
  final RewardBloc _bloc;

  List<Brand> brands;
  bool showProgress = false;

  BrandPageState(this._bloc);

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _bloc.brandStream.listen((brands) => setState(() => this.brands = brands));
    _bloc.progressSubject.listen((showProgress) => setState(() => this.showProgress = showProgress));
    _bloc.getBrands();
  }

  Future<Null> _fetchBrands() async {
    setState(() => showProgress = true);
    _bloc.getBrands();
  }

  @override
  Widget build(BuildContext context) {
    final strings = MyLocalizations.of(context);
    return Scaffold(
      body: SafeArea(
        minimum: const EdgeInsets.all(24.0),
        child: showProgress
            ? Center(child: CircularProgressIndicator())
            : Column(
                children: [
                  Expanded(
                    child: RefreshIndicator(
                      onRefresh: _fetchBrands,
                      child: Container(
                        child: brands == null
                            ? Text("ola")
                            : GridView.count(
                                crossAxisCount: 2,
                                children: List.generate(brands.length, (index) =>
                                    DecoratedBox(
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image: NetworkImage(BaseApi.BASE_URL_DEV + "/images/" + brands?.elementAt(index)?.image ?? ""),
                                            fit: BoxFit.cover,
                                          )),
                                    )
                                    /*
                                        Image.network(
                                        BaseApi.BASE_URL_DEV + "/images/" + brands?.elementAt(index)?.image ?? "",
                                        fit: BoxFit.cover)
                                       */
                                    ),
                              ),
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}

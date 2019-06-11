/*
 * Created by Diego Alvis.
 * Copyright (c) 2019 - All rights reserved.
 */

import 'package:dependencies/dependencies.dart';
import 'package:dependencies_flutter/dependencies_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meshi/data/api/base_api.dart';
import 'package:meshi/data/models/brand.dart';
import 'package:meshi/data/repository/reward_repository.dart';
import 'package:meshi/pages/home/rewards/rewards_bloc.dart';
import 'package:meshi/utils/base_state.dart';
import 'package:meshi/utils/localiztions.dart';

class BrandsPage extends StatelessWidget with InjectorWidgetMixin {
  @override
  Widget buildWithInjector(BuildContext context, Injector injector) {
    final strings = MyLocalizations.of(context);
    final bloc = RewardBloc(injector.get<RewardRepository>(), injector.get());
    List<Brand> brands = List();
    Future<Null> _fetchBrands() async {
      bloc.dispatch(RewardEventType.getBrands);
    }

    return Scaffold(
        appBar: AppBar(title: Text(strings.agreements)),
        body: BlocBuilder(
            bloc: bloc,
            builder: (context, state) {
              if (state is SuccessState<List<Brand>>) {
                brands = state.data;
              }
              if (state is InitialState) {
                bloc.dispatch(RewardEventType.getBrands);
              }
              if (state is LoadingState) {
                return Center(child: CircularProgressIndicator());
              }

              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Text(
                      strings.claimYourVoucher,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Expanded(
                    child: RefreshIndicator(
                      onRefresh: _fetchBrands,
                      child: Container(
                        child: brands == null || brands.length == 0
                            ? Center(child: Text(". . ."))
                            : GridView.count(
                                crossAxisCount: 2,
                                crossAxisSpacing: 5,
                                mainAxisSpacing: 5,
                                children: List.generate(
                                    brands.length,
                                    (index) => Image.network(
                                        BaseApi.BASE_URL_DEV +
                                                "/images/" +
                                                brands?.elementAt(index)?.image ??
                                            "",
                                        fit: BoxFit.cover)),
                              ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      buildInfoDialog(context, strings.CommunicateWithUs);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        children: [
                          Container(
                              width: MediaQuery.of(context).size.width * 0.8,
                              child: Text(
                                strings.iDoNotHaveThose,
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 12),
                              )),
                          SizedBox(width: 8.0),
                          Icon(Icons.info_outline),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            }));
  }

  buildInfoDialog(BuildContext context, String title) {
    showDialog(
      context: context,
      builder: (BuildContext context) => SimpleDialog(
            children: <Widget>[
              ListTile(title: Text(title)),
              ListTile(
                  leading: Icon(Icons.phone),
                  title: Text("31234567890"),
                  onTap: () {
                    Navigator.pop(context);
                  }),
              ListTile(
                  leading: Icon(Icons.email),
                  title: Text("info@meshi.com"),
                  onTap: () {
                    Navigator.pop(context);
                  }),
            ],
          ),
    );
  }
}

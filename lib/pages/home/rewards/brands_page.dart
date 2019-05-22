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
      appBar: AppBar(title: Text("Convenios")),
      body: SafeArea(
        child: showProgress
            ? Center(child: CircularProgressIndicator())
            : Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Text(
                      "Reclama tu bono en los siguientes establecimientso",
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Expanded(
                    child: RefreshIndicator(
                      onRefresh: _fetchBrands,
                      child: Container(
                        child: brands == null
                            ? Text("ola")
                            : GridView.count(
                                crossAxisCount: 2,
                                children: List.generate(
                                    brands.length * 2,
                                    (index) => DecoratedBox(
                                          decoration: BoxDecoration(
                                              image: DecorationImage(
                                            image: NetworkImage(
                                                'http://www.ticketfactura.com/wp-content/uploads/2018/07/Facturacion-crepes-y-wafles.jpg' ??
                                                    ""),
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
                  GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) => SimpleDialog(
                              children: <Widget>[
                                ListTile(title: Text("Comunicate con nosotros para saber como reclamar tu premio")),
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
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        children: [
                          Text("No tengo esos establecimientos en mi ciudad", textAlign: TextAlign.center),
                          SizedBox(width: 8.0),
                          Icon(Icons.info_outline),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}

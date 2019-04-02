import 'package:flutter/material.dart';
import 'package:meshi/data/models/user_model.dart';
import 'package:meshi/pages/forms/form_page.dart';
import 'package:meshi/utils/localiztions.dart';

class SpecificsFormPageThree extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final strings = MyLocalizations.of(context);
    final bloc = FormBlocProvider.of(context).bloc;
    return Column(
      children: [
        SizedBox(height: 20),
        Container(
            alignment: Alignment.centerLeft, child: Text("¿Qué estilo prefieres al momento de vestir?")),
        SizedBox(height: 20),
        Expanded(
          child: Container(
            child: StreamBuilder<List<String>>(
              stream: bloc.specificsStream,
              initialData: bloc.user.specifics,
              builder: (BuildContext context, AsyncSnapshot<List<String>> snapshot) {
                return ListView.separated(
                  itemCount: DressStyle.length,
                  separatorBuilder: (BuildContext context, int index) => Divider(),
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      contentPadding: EdgeInsets.symmetric(horizontal: 4.0),
                      onTap: () {
                        String selected = DressStyle[index];
                        var hold = snapshot?.data[5]?.split(",") ?? [];
                        if (hold.contains(selected)) {
                          hold.remove(selected);
                        } else {
                          hold.add(selected);
                        }
                        bloc.specifics(4, hold.join(","));
                      },
                      title: Row(
                        children: <Widget>[
                          Icon(
                              snapshot?.data[5]?.contains(DressStyle[index]) == true
                                  ? Icons.check
                                  : null,
                              color: snapshot?.data[5]?.contains(DressStyle[index]) == true
                                  ? Theme.of(context).accentColor
                                  : Colors.black),
                          SizedBox(width: 5),
                          Text(
                            DressStyle[index],
                            style: TextStyle(
                                color: snapshot?.data[5]?.contains(DressStyle[index]) == true
                                    ? Theme.of(context).accentColor
                                    : Colors.black),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}

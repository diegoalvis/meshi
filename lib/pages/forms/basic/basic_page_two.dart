import 'package:flutter/material.dart';
import 'package:meshi/data/models/user_model.dart';
import 'package:meshi/pages/forms/form_page.dart';
import 'package:meshi/utils/localiztions.dart';

class BasicFormPageTwo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final strings = MyLocalizations.of(context);
    final bloc = FormBlocProvider.of(context).bloc;
    final TextEditingController _controller = TextEditingController();
    _controller.text = bloc.user.height?.toString() ?? "";
    return Column(
      children: [
        SizedBox(height: 20),
        Container(alignment: Alignment.centerLeft, child: Text("¿Cual es tu contextura fisica?")),
        SizedBox(height: 40),
        Container(
          height: 40,
          child: StreamBuilder<User>(
            stream: bloc.userStream,
            initialData: bloc.user,
            builder: (BuildContext context, AsyncSnapshot<User> snapshot) {
              return Row(
                  children: BodyShapeList.map((item) {
                return Expanded(
                  child: FlatButton(
                      onPressed: () => bloc.shape = item,
                      child: Text(item),
                      textColor: snapshot?.data?.bodyShape == item
                          ? Theme.of(context).accentColor
                          : Colors.grey[400]),
                );
              }).toList());
            },
          ),
        ),
        SizedBox(height: 50),
        Container(alignment: Alignment.centerLeft, child: Text("¿Cual es tu altura?")),
        SizedBox(height: 20),
        StreamBuilder<User>(
          stream: bloc.userStream,
          initialData: bloc.user,
          builder: (BuildContext context, AsyncSnapshot<User> snapshot) {
            return TextField(
              controller: _controller,
              onChanged: (text) => bloc.height = int.tryParse(text) ?? snapshot.data.height,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: "Centimetros"),
            );
          },
        ),
      ],
    );
  }
}

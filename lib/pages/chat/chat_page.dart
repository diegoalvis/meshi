import 'package:dependencies_flutter/dependencies_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:meshi/data/models/match.dart';
import 'package:meshi/data/models/message.dart';
import 'package:meshi/utils/widget_util.dart';

import 'chat_bloc.dart';
import 'chat_events.dart';

class ChatPage extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    final Matches match = ModalRoute.of(context).settings.arguments;
    final inject = InjectorWidget.of(context);
    return InjectorWidget.bind(
        bindFunc: (binder) {
          binder.bindLazySingleton((injector, params)=> ChatBloc(
              match.idMatch, inject.get(), inject.get(), inject.get()));
        },
        child: Scaffold(
          appBar: AppBar(
            title: Text(match.name),
          ),
          body: ChatBody(match),
        ));
  }
}

class ChatBody extends StatefulWidget {
  final Matches _matches;

  ChatBody(this._matches) : super(key: ValueKey("chat-body"));

  @override
  State<StatefulWidget> createState() => ChatBodyState(_matches);
}

class ChatBodyState extends State<ChatBody> {
  final TextEditingController _chatController = new TextEditingController();
  final DateFormat _dateFormat = DateFormat("d/M/y").add_jm();
  final DateFormat _timeFormat = DateFormat("jm");

  final Matches _matches;

  int _me;

  ChatBodyState(this._matches);

  ChatBloc _bloc;

  @override
  void initState() {
    onWidgetDidBuild(() {
      _bloc.connectSocket();
      _bloc.dispatch(LoadedChatEvent());
    });
    super.initState();
  }

  void _handleSubmit() {
    Message message = Message(
        content: _chatController.text,
        fromUser: _me,
        toUser: _matches.id,
        date: DateTime.now());

    _chatController.clear();
    _bloc.dispatch(SendMessageEvent(message));
  }

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if(_bloc == null){
      _bloc = InjectorWidget.of(context).get();
    }
    return Column(
      children: <Widget>[
        Flexible(
          child: BlocBuilder(
            bloc: _bloc,
            builder: (ctx, MessageState state) {
              _me = state.me;
              return ListView.builder(
                padding: new EdgeInsets.all(8.0),
                reverse: true,
                itemBuilder: (_, int index) => ChatMessage(
                    state.me, state.messages[index], _timeFormat, _dateFormat),
                itemCount: state.messages.length,
              );
            },
          ),
        ),
        _chatInput()
      ],
    );
  }

  Widget _chatInput() => Material(
        child: Container(
          height: 55,
          decoration: BoxDecoration(color: Color.fromARGB(255, 221, 221, 221)),
          child: Row(
            children: <Widget>[
              InkWell(
                onTap: () {
                  print("");
                },
                child: Container(
                  width: 55,
                  height: 55,
                  child: Icon(Icons.tag_faces),
                ),
              ),
              Expanded(
                child: TextFormField(
                  controller: _chatController,
                  textInputAction: TextInputAction.send,
                  onFieldSubmitted: (v) => _handleSubmit(),
                  decoration: InputDecoration(
                    hintText: "Escribe un mensaje ...",
                    focusedBorder: InputBorder.none,
                    border: InputBorder.none,
                  ),
                ),
              ),
              InkWell(
                onTap: () {},
                child: Container(
                  width: 55,
                  height: 55,
                  child: Icon(Icons.image),
                ),
              ),
              InkWell(
                onTap: () {
                  _handleSubmit();
                },
                child: Container(
                  color: Theme.of(context).primaryColor,
                  child: Container(
                    width: 55,
                    height: 55,
                    child: Icon(
                      Icons.send,
                      color: Colors.white,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      );
}

class ChatMessage extends StatelessWidget {
  final Message _message;
  final int _me;
  static final DateTime _today = DateTime.now();
  final String _todayStr = "${_today.year}-${_today.month}-${_today.day}";

  final DateFormat _timeFormat;
  final DateFormat _dateFormat;

  ChatMessage(this._me, this._message, this._timeFormat, this._dateFormat);

  String _prepareDate(DateTime date) {
    final String _nowStr = "${date.year}-${date.month}-${date.day}";
    return _nowStr == _todayStr
        ? _timeFormat.format(date)
        : _dateFormat.format(date);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
          top: 10,
          bottom: 10,
          left: _message.fromUser == _me ? 40 : 10,
          right: _message.fromUser == _me ? 10 : 40),
      child: Column(
        crossAxisAlignment: _message.fromUser == _me
            ? CrossAxisAlignment.end
            : CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            _prepareDate(_message.date),
            style: Theme.of(context)
                .textTheme
                .caption
                .copyWith(color: Color.fromARGB(255, 205, 205, 205)),
          ),
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: _message.fromUser == _me
                  ? Color.fromARGB(255, 240, 240, 240)
                  : Color.fromARGB(255, 225, 225, 225),
              borderRadius: _message.fromUser == _me
                  ? BorderRadius.only(
                      topLeft: Radius.circular(8),
                      bottomLeft: Radius.circular(8),
                      bottomRight: Radius.circular(8))
                  : BorderRadius.only(
                      topRight: Radius.circular(8),
                      bottomLeft: Radius.circular(8),
                      bottomRight: Radius.circular(8)),
              boxShadow: [
                BoxShadow(
                    color: Color.fromARGB(255, 180, 180, 180),
                    blurRadius: 1,
                    offset: Offset(1, 1)),
              ],
            ),
            child: Text(
              _message.content,
              style: Theme.of(context).textTheme.body1,
            ),
          )
        ],
      ),
    );
  }
}

import 'package:dependencies_flutter/dependencies_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:meshi/data/models/message.dart';
import 'package:meshi/data/models/user_match.dart';
import 'package:meshi/utils/base_state.dart';
import 'package:meshi/utils/widget_util.dart';

import 'chat_bloc.dart';
import 'chat_events.dart';

class ChatPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final UserMatch match = ModalRoute.of(context).settings.arguments;
    final inject = InjectorWidget.of(context);
    return InjectorWidget.bind(
      bindFunc: (binder) {
        binder.bindLazySingleton((injector, params) =>
            ChatBloc(match, inject.get(), inject.get(), inject.get(), inject.get()));
      },
      child: ChatBody(match),
    );
  }
}

class ChatBody extends StatefulWidget {
  final UserMatch _matches;

  ChatBody(this._matches) : super(key: ValueKey("chat-body"));

  @override
  State<StatefulWidget> createState() => ChatBodyState(_matches);
}

class ChatBodyState extends State<ChatBody> {
  final TextEditingController _chatController = new TextEditingController();
  final DateFormat _dateFormat = DateFormat("d/M/y").add_jm();
  final DateFormat _timeFormat = DateFormat("jm");

  final UserMatch _matches;

  List<Message> _data = [];
  int _me;

  ChatBodyState(this._matches);

  ChatBloc _bloc;

  ScrollController _controller = ScrollController();

  @override
  void initState() {
    onWidgetDidBuild(() {
      _bloc.connectSocket();
      _bloc.dispatch(LoadedChatEvent());
    });
    super.initState();
    _controller.addListener((){
      if(_controller.position.pixels == _controller.position.maxScrollExtent && _data.length >= 60){
        _bloc.dispatch(LoadPageEvent(_data.last.date.millisecondsSinceEpoch));
      }
    });
  }



  void _handleSubmit() {
    Message message = Message(
        content: _chatController.text,
        fromUser: _me,
        toUser: _matches.id,
        date: DateTime.now().toUtc(),
        matchId: _matches.idMatch);

    _chatController.clear();
    _bloc.dispatch(SendMessageEvent(message));
  }

  @override
  void dispose() {
    _bloc.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_bloc == null) {
      _bloc = InjectorWidget.of(context).get();
    }
    return Scaffold(
        appBar: AppBar(
          title: Text(_matches.name),
          actions: <Widget>[
            PopupMenuButton<int>(
                onSelected: (value) {
                  if (value == 1) {
                    _bloc.dispatch(ClearChatEvent(_matches.idMatch));
                  } else {
                    _bloc.dispatch(BlockMatchEvent(_matches.idMatch));
                  }
                },
                itemBuilder: (context) => [
                      PopupMenuItem(
                        value: 1,
                        child: Text('Vaciar chat'),
                      ),
                      PopupMenuItem(
                        value: 2,
                        child: Text('Eliminar match'),
                      )
                    ]),
          ],
        ),
        body: Column(
          children: <Widget>[
            Flexible(
              child: BlocBuilder(
                bloc: _bloc,
                builder: (ctx, BaseState state) {
                  if (state is InitialState) {
                    _bloc.dispatch(LoadedChatEvent());
                  }
                  if (state is ExitState) {
                    Navigator.pop(this.context);
                  }
                  if (state is LoadingState) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  if (state is MessageState) {
                    if(state.newPage){
                      _data.addAll(state.messages);
                    }else if(state.newMessage){
                      _data.insert(0, state.messages[0]);
                    }else{
                      _me = state.me;
                      _data = state.messages;
                    }

                    return ListView.builder(
                      controller: _controller,
                      padding: new EdgeInsets.all(8.0),
                      reverse: true,
                      itemBuilder: (_, int index) =>
                          ChatMessage(_me, _data[index], _timeFormat, _dateFormat),
                      itemCount: _data.length,
                    );
                  }
                  return Center(child: SizedBox());
                },
              ),
            ),
            if (_matches.state == MATCH_BLOCKED)
              Text(
                  "${_matches.name} te ha retirado de sus contactos, no puedes chatear con esta persona"),
            _chatInput()
          ],
        ));
  }

  Widget _chatInput() => Material(
        child: Container(
          height: 65,
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
                  enabled: _matches.state != MATCH_BLOCKED,
                  textCapitalization: TextCapitalization.sentences,
                  textInputAction: TextInputAction.send,
                  onFieldSubmitted: (v) => _handleSubmit(),
                  decoration: InputDecoration(
                    hintText: "Escribe un mensaje ...",
                    focusedBorder: InputBorder.none,
                    border: InputBorder.none,
                  ),
                ),
              ),
//              InkWell(
//                onTap: () {},
//                child: Container(
//                  width: 55,
//                  height: 55,
//                  child: Icon(Icons.image),
//                ),
//              ),
              InkWell(
                onTap: () {
                  if (_matches.state != MATCH_BLOCKED) _handleSubmit();
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
  static final DateTime _today = DateTime.now().toLocal();
  final String _todayStr = "${_today.year}-${_today.month}-${_today.day}";

  final DateFormat _timeFormat;
  final DateFormat _dateFormat;

  ChatMessage(this._me, this._message, this._timeFormat, this._dateFormat);

  String _prepareDate(DateTime date) {
    final local = date.toLocal();
    final String _nowStr = "${local.year}-${local.month}-${local.day}";
    return _nowStr == _todayStr ? _timeFormat.format(local) : _dateFormat.format(local);
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
        crossAxisAlignment: _message.fromUser == _me ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            _prepareDate(_message.date),
            style:
                Theme.of(context).textTheme.caption.copyWith(color: Color.fromARGB(255, 205, 205, 205)),
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
                    color: Color.fromARGB(255, 180, 180, 180), blurRadius: 1, offset: Offset(1, 1)),
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

import 'package:adhara_socket_io/adhara_socket_io.dart';
import 'package:meshi/data/models/message.dart';
import 'package:rxdart/rxdart.dart';

import 'dart:io' show Platform;

class UserSocket {

  static const SOCKET_BASE_URL= "https://meshi-app.herokuapp.com";
  static const SOCKET_NAMESPACE = "/socket-user";

  SocketIOManager _manager;
  SocketIO _socket;
  PublishSubject<Message> _messageSubject;

  UserSocket() {
    _manager = SocketIOManager();
    _messageSubject = PublishSubject();
  }

  Future<Observable<Message>> connect(int id) async {

    String url = SOCKET_BASE_URL;
    String namespace = SOCKET_NAMESPACE;

    if(Platform.isAndroid){
      url += namespace;
      namespace = '';
    }else{
      url += '/';
    }

    final options = SocketOptions(url, enableLogging: true, nameSpace: namespace);
    _socket = await _manager.createInstance(options);

    _socket.onConnect((d){
      _socket.emit('subscribe', ['$id']);
    });

    _socket.on("messages", (data) {
      _processMessage(data);
    });

    _socket.connect();

    return _messageSubject.doOnCancel(() {
      _socket.emit('unsubscribe', ['$id']);
      _manager.clearInstance(_socket);
      _socket = null;
    });
  }

  void _processMessage(Map<dynamic, dynamic> data) async{
    final json = Map<String, dynamic>.from(data);
    final msg = Message.fromJson(json);
    _messageSubject.add(msg);
  }

}

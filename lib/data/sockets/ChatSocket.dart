import 'package:adhara_socket_io/adhara_socket_io.dart';
import 'package:meshi/data/models/message.dart';
import 'package:rxdart/rxdart.dart';

import 'dart:io' show Platform;

class ChatSocket {

  static const SOCKET_BASE_URL= "https://meshi-app.herokuapp.com";
  static const SOCKET_NAMESPACE = "/socket-chat";

  SocketIOManager _manager;
  PublishSubject<Message> _messageSubject;

  ChatSocket() {
    _manager = SocketIOManager();
    _messageSubject = PublishSubject();
  }

  Future<Observable<Message>> connect(int matchId) async {

    String url = SOCKET_BASE_URL;
    String namespace = SOCKET_NAMESPACE;

    if(Platform.isAndroid){
      url += namespace;
      namespace = '';
    }else{
      url += '/';
    }

    final options = SocketOptions(url, enableLogging: true, namesapce: namespace);
    SocketIO _socket = await _manager.createInstance(options);

    _socket.onConnect((d){
      _socket.emit('subscribe', [matchId]);
    });

    _socket.on('messages', (data) {
      final msg = Message.fromJson(data);
      _messageSubject.add(msg);
    });

    _socket.connect();

    return _messageSubject.doOnCancel(() {
      _socket.emit('unsubscribe', [matchId]);
      _manager.clearInstance(_socket);
    });
  }

}

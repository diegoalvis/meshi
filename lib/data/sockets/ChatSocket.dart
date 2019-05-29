import 'package:adhara_socket_io/manager.dart';
import 'package:adhara_socket_io/socket.dart';
import 'package:meshi/data/models/message.dart';
import 'package:rxdart/rxdart.dart';

class ChatSocket {

  static const BASE_URL_SOCKET = "https://meshi-app.herokuapp.com/socket/chat";


  SocketIOManager _manager;
  PublishSubject<Message> _messageSubject;

  ChatSocket() {
    _manager = SocketIOManager();
    _messageSubject = PublishSubject();
  }

  Future<Observable<Message>> connect(int matchId) async {
    SocketIO _socket = await _manager.createInstance(BASE_URL_SOCKET, enableLogging: true);
    _socket.connect();

    _socket.onConnect((d){
      _socket.emit('subscribe', [{'match': matchId}]);
    });

    _socket.on('messages', (data) {
      final msg = Message.fromJson(data);
      _messageSubject.add(msg);
    });

    return _messageSubject.doOnCancel(() {
      _socket.emit('unsubscribe', [{'match': matchId}]);
      _manager.clearInstance(_socket);
    });
  }

}

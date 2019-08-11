import 'package:adhara_socket_io/adhara_socket_io.dart';
import 'package:meshi/data/models/message.dart';
import 'package:rxdart/rxdart.dart';

class ChatSocket {
  static const BASE_URL_SOCKET = "https://meshi-app.herokuapp.com/socket/chat";

  SocketIOManager _manager;
  SocketIO _socket;
  PublishSubject<Message> _messageSubject;

  ChatSocket() {
    _manager = SocketIOManager();
    _messageSubject = PublishSubject();
  }

  void clear(int matchId) {
    _socket.emit('unsubscribe', [
      {'match': matchId}
    ]);
    _manager.clearInstance(_socket);
  }

  Future<Observable<Message>> connect(int matchId) async {
    _socket = await _manager.createInstance(SocketOptions(BASE_URL_SOCKET, enableLogging: true));

    _socket.onConnect((d){
      _socket.emit('subscribe', [{'match': matchId}]);
    });

    _socket.on('messages', (data) {
      final msg = Message.fromJson(data);
      _messageSubject.add(msg);
    });

    _socket.connect();

    return _messageSubject.doOnCancel(() {
      _socket.emit('unsubscribe', [{'match': matchId}]);
      _manager.clearInstance(_socket);
    });
  }

}

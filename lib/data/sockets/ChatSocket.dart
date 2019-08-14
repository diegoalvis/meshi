import 'package:adhara_socket_io/adhara_socket_io.dart';
import 'package:meshi/data/models/message.dart';
import 'package:rxdart/rxdart.dart';

class ChatSocket {

  static const SOCKET_BASE_URL= "https://meshi-app.herokuapp.com/socket/chat";

  SocketIOManager _manager;
  PublishSubject<Message> _messageSubject;

  ChatSocket() {
    _manager = SocketIOManager();
    _messageSubject = PublishSubject();
  }

  Future<Observable<Message>> connect(int matchId) async {
    final options = SocketOptions(SOCKET_BASE_URL, enableLogging: true, namesapce: '');
    SocketIO _socket = await _manager.createInstance(options);

    _socket.onConnect((d){
      _socket.emit('subscribe', [{'match': matchId}]);
    });

    _socket.onConnectError((d){
      print(d);
    });

    _socket.onError((d){
      print(d);
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

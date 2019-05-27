import 'package:adhara_socket_io/manager.dart';
import 'package:adhara_socket_io/socket.dart';
import 'package:meshi/data/models/message.dart';
import 'package:rxdart/rxdart.dart';

class ChatSocket {

  String _url;
  SocketIOManager _manager;
  PublishSubject<Message> _messageSubject;


  ChatSocket(this._url) {
    _manager = SocketIOManager();
    _messageSubject = PublishSubject();
  }

  Future<PublishSubject<Message>> count(int matchId) async {
    SocketIO _socket = await _manager.createInstance(_url);
    _socket.emit('subscribe', [{'match': matchId}]);

    _socket.on('reserves', (data) {
      final obj = data[0] as Map<String, dynamic>;
      _messageSubject.add(Message.fromJson(obj));
    });

    return _messageSubject.doOnCancel(() {
      _socket.emit('unsubscribe', [{'match': matchId}]);
      _manager.clearInstance(_socket);
    });
  }

}

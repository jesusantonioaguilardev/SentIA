import 'package:web_socket_channel/web_socket_channel.dart';

import '../../core/config/app_config.dart';

class SocketClient {
  SocketClient() : _channel = WebSocketChannel.connect(Uri.parse(AppConfig.websocketUrl));

  final WebSocketChannel _channel;

  WebSocketChannel get channel => _channel;
}

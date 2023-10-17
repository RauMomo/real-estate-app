import 'package:flutter/material.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

extension StreamChatContext on BuildContext {
  User? get currentUser => StreamChatCore.of(this).currentUser;
}

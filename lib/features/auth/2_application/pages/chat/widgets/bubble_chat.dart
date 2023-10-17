import 'package:flutter/material.dart';
import 'package:real_estate_app/features/auth/2_application/pages/chat/widgets/bubble_chat_types/regular_bubble.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

enum BubbleChatType { regular }

class BubbleChat extends StatelessWidget {
  final MessageDetails details;

  const BubbleChat({super.key, required this.details});
  @override
  Widget build(BuildContext context) {
    return _buildWidgetsFromType();
  }

  _buildWidgetsFromType() {
    var type = BubbleChatType.values.byName(details.message.type);
    switch (type) {
      case BubbleChatType.regular:
        return RegularBubble(
          message: details.message,
          isMyMessage: details.isMyMessage,
        );
    }
  }
}

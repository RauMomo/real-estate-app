// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:equatable/equatable.dart';

class ChatroomModel extends Equatable {
  final String title;
  final String lastMessage;
  final DateTime time;
  final bool isOnline;
  final int unreadChats;
  final DateTime createdAt;
  final String avatar;
  final List<MessageContent> message;

  const ChatroomModel(
      {required this.title,
      required this.lastMessage,
      required this.time,
      required this.isOnline,
      required this.unreadChats,
      required this.createdAt,
      required this.avatar,
      required this.message});

  @override
  List<Object?> get props => [
        title,
        lastMessage,
        time,
        isOnline,
        unreadChats,
        createdAt,
        avatar,
        message
      ];

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'title': title,
      'lastMessage': lastMessage,
      'time': time.millisecondsSinceEpoch,
      'isOnline': isOnline,
      'unreadChats': unreadChats,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'avatar': avatar,
      'message': message.map((x) => x.toJson()).toList(),
    };
  }

  factory ChatroomModel.fromMap(Map<String, dynamic> map) {
    return ChatroomModel(
      title: map['title'] as String,
      lastMessage: map['lastMessage'] as String,
      time: DateTime.fromMillisecondsSinceEpoch(map['time'] as int),
      isOnline: map['isOnline'] as bool,
      unreadChats: map['unreadChats'] as int,
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt'] as int),
      avatar: map['avatar'] as String,
      message: List<MessageContent>.from(
        (map['message'] as List<int>).map<MessageContent>(
          (x) => MessageContent.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }
}

class MessageContent extends Equatable {
  final bool isMe;
  final String msg;
  final DateTime sendAt;
  final bool isEdited;
  final bool isRead;

  const MessageContent(
      {required this.isMe,
      required this.msg,
      required this.sendAt,
      required this.isEdited,
      required this.isRead});

  @override
  List<Object?> get props => [isMe, msg, sendAt, isEdited, isRead];

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'isMe': isMe,
      'msg': msg,
      'sendAt': sendAt.millisecondsSinceEpoch,
      'isEdited': isEdited,
      'isRead': isRead,
    };
  }

  factory MessageContent.fromMap(Map<String, dynamic> map) {
    return MessageContent(
      isMe: map['isMe'] as bool,
      msg: map['msg'] as String,
      sendAt: DateTime.fromMillisecondsSinceEpoch(map['sendAt'] as int),
      isEdited: map['isEdited'] as bool,
      isRead: map['isRead'] as bool,
    );
  }
}

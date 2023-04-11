// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:equatable/equatable.dart';

class ChatListModel extends Equatable {
  final String title;
  final String lastMessage;
  final DateTime time;
  final bool isOnline;
  final int unreadChats;
  final String avatar;

  const ChatListModel(
      {required this.title,
      required this.lastMessage,
      required this.time,
      required this.isOnline,
      required this.unreadChats,
      required this.avatar});

  @override
  List<Object?> get props => [];

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'title': title,
      'lastMessage': lastMessage,
      'time': time.millisecondsSinceEpoch,
      'isOnline': isOnline,
      'unreadChats': unreadChats,
      'avatar': avatar,
    };
  }

  factory ChatListModel.fromMap(Map<String, dynamic> map) {
    return ChatListModel(
      title: map['title'] as String,
      lastMessage: map['lastMessage'] as String,
      time: DateTime.fromMillisecondsSinceEpoch(map['time'] as int),
      isOnline: map['isOnline'] as bool,
      unreadChats: map['unreadChats'] as int,
      avatar: map['avatar'] as String,
    );
  }
}

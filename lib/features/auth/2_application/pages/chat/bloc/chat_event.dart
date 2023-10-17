part of 'chat_bloc.dart';

abstract class ChatEvent extends Equatable {
}

class ChatListEvent extends ChatEvent {
  ChatListEvent();
  
  @override
  List<Object?> get props => [];
}

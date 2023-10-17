import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> with ChangeNotifier {
  ChatBloc() : super(ChatInitial()) {
    on<ChatEvent>((event, emit) {});
  }

  Channel? chatroomItem;
  StreamChannelListController? streamChannelListController;

  setChatroomItem(Channel selectedChatroom) {
    chatroomItem = selectedChatroom;
    notifyListeners();
  }
}

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:real_estate_app/features/auth/2_application/pages/chat/models/chat_list_model.dart';
import 'package:real_estate_app/shared/constants/colors.dart';
import 'package:real_estate_app/shared/constants/ui_size_constants.dart';
import 'package:real_estate_app/shared/widgets/one_liner_text_field.dart';

class ChatListPage extends StatefulWidget {
  const ChatListPage({Key? key}) : super(key: key);

  static const String path = '/chat-list';

  @override
  State<ChatListPage> createState() => _ChatListPageState();
}

class _ChatListPageState extends State<ChatListPage> {
  final List<ChatListModel> chatLists = [
    ChatListModel(
        title: 'Bill',
        lastMessage: 'Thank you for sharing',
        time: DateTime(2022, 10, 10, 12, 5),
        isOnline: true,
        unreadChats: 0,
        avatar: 'assets/avatars/Avatar-1.png'),
    ChatListModel(
        title: 'Bill',
        lastMessage: 'Thank you for sharing',
        time: DateTime(2022, 10, 10, 12, 38),
        isOnline: true,
        unreadChats: 0,
        avatar: 'assets/avatars/Avatar-2.png'),
    ChatListModel(
        title: 'Bill',
        lastMessage: 'Thank you for sharing',
        time: DateTime(2022, 10, 10, 13, 17),
        isOnline: true,
        unreadChats: 1,
        avatar: 'assets/avatars/Avatar-3.png'),
    ChatListModel(
        title: 'Bill',
        lastMessage: 'Thank you for sharing',
        time: DateTime(2022, 10, 10, 13, 34),
        isOnline: true,
        unreadChats: 1,
        avatar: 'assets/avatars/Avatar-4.png'),
    ChatListModel(
        title: 'Bill',
        lastMessage: 'Thank you for sharing',
        time: DateTime(2022, 10, 10, 13, 49),
        isOnline: true,
        unreadChats: 1,
        avatar: 'assets/avatars/Avatar-5.png'),
    ChatListModel(
        title: 'Bill',
        lastMessage: 'Thank you for sharing',
        time: DateTime(2022, 10, 10, 14, 28),
        isOnline: true,
        unreadChats: 1,
        avatar: 'assets/avatars/Avatar-6.png'),
    ChatListModel(
        title: 'Bill',
        lastMessage: 'Thank you for sharing',
        time: DateTime(2022, 10, 10, 14, 33),
        isOnline: true,
        unreadChats: 1,
        avatar: 'assets/avatars/Avatar.png')
  ];

  @override
  void initState() {
    chatLists.sort(
      (a, b) {
        return b.time.compareTo(a.time);
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  _buildAppBar() {
    final appBarTheme = Theme.of(context).appBarTheme;
    return AppBar(
      toolbarHeight: appBarTheme.toolbarHeight! - 16,
      flexibleSpace: Transform.translate(
        offset: const Offset(0, 32),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              hSpaceRegular,
              Expanded(
                child: OneLinerTextField(
                  affinity: ControlAffinity.leading,
                  needValidation: false,
                  hintText: 'Search in Messages',
                  onChanged: (p0) {},
                ),
              )
            ],
          ),
        ),
      ),
      primary: false,
      titleTextStyle: appBarTheme.titleTextStyle,
      backgroundColor: ColorConstants.kWhite,
      elevation: appBarTheme.elevation,
    );
  }

  _buildBody() {
    final textTheme = Theme.of(context).textTheme;
    return SafeArea(
      child: ListView.builder(
        itemCount: chatLists.length,
        itemBuilder: (context, index) {
          final chatItem = chatLists[index];
          var timeFormat = DateFormat('HH:mm').format(chatItem.time);
          return ListTile(
            contentPadding: const EdgeInsets.all(16),
            leading: Container(
              width: 80,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                    alignment: Alignment.center,
                    image: AssetImage(chatItem.avatar),
                    fit: BoxFit.contain),
              ),
            ),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  chatItem.title,
                  style: textTheme.headlineMedium,
                ),
                Text(chatItem.lastMessage),
                vSpaceSmall
              ],
            ),
            trailing: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(timeFormat),
                vSpaceTiny,
                chatItem.unreadChats == 0
                    ? const SizedBox.shrink()
                    : Badge(
                        label: Text(
                          chatItem.unreadChats.toString(),
                        ),
                      ),
              ],
            ),
          );
        },
      ),
    );
  }
}

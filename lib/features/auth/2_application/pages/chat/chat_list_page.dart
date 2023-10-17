import 'package:flutter/material.dart';
import 'package:real_estate_app/features/auth/2_application/pages/chat/models/chat_list_model.dart';
import 'package:real_estate_app/shared/constants/colors.dart';
import 'package:real_estate_app/shared/constants/ui_size_constants.dart';
import 'package:real_estate_app/shared/widgets/one_liner_text_field.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

class ChatListPage extends StatefulWidget {
  const ChatListPage({Key? key}) : super(key: key);

  static const String path = '/chat-list';

  @override
  State<ChatListPage> createState() => _ChatListPageState();
}

class _ChatListPageState extends State<ChatListPage> {
  late final StreamChannelListController streamChannelListController;

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

    final chatCore = StreamChatCore.of(context);
    streamChannelListController = StreamChannelListController(
      client: chatCore.client,
      filter: Filter.in_('members', [chatCore.currentUser!.id]),
    );
    streamChannelListController.doInitialLoad();
    super.initState();
  }

  @override
  void dispose() {
    streamChannelListController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: _buildAppBar(), body: _buildBody());
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

    return PagedValueListenableBuilder<int, Channel>(
        valueListenable: streamChannelListController,
        builder: (context, value, child) {
          return value.when(
            (channels, nextPageKey, error) {
              if (channels.isEmpty) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Align(
                      child: FractionallySizedBox(
                        widthFactor: 0.4,
                        child: Image.asset(
                            'assets/images/illustration_empty_state.png'),
                      ),
                    ),
                    Text(
                      'Nothing Here...',
                      style: textTheme.headlineMedium,
                    ),
                    vSpaceSmall,
                    Text(
                      'Start booking your places to contact with property owner',
                      style: textTheme.labelMedium,
                    ),
                    vSpaceMedium,
                    _buildButton()
                  ],
                );
              }
              return LazyLoadScrollView(
                onEndOfPage: () async {
                  if (nextPageKey != null) {
                    streamChannelListController.loadMore(nextPageKey);
                  }
                },
                child: ListView.builder(
                  /// We're using the channels length when there are no more
                  /// pages to load and there are no errors with pagination.
                  /// In case we need to show a loading indicator or and error
                  /// tile we're increasing the count by 1.
                  itemCount: (nextPageKey != null || error != null)
                      ? channels.length + 1
                      : channels.length,
                  itemBuilder: (BuildContext context, int index) {
                    if (index == channels.length) {
                      if (error != null) {
                        return TextButton(
                          onPressed: () {
                            streamChannelListController.retry();
                          },
                          child: Text(error.message),
                        );
                      }
                      return const CircularProgressIndicator();
                    }

                    final item = channels[index];
                    return ListTile(
                      title: Text(item.name ?? ''),
                      subtitle: StreamBuilder<Message?>(
                        stream: item.state!.lastMessageStream,
                        initialData: item.state!.lastMessage,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return Text(snapshot.data!.text!);
                          }

                          return const SizedBox();
                        },
                      ),
                      onTap: () {
                        /// Display a list of messages when the user taps on
                        /// an item. We can use [StreamChannel] to wrap our
                        /// [MessageScreen] screen with the selected channel.
                        ///
                        /// This allows us to use a built-in inherited widget
                        /// for accessing our `channel` later on.
                        print('onTapped');
                        // Navigator.of(context).push(
                        //   MaterialPageRoute(
                        //     builder: (context) => StreamChannel(
                        //       channel: item,
                        //       child: const MessageScreen(),
                        //     ),
                        //   ),
                        // );
                      },
                    );
                  },
                ),
              );
            },
            loading: () {
              return const Center(
                child: SizedBox(
                  height: 100,
                  width: 100,
                  child: CircularProgressIndicator(),
                ),
              );
            },
            error: (e) {
              return Center(
                child: Text(
                  'Oh no, something went wrong. '
                  'Please check your config. $e',
                ),
              );
            },
          );
        });
  }

  _buildButton() {
    final buttonTheme = Theme.of(context).elevatedButtonTheme;
    return ElevatedButton(
      style: buttonTheme.style!.copyWith(
          foregroundColor: const MaterialStatePropertyAll(Colors.white)),
      onPressed: () {},
      child: const Text('Book now'),
    );
  }
}

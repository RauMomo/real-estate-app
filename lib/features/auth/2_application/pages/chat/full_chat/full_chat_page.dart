import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:real_estate_app/core/dependency_injection.dart';
import 'package:real_estate_app/features/auth/2_application/pages/chat/bloc/chat_bloc.dart';
import 'package:real_estate_app/features/auth/2_application/pages/chat/models/chatroom_model.dart';
import 'package:real_estate_app/features/auth/2_application/pages/chat/widgets/bubble_chat.dart';
import 'package:real_estate_app/shared/constants/colors.dart';
import 'package:real_estate_app/shared/constants/ui_size_constants.dart';
import 'package:real_estate_app/shared/widgets/one_liner_text_field.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

import '../../../../../../app/network/provider/stream_chat_provider.dart';

class FullChatPage extends StatefulWidget {
  const FullChatPage({Key? key}) : super(key: key);
  static const String path = '/full-chat';

  @override
  State<FullChatPage> createState() => _FullChatPageState();
}

class _FullChatPageState extends State<FullChatPage> {
  late List<MessageContent> messages;
  late Channel chatModel;
  @override
  void initState() {
    messages = [
      MessageContent(
          isMe: false,
          msg:
              'Hello! I’m looking forward to having you stay in my apartment. Please let me know when you come to your new appartment \n Mark',
          sendAt: DateTime(2023, 2, 11, 20, 8),
          isEdited: false,
          isRead: true),
      MessageContent(
          isMe: true,
          msg: 'Hey! On Friday the 10th between 1:55 and 2:00 pm.',
          sendAt: DateTime(2023, 2, 11, 20, 11),
          isEdited: false,
          isRead: true),
      MessageContent(
          isMe: false,
          msg:
              'Hello! I’m looking forward to having you stay in my apartment. Please let me know when you come to your new appartment \n Mark',
          sendAt: DateTime(2023, 2, 11, 20, 15),
          isEdited: false,
          isRead: true),
      MessageContent(
          isMe: true,
          msg: 'Hey! On Friday the 10th between 1:55 and 2:00 pm.',
          sendAt: DateTime(2023, 2, 11, 20, 16),
          isEdited: false,
          isRead: true)
    ];
    super.initState();
  }

  @override
  void didChangeDependencies() {
    chatModel = context.read<ChatBloc>().chatroomItem!;
    super.didChangeDependencies();
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
        offset: const Offset(0, 16),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Align(
                alignment: AlignmentDirectional.center,
                child: CircleAvatar(
                  radius: 24,
                  backgroundColor: ColorConstants.kPrimary,
                  child: IconButton(
                    alignment: Alignment.center,
                    iconSize: 28,
                    style: IconButton.styleFrom(
                      padding: const EdgeInsets.all(16),
                      foregroundColor: ColorConstants.kPrimary800,
                      fixedSize: const Size.fromHeight(48),
                      shape: const RoundedRectangleBorder(),
                    ),
                    color: ColorConstants.kPrimary400,
                    hoverColor: ColorConstants.kPrimary600,
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: Icon(
                      Icons.chevron_left,
                      color: ColorConstants.kWhite,
                    ),
                  ),
                ),
              ),
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
      leading: const SizedBox.shrink(),
      primary: false,
      titleTextStyle: appBarTheme.titleTextStyle,
      backgroundColor: ColorConstants.kWhite,
      elevation: appBarTheme.elevation,
    );
  }

  _buildBody() {
    final chatProvider = sl.get<StreamChatProvider>();
    final textTheme = Theme.of(context).textTheme;
    return Container(
      color: ColorConstants.kDark200,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Expanded(
                  child: StreamChannel(
                    channel: chatModel,
                    child: StreamMessageListView(
                      emptyBuilder: (context) {
                        return Center(
                          child: Text(
                              'Anda belum menyapa ${chatModel.name}, silahkan kirimkan pesan untuknya!'),
                        );
                      },
                      messageBuilder:
                          (context, details, messages, defaultMessageWidget) {
                        debugPrint('lenght + ${messages.length}');
                        return BubbleChat(details: details);
                      },

                      // messageListBuilder: (p0, p1) {
                      //   return Container(
                      //     color: ColorConstants.kDark200,
                      //     child: Column(
                      //       children: p1
                      //           .map(
                      //             (e) => const Text('QIko'),
                      //           )
                      //           .toList(),
                      //     ),
                      //   );
                      // },
                    ),
                  ),
                ),
                // Expanded(
                //   child: ListView.separated(
                //     shrinkWrap: true,
                //     itemCount: messages.length,
                //     separatorBuilder: (context, index) {
                //       return const SizedBox(
                //         height: 16,
                //       );
                //     },
                //     itemBuilder: (context, index) {
                //       final message = messages[index];
                //       return
                //       // return message.isMe
                //       //     ? FractionallySizedBox(
                //       //         widthFactor: .83,
                //       //         alignment: Alignment.topRight,
                //       //         child: Row(
                //       //           crossAxisAlignment: CrossAxisAlignment.start,
                //       //           children: [
                //       //             Flexible(
                //       //               child: Card(
                //       //                 color: ColorConstants.kPrimary,
                //       //                 shape: const RoundedRectangleBorder(
                //       //                   borderRadius: BorderRadius.only(
                //       //                     topLeft: Radius.circular(20.0),
                //       //                     topRight: Radius.circular(20.0),
                //       //                     bottomLeft: Radius.circular(20.0),
                //       //                   ),
                //       //                 ),
                //       //                 child: Padding(
                //       //                   padding: const EdgeInsets.all(16),
                //       //                   child: Wrap(
                //       //                     alignment: WrapAlignment.start,
                //       //                     crossAxisAlignment:
                //       //                         WrapCrossAlignment.start,
                //       //                     runAlignment: WrapAlignment.start,
                //       //                     children: [
                //       //                       Text(
                //       //                         message.msg,
                //       //                         maxLines: 21,
                //       //                         style: textTheme.displayMedium!
                //       //                             .copyWith(color: Colors.white),
                //       //                       ),
                //       //                       const SizedBox(
                //       //                         height: 20,
                //       //                       ),
                //       //                     ],
                //       //                   ),
                //       //                 ),
                //       //               ),
                //       //             ),
                //       //           ],
                //       //         ),
                //       //       )
                //       //     : FractionallySizedBox(
                //       //         widthFactor: 1,
                //       //         alignment: Alignment.topLeft,
                //       //         child: Row(
                //       //           crossAxisAlignment: CrossAxisAlignment.start,
                //       //           children: [
                //       //             Container(
                //       //               alignment: Alignment.topCenter,
                //       //               height: 50,
                //       //               width: 50,
                //       //               margin: const EdgeInsets.only(top: 8),
                //       //               decoration: BoxDecoration(
                //       //                 color: Colors.red,
                //       //                 shape: BoxShape.circle,
                //       //                 image: DecorationImage(
                //       //                     alignment: Alignment.center,
                //       //                     image: chatModel.image != null
                //       //                         ? NetworkImage(chatModel.image!)
                //       //                         : const AssetImage(
                //       //                                 'assets/avatars/Avatar-1.png')
                //       //                             as ImageProvider,
                //       //                     fit: BoxFit.contain),
                //       //               ),
                //       //             ),
                //       //             hSpaceSmall,
                //       //             Flexible(
                //       //               child: Card(
                //       //                 child: Padding(
                //       //                   padding: const EdgeInsets.symmetric(
                //       //                       vertical: 16, horizontal: 12),
                //       //                   child: Wrap(
                //       //                     alignment: WrapAlignment.start,
                //       //                     crossAxisAlignment:
                //       //                         WrapCrossAlignment.start,
                //       //                     runAlignment: WrapAlignment.start,
                //       //                     children: [
                //       //                       Text(
                //       //                         message.msg,
                //       //                         maxLines: 21,
                //       //                         style: textTheme.displayMedium,
                //       //                       ),
                //       //                       const SizedBox(
                //       //                         height: 20,
                //       //                       ),
                //       //                     ],
                //       //                   ),
                //       //                 ),
                //       //               ),
                //       //             ),
                //       //           ],
                //       //         ),
                //       //       );
                //     },
                //   ),
                // ),
                const SizedBox(
                  height: 100,
                )
              ],
            ),
          ),
          _buildChatBox()
        ],
      ),
    );
  }

  _buildChatBox() {
    final theme = Theme.of(context);
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        alignment: Alignment.center,
        height: 100,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: <BoxShadow>[
            BoxShadow(
              blurRadius: 5,
              color: ColorConstants.kLightGrey,
              offset: const Offset(0, -3),
            ),
          ],
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(20),
          ),
        ),
        child: TextField(
          autofocus: true,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: 'Write a comment...',
            suffixIcon: IconTheme(
              data: theme.iconTheme,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    CupertinoIcons.smiley,
                    color: ColorConstants.kDark,
                  ),
                  hSpaceRegular,
                  const Icon(
                    Icons.send,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

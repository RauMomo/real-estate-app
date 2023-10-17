import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:real_estate_app/features/auth/2_application/pages/chat/bloc/chat_bloc.dart';
import 'package:real_estate_app/shared/constants/colors.dart';
import 'package:real_estate_app/shared/constants/ui_size_constants.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

class RegularBubble extends StatelessWidget {
  const RegularBubble(
      {super.key, required this.message, required this.isMyMessage});

  final Message message;
  final bool isMyMessage;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final chatModel = context.read<ChatBloc>().chatroomItem!;
    return isMyMessage
        ? FractionallySizedBox(
            widthFactor: .83,
            alignment: Alignment.topRight,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(
                  child: Card(
                    color: ColorConstants.kPrimary,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20.0),
                        topRight: Radius.circular(20.0),
                        bottomLeft: Radius.circular(20.0),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Wrap(
                        alignment: WrapAlignment.start,
                        crossAxisAlignment: WrapCrossAlignment.start,
                        runAlignment: WrapAlignment.start,
                        children: [
                          Text(
                            message.text!,
                            maxLines: 21,
                            style: textTheme.displayMedium!
                                .copyWith(color: Colors.white),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        : FractionallySizedBox(
            widthFactor: 1,
            alignment: Alignment.topLeft,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  alignment: Alignment.topCenter,
                  height: 50,
                  width: 50,
                  margin: const EdgeInsets.only(top: 8),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        alignment: Alignment.center,
                        image: chatModel.image != null
                            ? NetworkImage(chatModel.image!)
                            : const AssetImage('assets/avatars/Avatar-1.png')
                                as ImageProvider,
                        fit: BoxFit.contain),
                  ),
                ),
                hSpaceSmall,
                Flexible(
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 16, horizontal: 12),
                      child: Wrap(
                        alignment: WrapAlignment.start,
                        crossAxisAlignment: WrapCrossAlignment.start,
                        runAlignment: WrapAlignment.start,
                        children: [
                          Text(
                            message.text!,
                            maxLines: 21,
                            style: textTheme.displayMedium,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
  }
}

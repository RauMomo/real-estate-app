import 'dart:math';

import 'package:flutter/material.dart';
import 'package:real_estate_app/shared/constants/colors.dart';
import 'package:real_estate_app/shared/constants/ui_size_constants.dart';
import 'package:real_estate_app/shared/widgets/single_rating.dart';

class ReviewPage extends StatefulWidget {
  const ReviewPage({Key? key}) : super(key: key);

  static const String path = '/review';

  @override
  State<ReviewPage> createState() => _ReviewPageState();
}

class _ReviewPageState extends State<ReviewPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  _buildAppBar() {
    final appBarTheme = Theme.of(context).appBarTheme;
    var toolbarHeightSize = screenHeightPercentage(context, percentage: 0.12);
    return AppBar(
      toolbarHeight: toolbarHeightSize,
      leading: Transform.translate(
        offset: Offset(16, toolbarHeightSize / 4),
        child: Align(
          alignment: AlignmentDirectional.centerStart,
          child: CircleAvatar(
            radius: 20,
            backgroundColor: ColorConstants.kPrimary,
            child: IconButton(
              alignment: Alignment.center,
              iconSize: 20,
              style: IconButton.styleFrom(
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
                Icons.arrow_back_ios_outlined,
                color: ColorConstants.kWhite,
              ),
            ),
          ),
        ),
      ),
      title: Transform.translate(
        offset: Offset(0, toolbarHeightSize / 4),
        child: Text(
          'Reviews about Jack'.toUpperCase(),
        ),
      ),
      automaticallyImplyLeading: true,
      centerTitle: true,
      primary: false,
      titleTextStyle:
          appBarTheme.titleTextStyle!.copyWith(fontSize: 14, height: 1.0),
      backgroundColor: ColorConstants.kWhite,
      elevation: appBarTheme.elevation,
    );
  }

  _buildBody() {
    final textTheme = Theme.of(context).textTheme;
    return ListView.builder(
      itemCount: 4,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/avatars/Avatar-1.png'),
                  ),
                ),
                height: 60,
                width: 60,
              ),
              hSpaceRegular,
              Expanded(
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Wrap(
                      runSpacing: 10.0,
                      children: [
                        Text(
                          'I highly recommend this host, really clean apartments, everything is done on time with nice surprises, very good locations of the apartments',
                          style: textTheme.displayMedium,
                        ),
                        Transform.translate(
                            offset: const Offset(-5, 0),
                            child: SingleRating(
                                rating: Random().nextInt(5), size: 24))
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

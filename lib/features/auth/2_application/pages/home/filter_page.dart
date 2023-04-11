import 'package:flutter/material.dart';
import 'package:real_estate_app/features/auth/2_application/pages/home/widgets/room_filter.dart';
import 'package:real_estate_app/features/auth/2_application/pages/home/widgets/star_rating.dart';
import 'package:real_estate_app/shared/constants/colors.dart';
import 'package:real_estate_app/shared/constants/ui_size_constants.dart';
import 'package:real_estate_app/shared/widgets/add_button.dart';
import 'package:real_estate_app/shared/widgets/date_time_picker.dart';
import 'package:real_estate_app/shared/widgets/slider_seek.dart';

class FilterPage extends StatefulWidget {
  static const String path = '/filter';
  const FilterPage({Key? key}) : super(key: key);

  @override
  State<FilterPage> createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white70,
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
          'Filters'.toUpperCase(),
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
    return Stack(children: [
      Container(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              _buildDatePicker(),
              _buildRangeSlider(),
              _buildStarRange(),
              _buildRoomFilter(),
              SizedBox(
                height: screenHeightPercentage(context, percentage: .1),
              )
            ],
          ),
        ),
      ),
      Align(
        alignment: Alignment.bottomCenter,
        child: Material(
          elevation: 30.0,
          child: Container(
            color: Colors.white,
            padding: const EdgeInsets.all(16),
            height: screenHeightPercentage(context, percentage: .1),
            child: SizedBox(
              height: screenHeightPercentage(context, percentage: .04),
              child: AddButton(
                isFullWidth: true,
                buttonText: 'Apply filters',
                type: ButtonType.fill,
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
          ),
        ),
      ),
    ]);
  }

  _buildDatePicker() {
    return CustomDatePicker(
      pastDatesOnly: true,
      onConfirm: (newDate) {
        debugPrint(newDate.toString());
      },
    );
  }

  _buildRangeSlider() {
    return const SliderSeek(
      title: 'Price Range',
    );
  }

  _buildStarRange() {
    return StarRating(numberOfStars: 5, onSelected: (int value) {});
  }

  _buildRoomFilter() {
    return const RoomFilter();
  }
}

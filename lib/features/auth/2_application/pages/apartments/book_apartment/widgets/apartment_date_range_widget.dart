import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:real_estate_app/shared/constants/colors.dart';
import 'package:real_estate_app/shared/constants/ui_size_constants.dart';

class ApartmentDateRangeWidget extends StatelessWidget {
  const ApartmentDateRangeWidget(
      {super.key, required this.startDate, required this.endDate});

  final DateTime startDate;
  final DateTime endDate;

  @override
  Widget build(BuildContext context) {
    final dateRangeHeight = screenHeightPercentage(context, percentage: .3);
    final dateRangeWidth = screenWidthPercentage(context, percentage: .3);

    final startMonthFormat = DateFormat.MMM().format(startDate);
    final endMonthFormat = DateFormat.MMM().format(endDate);

    final startDayFormat = DateFormat.d().format(startDate);
    final endDayFormat = DateFormat.d().format(endDate);

    final textTheme = Theme.of(context).textTheme;
    return Container(
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.all(16),
      constraints:
          BoxConstraints(maxHeight: dateRangeHeight, maxWidth: dateRangeWidth),
      alignment: AlignmentDirectional.centerStart,
      decoration: BoxDecoration(
        color: ColorConstants.kPrimary200,
        borderRadius: const BorderRadius.all(
          Radius.circular(80),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            alignment: Alignment.bottomCenter,
            height: screenHeightPercentage(context, percentage: .12),
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Text(
                  startMonthFormat,
                  style: textTheme.displayMedium!
                      .copyWith(color: ColorConstants.kDark200, fontSize: 16),
                ),
                vSpaceTiny,
                Text(
                  startDayFormat,
                  style: textTheme.displayMedium!
                      .copyWith(color: Colors.black, fontSize: 16),
                ),
                vSpaceTiny
              ],
            ),
          ),
          vSpaceRegular,
          Container(
            alignment: Alignment.center,
            height: screenHeightPercentage(context, percentage: .12),
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Text(
                  endMonthFormat,
                  style: textTheme.displayMedium!
                      .copyWith(color: ColorConstants.kDark200, fontSize: 16),
                ),
                vSpaceTiny,
                Text(
                  endDayFormat,
                  style: textTheme.displayMedium!
                      .copyWith(color: Colors.black, fontSize: 16),
                ),
                vSpaceTiny
              ],
            ),
          ),
        ],
      ),
    );
  }
}

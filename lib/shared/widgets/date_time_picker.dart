import 'package:flutter/material.dart';
import 'package:real_estate_app/shared/constants/colors.dart';
import 'package:real_estate_app/shared/constants/ui_size_constants.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

enum DateTimeType { single, multi }

class CustomDatePicker extends StatefulWidget {
  const CustomDatePicker(
      {Key? key,
      this.selectedDates,
      this.onDaySelected,
      this.onCancel,
      this.onConfirm,
      this.pastDatesOnly = false})
      : super(key: key);
  final List<DateTime>? selectedDates;
  final Function(DateTime)? onDaySelected;
  final Function(DateTime)? onCancel;
  final Function(DateTime)? onConfirm;
  final bool? pastDatesOnly;

  @override
  _CustomDatePickerState createState() {
    return _CustomDatePickerState();
  }
}

class _CustomDatePickerState extends State<CustomDatePicker> {
  late List<DateTime> selectedDates;
  late DateTime selectedSingleDate;
  late Function(DateTime)? onCancel;
  late Function(DateTime)? onConfirm;
  late bool _pastDatesOnly;
  late DateRangePickerController _controller;

  @override
  void initState() {
    selectedDates = widget.selectedDates ?? List<DateTime>.empty();
    selectedSingleDate = DateTime.now();
    _pastDatesOnly = widget.pastDatesOnly ?? false;
    _controller = DateRangePickerController();
    super.initState();
  }

  void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    /// The argument value will return the changed date as [DateTime] when the
    /// widget [SfDateRangeSelectionMode] set as single.
    ///
    /// The argument value will return the changed dates as [List<DateTime>]
    /// when the widget [SfDateRangeSelectionMode] set as multiple.
    ///
    /// The argument value will return the changed range as [PickerDateRange]
    /// when the widget [SfDateRangeSelectionMode] set as range.
    ///
    /// The argument value will return the changed ranges as
    /// [List<PickerDateRange] when the widget [SfDateRangeSelectionMode] set as
    /// multi range.
    setState(() {
      if (args.value is PickerDateRange) {
        // _range = '${DateFormat('dd/MM/yyyy').format(args.value.startDate)} -'
        //     // ignore: lines_longer_than_80_chars
        //     ' ${DateFormat('dd/MM/yyyy').format(args.value.endDate ?? args.value.startDate)}';
      } else if (args.value is DateTime) {
        // _selectedDate = args.value.toString();
        selectedSingleDate = args.value;
      } else if (args.value is List<DateTime>) {
        // _dateCount = args.value.length.toString();
      } else {
        // _rangeCount = args.value.length.toString();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    return Transform.translate(
      offset: const Offset(0, -16),
      child: DefaultTextStyle(
        style: textTheme.bodySmall!,
        child: SizedBox(
          height: screenHeightPercentage(context, percentage: .55),
          child: SfDateRangePicker(
            controller: _controller,
            monthCellStyle: DateRangePickerMonthCellStyle(
              specialDatesTextStyle: const TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 15,
                  color: Colors.black),
              todayCellDecoration: const BoxDecoration(
                border: Border.fromBorderSide(BorderSide.none),
              ),
              leadingDatesTextStyle: const TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 15,
                  color: Colors.black),
              weekendDatesDecoration: const BoxDecoration(
                color: Colors.transparent,
              ),
              trailingDatesTextStyle: const TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 15,
                  color: Colors.black),
              textStyle: const TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 15,
                  color: Colors.black),
              blackoutDateTextStyle: const TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 15,
                  color: Colors.black),
              todayTextStyle: TextStyle(
                  fontStyle: FontStyle.italic,
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: ColorConstants.kPrimary),
              weekendTextStyle: const TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 15,
                  color: Colors.black),
              disabledDatesTextStyle: const TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 15,
                  color: Colors.grey),
              leadingDatesDecoration: const BoxDecoration(
                color: Colors.transparent,
              ),
              disabledDatesDecoration: const BoxDecoration(
                color: Colors.transparent,
              ),
            ),
            monthViewSettings: const DateRangePickerMonthViewSettings(
              viewHeaderStyle: DateRangePickerViewHeaderStyle(
                textStyle: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 15,
                    color: Colors.black),
              ),
            ),
            cellBuilder: (context, cellDetails) {
              return Container(
                padding: const EdgeInsets.all(8),
                margin: const EdgeInsets.symmetric(horizontal: 2),
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  shape: BoxShape.circle,
                  border: Border.all(
                      width: .3,
                      color: cellDetails.date.day == selectedSingleDate.day
                          ? Colors.black
                          : Colors.transparent),
                ),
                child: Align(
                  alignment: AlignmentDirectional.center,
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text(
                        cellDetails.date.day.toString(),
                        textAlign: TextAlign.center,
                        style: textTheme.headlineMedium!.copyWith(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.normal),
                      ),
                      if (cellDetails.date.isAfter(
                        DateTime.now().subtract(
                          const Duration(days: 1),
                        ),
                      ))
                        Wrap(
                          children: [
                            Text(
                              cellDetails.date.day != 30
                                  ? '\u0024189'
                                  : '\u0024224',
                              softWrap: false,
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.ellipsis,
                              style: textTheme.displayMedium!.copyWith(
                                  height: 1.0,
                                  color: cellDetails.date.day != 30
                                      ? ColorConstants.kSuccess
                                      : ColorConstants.kError),
                            ),
                          ],
                        ),
                    ],
                  ),
                ),
              );
            },
            initialSelectedDate: selectedSingleDate,
            // on: (date) {
            //   setState(() {
            //     selectedSingleDate = date;
            //   });
            // },
            // cellBuilder: (context, cellDetails) {},
            view: DateRangePickerView.month,
            navigationMode: DateRangePickerNavigationMode.snap,
            navigationDirection: DateRangePickerNavigationDirection.horizontal,
            allowViewNavigation: true,
            initialDisplayDate: DateTime.now().copyWith(day: 1),
            onSelectionChanged: _onSelectionChanged,
            selectionMode: DateRangePickerSelectionMode.single,
            monthFormat: '  MMMM',
            maxDate: DateTime(2050),
            headerHeight: 50,
            showNavigationArrow: false,
            toggleDaySelection: false,
            todayHighlightColor: ColorConstants.kPrimary,
            selectionColor: Colors.transparent,
            selectionTextStyle: const TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 15,
              height: 1,
              color: Colors.black,
            ),
            selectionShape: DateRangePickerSelectionShape.circle,
            headerStyle: DateRangePickerHeaderStyle(
              textAlign: TextAlign.left,
              textStyle: textTheme.headlineMedium!.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  height: 2,
                  color: Colors.black),
            ),
            enablePastDates: false,
            selectionRadius: 40,
          ),
        ),
      ),
    );
  }
}

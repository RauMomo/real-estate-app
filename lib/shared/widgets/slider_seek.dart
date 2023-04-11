import 'dart:async';

import 'package:flutter/material.dart';
import 'package:real_estate_app/shared/constants/colors.dart';
import 'package:real_estate_app/shared/constants/ui_size_constants.dart';
import 'package:real_estate_app/shared/util/conversion.dart';

class SliderSeek extends StatefulWidget {
  const SliderSeek({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<SliderSeek> createState() => _SliderSeekState();
}

class _SliderSeekState extends State<SliderSeek> {
  late double sliderValue;
  final _initialSliderValue = 200.0;
  late StreamController<double> sliderStreamValue;
  late Stream<double> streamValue;
  late double expectedWidth;
  late String formattedValue;
  late int formattedinIntValue;
  late String title;

  @override
  void initState() {
    sliderStreamValue = StreamController<double>();
    sliderStreamValue.sink.add(_initialSliderValue);

    streamValue = sliderStreamValue.stream;
    sliderValue = 0;
    expectedWidth = 0;
    formattedValue = '';
    formattedinIntValue = 0;
    title = widget.title;

    streamValue.listen((event) {
      sliderValue = event;
      expectedWidth = sliderValue * .045;
      formattedValue = sliderValue.ceil().toString();
      formattedinIntValue = sliderValue.toInt();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final isOveflow = (sliderValue < 300 || sliderValue > 5600) == true;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 12),
          child: Text(
            title,
            style: textTheme.headlineMedium,
          ),
        ),
        SliderTheme(
          data: SliderThemeData(
            showValueIndicator: ShowValueIndicator.always,
            valueIndicatorShape: SliderComponentShape.noOverlay,
          ),
          child: Slider(
            min: 0,
            max: 7000,
            value: sliderValue,
            label: 'Value',
            thumbColor: ColorConstants.kPrimary,
            onChanged: (value) {
              setState(() {
                sliderStreamValue.add(value);
              });
              debugPrint(sliderValue.toString());
              debugPrint(expectedWidth.toString());
            },
          ),
        ),
        Container(
          width: screenWidth(context),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Stack(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Align(
                    alignment: AlignmentDirectional.centerStart,
                    child: Text('\u00240'),
                  ),
                  Align(
                    alignment: AlignmentDirectional.centerEnd,
                    child: Text('\u00247.000'),
                  ),
                ],
              ),
              Visibility(
                visible: !isOveflow,
                replacement: const SizedBox.shrink(),
                child: Transform.translate(
                  offset: Offset(expectedWidth - 16, 0),
                  child: Text(
                    '\u0024${formatToCurrency(formattedinIntValue)}',
                    textAlign: TextAlign.left,
                    style: textTheme.headlineMedium!.copyWith(
                      height: 1.2,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

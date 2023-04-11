import 'package:flutter/material.dart';
import 'package:real_estate_app/shared/constants/ui_size_constants.dart';

class ButtonList extends StatefulWidget {
  const ButtonList(
      {Key? key, required this.buttonList, required this.onChanged})
      : super(key: key);
  final List<String> buttonList;
  final Function(int) onChanged;

  @override
  State<ButtonList> createState() => _ButtonListState();
}

class _ButtonListState extends State<ButtonList> {
  late ScrollController scrollController;
  late List<String> buttonTitleList;
  late List<bool> areSelected;
  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
    buttonTitleList = widget.buttonList;
    areSelected = buttonTitleList.map((e) => false).toList();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return SizedBox(
      height: 32,
      child: ListView.separated(
        separatorBuilder: (context, index) {
          return hSpaceSmall;
        },
        controller: scrollController,
        scrollDirection: Axis.horizontal,
        itemCount: buttonTitleList.length,
        itemBuilder: (context, index) {
          return ChoiceChip(
            visualDensity: const VisualDensity(horizontal: 0, vertical: -2),
            labelStyle: textTheme.bodyMedium,
            shape: const BeveledRectangleBorder(),
            label: Text(buttonTitleList[index]),
            selected: areSelected[index],
            onSelected: (value) {
              setState(() {
                areSelected[index] = !areSelected[index];
              });
            },
            pressElevation: 0.0,
          );
        },
      ),
    );
  }
}

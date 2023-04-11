import 'package:flutter/material.dart';
import 'package:real_estate_app/shared/constants/ui_size_constants.dart';
import 'package:real_estate_app/shared/widgets/add_button.dart';
import 'package:real_estate_app/shared/widgets/filter_button.dart';

class RoomFilter extends StatefulWidget {
  const RoomFilter({Key? key}) : super(key: key);

  @override
  State<RoomFilter> createState() => _RoomFilterState();
}

class _RoomFilterState extends State<RoomFilter> {
  final roomsFilter = ['Studio', '2 bathroom', '3 bathroom', '4 bathroom'];
  List<bool> isSelected = [false, false, false, false];

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.only(left: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Rooms',
            style: textTheme.headlineMedium,
          ),
          vSpaceRegular,
          SizedBox(
            height: 40,
            child: ListView(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              children: roomsFilter.map((e) {
                final index = roomsFilter.indexOf(e);
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: FilterButton(
                      type: ButtonType.fill,
                      isFullWidth: false,
                      buttonText: e,
                      isSelected: isSelected[index],
                      onPressed: () {
                        setState(() {
                          isSelected[index] = !isSelected[index];
                        });
                      }),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}

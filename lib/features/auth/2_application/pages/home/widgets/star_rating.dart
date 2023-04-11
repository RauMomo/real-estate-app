import 'package:flutter/material.dart';
import 'package:real_estate_app/shared/constants/colors.dart';

class StarRating extends StatefulWidget {
  const StarRating(
      {Key? key, required this.onSelected, required this.numberOfStars})
      : super(key: key);

  final Function(int) onSelected;
  final int numberOfStars;
  @override
  State<StarRating> createState() => _StarRatingState();
}

class _StarRatingState extends State<StarRating> {
  late int numberOfStars;
  late int selectedIndex;
  @override
  void initState() {
    numberOfStars = widget.numberOfStars;
    selectedIndex = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Star Range',
            style: textTheme.headlineMedium,
          ),
          ListView(
            shrinkWrap: true,
            children: [
              for (int i = 5; i >= 1; i--)
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  dense: true,
                  title: Row(
                    children: List.generate(
                      i,
                      (index) => Icon(
                        Icons.star_outlined,
                        color: ColorConstants.kPrimary,
                      ),
                    ),
                  ),
                  trailing: InkWell(
                    onTap: () {
                      setState(
                        () {
                          selectedIndex = i - 1;
                        },
                      );
                    },
                    child: Icon(
                      Icons.check_circle,
                      size: 28,
                      color: selectedIndex == i - 1
                          ? ColorConstants.kPrimary
                          : ColorConstants.kLightGrey,
                    ),
                  ),
                ),
            ],
          )
        ],
      ),
    );
  }
}

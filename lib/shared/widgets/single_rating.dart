import 'package:flutter/material.dart';

class SingleRating extends StatefulWidget {
  const SingleRating({Key? key, required this.rating, required this.size})
      : super(key: key);

  final int rating;
  final int size;

  @override
  State<SingleRating> createState() => _SingleRatingState();
}

class _SingleRatingState extends State<SingleRating> {
  late int rating;
  late double size;

  @override
  void initState() {
    rating = widget.rating;
    size = widget.size.toDouble();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: List.generate(
        rating,
        (index) => Icon(
          Icons.star,
          size: size,
          color: Colors.yellow[600],
        ),
      ),
    );
  }
}

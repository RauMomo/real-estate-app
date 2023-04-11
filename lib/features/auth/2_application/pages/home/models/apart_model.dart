import 'package:equatable/equatable.dart';

class ApartModel extends Equatable {
  final bool isLiked;
  final double targetedMiles;
  final String apartName;
  final String location;
  final String fullAddress;
  final int pricePerDay;
  final double rating;
  final String image;
  final String currency;
  final String offer;

  const ApartModel(
      {required this.isLiked,
      required this.targetedMiles,
      required this.apartName,
      required this.location,
      required this.fullAddress,
      required this.pricePerDay,
      required this.rating,
      this.offer = '',
      this.currency = "\u0024",
      this.image = 'assets/images/apart_preview.png'});

  @override
  List<Object?> get props => [
        isLiked,
        targetedMiles,
        apartName,
        location,
        fullAddress,
        pricePerDay,
        rating,
        offer,
      ];
}

import 'package:equatable/equatable.dart';
import 'package:mongo_dart/mongo_dart.dart';

class ApartModel extends Equatable {
  final ObjectId id;
  final bool isLiked;
  final double targetedMiles;
  final String apartName;
  final String location;
  final String fullAddress;
  final int pricePerDay;
  final double rating;
  final String image;
  final String currency;
  final bool isOffer;
  final String offerDetail;

  const ApartModel(
      {required this.id,
      this.isLiked = false,
      this.targetedMiles = 10,
      required this.apartName,
      required this.location,
      required this.fullAddress,
      required this.pricePerDay,
      this.rating = 5,
      this.isOffer = false,
      this.currency = "\u0024",
      this.offerDetail = '',
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
        isOffer,
      ];

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      "_id": id,
      'apartName': apartName,
      'location': location,
      'fullAddress': fullAddress,
      'pricePerDay': pricePerDay,
      'image': image,
      'isOffer': isOffer
    };
  }

  factory ApartModel.fromMap(Map<String, dynamic> map) {
    return ApartModel(
        offerDetail: map.containsKey('offerDetail')
            ? map['offerDetail'] as String
            : 'Ahaha',
        id: map['_id'] as ObjectId,
        apartName: map['apartName'] as String,
        location: map['location'] as String,
        fullAddress: map['fullAddress'] as String,
        pricePerDay: map['pricePerDay'] as int,
        image: map['image'] as String,
        isOffer: map['isOffer'] as bool);
  }
}

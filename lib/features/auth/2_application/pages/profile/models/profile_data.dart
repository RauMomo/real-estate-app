// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:equatable/equatable.dart';

class ProfileData extends Equatable {
  final String name;
  final String location;
  final String description;

  const ProfileData(
      {required this.name, required this.location, required this.description});
  @override
  List<Object?> get props => [name, location, description];

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'name': name,
      'location': location,
      'description': description,
    };
  }

  factory ProfileData.fromMap(Map<String, dynamic> map) {
    return ProfileData(
      name: map['name'] as String,
      location: map['location'] as String,
      description: map['description'] as String,
    );
  }
}

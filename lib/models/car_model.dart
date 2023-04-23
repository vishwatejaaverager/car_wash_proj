// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class CarModel {
  final String? carImage;
  final String? carName;
  final String? carComp;
  final bool? isPrime;
  CarModel({
    this.carImage,
    this.carName,
    this.carComp,
    this.isPrime,
  });

  CarModel copyWith({
    String? carImage,
    String? carName,
    String? carComp,
    bool? isPrime,
  }) {
    return CarModel(
      carImage: carImage ?? this.carImage,
      carName: carName ?? this.carName,
      carComp: carComp ?? this.carComp,
      isPrime: isPrime ?? this.isPrime,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'carImage': carImage,
      'carName': carName,
      'carComp': carComp,
      'isPrime': isPrime,
    };
  }

  factory CarModel.fromMap(Map<String, dynamic> map) {
    return CarModel(
      carImage: map['carImage'] != null ? map['carImage'] as String : null,
      carName: map['carName'] != null ? map['carName'] as String : null,
      carComp: map['carComp'] != null ? map['carComp'] as String : null,
      isPrime: map['isPrime'] != null ? map['isPrime'] as bool : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory CarModel.fromJson(String source) =>
      CarModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'CarModel(carImage: $carImage, carName: $carName, carComp: $carComp, isPrime: $isPrime)';
  }

  @override
  bool operator ==(covariant CarModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.carImage == carImage &&
      other.carName == carName &&
      other.carComp == carComp &&
      other.isPrime == isPrime;
  }

  @override
  int get hashCode {
    return carImage.hashCode ^
      carName.hashCode ^
      carComp.hashCode ^
      isPrime.hashCode;
  }
}

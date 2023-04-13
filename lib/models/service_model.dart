// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class ServiceModel {
  String serviceName;
  String servicePrice;
  String serviceActualPrice;
  String serviceTime;
  String recommendation;
  List included;
  List serviceVideos;
  ServiceModel({
    required this.serviceName,
    required this.servicePrice,
    required this.serviceActualPrice,
    required this.serviceTime,
    required this.recommendation,
    required this.included,
    required this.serviceVideos,
  });

  ServiceModel copyWith({
    String? serviceName,
    String? servicePrice,
    String? serviceActualPrice,
    String? serviceTime,
    String? recommendation,
    List? included,
    List? serviceVideos,
  }) {
    return ServiceModel(
      serviceName: serviceName ?? this.serviceName,
      servicePrice: servicePrice ?? this.servicePrice,
      serviceActualPrice: serviceActualPrice ?? this.serviceActualPrice,
      serviceTime: serviceTime ?? this.serviceTime,
      recommendation: recommendation ?? this.recommendation,
      included: included ?? this.included,
      serviceVideos: serviceVideos ?? this.serviceVideos,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'serviceName': serviceName,
      'servicePrice': servicePrice,
      'serviceActualPrice': serviceActualPrice,
      'serviceTime': serviceTime,
      'recommendation': recommendation,
      'included': included,
      'serviceVideos': serviceVideos,
    };
  }

  factory ServiceModel.fromMap(Map<String, dynamic> map) {
    return ServiceModel(
        serviceName: map['serviceName'] as String,
        servicePrice: map['servicePrice'] as String,
        serviceActualPrice: map['serviceActualPrice'] as String,
        serviceTime: map['serviceTime'] as String,
        recommendation: map['recommendation'] as String,
        included: List.from(
          (map['included'] as List),
        ),
        serviceVideos: List.from((map['serviceVideos'] as List)));
  }

  String toJson() => json.encode(toMap());

  factory ServiceModel.fromJson(String source) =>
      ServiceModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ServiceModel(serviceName: $serviceName, servicePrice: $servicePrice, serviceActualPrice: $serviceActualPrice, serviceTime: $serviceTime, recommendation: $recommendation, included: $included, serviceVideos: $serviceVideos)';
  }

  @override
  bool operator ==(covariant ServiceModel other) {
    if (identical(this, other)) return true;

    return other.serviceName == serviceName &&
        other.servicePrice == servicePrice &&
        other.serviceActualPrice == serviceActualPrice &&
        other.serviceTime == serviceTime &&
        other.recommendation == recommendation &&
        listEquals(other.included, included) &&
        listEquals(other.serviceVideos, serviceVideos);
  }

  @override
  int get hashCode {
    return serviceName.hashCode ^
        servicePrice.hashCode ^
        serviceActualPrice.hashCode ^
        serviceTime.hashCode ^
        recommendation.hashCode ^
        included.hashCode ^
        serviceVideos.hashCode;
  }
}

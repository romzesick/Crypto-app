import 'package:hive_ce_flutter/adapters.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';
import 'models.dart';

part 'crypto_model.g.dart';

@HiveType(typeId: 2)
@JsonSerializable()
class CryptoCoin extends Equatable {
  @HiveField(0)
  final String name;
  @HiveField(1)
  final CryptoCoinDetails details;

  const CryptoCoin({required this.name, required this.details});

  @override
  List<Object> get props => [name, details];

  factory CryptoCoin.fromJson(Map<String, dynamic> json) =>
      _$CryptoCoinFromJson(json);

  Map<String, dynamic> toJson() => _$CryptoCoinToJson(this);
}

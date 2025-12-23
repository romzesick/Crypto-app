import 'package:equatable/equatable.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:json_annotation/json_annotation.dart';

part 'crypto_coin_details_model.g.dart';

@HiveType(typeId: 1)
@JsonSerializable()
class CryptoCoinDetails extends Equatable {
  const CryptoCoinDetails({
    required this.priceInUSD,
    required this.imagUrl,
    required this.toSymbol,
    required this.lastUpdate,
    required this.high24Hour,
    required this.low24Hour,
  });
  @HiveField(0)
  @JsonKey(name: 'PRICE')
  final double priceInUSD;
  @HiveField(1)
  @JsonKey(name: 'IMAGEURL')
  final String imagUrl;
  @HiveField(2)
  @JsonKey(name: 'TOSYMBOL')
  final String toSymbol;
  @HiveField(3)
  @JsonKey(
    name: 'LASTUPDATE',
    toJson: _dateTimeToJson,
    fromJson: _dateTimeFromJson,
  )
  final DateTime lastUpdate;
  @HiveField(4)
  @JsonKey(name: 'HIGH24HOUR')
  final double high24Hour;
  @HiveField(5)
  @JsonKey(name: 'LOW24HOUR')
  final double low24Hour;

  String get fullImageUrl => 'https://www.cryptocompare.com$imagUrl';

  @override
  List<Object> get props {
    return [priceInUSD, imagUrl, toSymbol, lastUpdate, high24Hour, low24Hour];
  }

  static int _dateTimeToJson(DateTime time) => time.millisecondsSinceEpoch;

  static DateTime _dateTimeFromJson(int miliSeconds) =>
      DateTime.fromMillisecondsSinceEpoch(miliSeconds);

  factory CryptoCoinDetails.fromJson(Map<String, dynamic> json) =>
      _$CryptoCoinDetailsFromJson(json);

  Map<String, dynamic> toJson() => _$CryptoCoinDetailsToJson(this);
}

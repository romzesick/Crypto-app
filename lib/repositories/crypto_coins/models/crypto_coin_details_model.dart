// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class CryptoCoinDetails extends Equatable {
  const CryptoCoinDetails({
    required this.name,
    required this.priceInUSD,
    required this.imagUrl,
    required this.toSymbol,
    required this.lastUpdate,
    required this.high24Hour,
    required this.low24Hour,
  });

  final String name;
  final double priceInUSD;
  final String imagUrl;
  final String toSymbol;
  final DateTime lastUpdate;
  final double high24Hour;
  final double low24Hour;

  @override
  List<Object> get props {
    return [
      name,
      priceInUSD,
      imagUrl,
      toSymbol,
      lastUpdate,
      high24Hour,
      low24Hour,
    ];
  }
}

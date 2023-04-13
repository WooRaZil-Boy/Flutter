// JSON을 모델로 만든다.
import 'package:equatable/equatable.dart';

class DirectGeocoding extends Equatable {
  final String name;
  final double lat;
  final double lon;
  final String country;

  DirectGeocoding({
    required this.name,
    required this.lat,
    required this.lon,
    required this.country,
  });

  factory DirectGeocoding.fromJson(List<dynamic> json) {
    final Map<String, dynamic> data = json[0];

    return DirectGeocoding(
      name: data['name'],
      lat: data['lat'],
      lon: data['lon'],
      country: data['country']
    );
  }

  @override
  List<Object> get props => [name, lat, lon, country];

  @override
  String toString() => 'DirectGeocoding(name: $name, lat: $lat, lon: $lon, country: $country)';

  DirectGeocoding copyWith({
    String? name,
    double? lat,
    double? lon,
    String? country,
  }) {
    return DirectGeocoding(
      name: name ?? this.name,
      lat: lat ?? this.lat,
      lon: lon ?? this.lon,
      country: country ?? this.country,
    );
  }
}

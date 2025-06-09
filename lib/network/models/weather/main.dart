import 'package:json_annotation/json_annotation.dart';
import 'package:hive/hive.dart';


part 'main.g.dart';

@HiveType(typeId: 3)
@JsonSerializable()
class Main {
  @HiveField(0)
  final double temp;
  @HiveField(1)
  final int humidity;

  const Main({this.temp = 0.0, this.humidity = 0});

  factory Main.fromJson(Map<String, dynamic> json) => _$MainFromJson(json);

  Map<String, dynamic> toJson() => _$MainToJson(this);
}

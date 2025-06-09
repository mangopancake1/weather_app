// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class WeatherModelAdapter extends TypeAdapter<WeatherModel> {
  @override
  final int typeId = 1;

  @override
  WeatherModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return WeatherModel(
      weather: (fields[0] as List).cast<Weather>(),
      main: fields[1] as Main,
      sys: fields[2] as Sys,
      name: fields[3] as String,
      dt: fields[4] as int,
      visibility: fields[5] as int,
      wind: fields[6] as Wind,
    );
  }

  @override
  void write(BinaryWriter writer, WeatherModel obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.weather)
      ..writeByte(1)
      ..write(obj.main)
      ..writeByte(2)
      ..write(obj.sys)
      ..writeByte(3)
      ..write(obj.name)
      ..writeByte(4)
      ..write(obj.dt)
      ..writeByte(5)
      ..write(obj.visibility)
      ..writeByte(6)
      ..write(obj.wind);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WeatherModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WeatherModel _$WeatherModelFromJson(Map<String, dynamic> json) => WeatherModel(
      weather: (json['weather'] as List<dynamic>)
          .map((e) => Weather.fromJson(e as Map<String, dynamic>))
          .toList(),
      main: Main.fromJson(json['main'] as Map<String, dynamic>),
      sys: Sys.fromJson(json['sys'] as Map<String, dynamic>),
      name: json['name'] as String,
      dt: (json['dt'] as num).toInt(),
      visibility: (json['visibility'] as num).toInt(),
      wind: Wind.fromJson(json['wind'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$WeatherModelToJson(WeatherModel instance) =>
    <String, dynamic>{
      'weather': instance.weather,
      'main': instance.main,
      'sys': instance.sys,
      'name': instance.name,
      'dt': instance.dt,
      'visibility': instance.visibility,
      'wind': instance.wind,
    };

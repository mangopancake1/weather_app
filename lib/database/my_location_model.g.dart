// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'my_location_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MyLocationModelAdapter extends TypeAdapter<MyLocationModel> {
  @override
  final int typeId = 0;

  @override
  MyLocationModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MyLocationModel(
      latitude: fields[0] as String,
      longitude: fields[1] as String,
      weatherModel: fields[2] as WeatherModel,
      title: fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, MyLocationModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.latitude)
      ..writeByte(1)
      ..write(obj.longitude)
      ..writeByte(2)
      ..write(obj.weatherModel)
      ..writeByte(3)
      ..write(obj.title);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MyLocationModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

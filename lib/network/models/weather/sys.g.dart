// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sys.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SysAdapter extends TypeAdapter<Sys> {
  @override
  final int typeId = 4;

  @override
  Sys read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Sys(
      country: fields[0] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Sys obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.country);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SysAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Sys _$SysFromJson(Map<String, dynamic> json) => Sys(
      country: json['country'] as String? ?? "Unidentified",
    );

Map<String, dynamic> _$SysToJson(Sys instance) => <String, dynamic>{
      'country': instance.country,
    };

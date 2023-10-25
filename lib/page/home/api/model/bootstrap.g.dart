// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bootstrap.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BootStrapDataAdapter extends TypeAdapter<BootStrapData> {
  @override
  final int typeId = 1;

  @override
  BootStrapData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return BootStrapData(
      products: (fields[0] as List).cast<BeerSubmitData>(),
      carousel: (fields[1] as List).cast<String>(),
      deviceConfig: fields[3] as DeviceConfig?,
    );
  }

  @override
  void write(BinaryWriter writer, BootStrapData obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.products)
      ..writeByte(1)
      ..write(obj.carousel)
      ..writeByte(3)
      ..write(obj.deviceConfig);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BootStrapDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class DeviceConfigAdapter extends TypeAdapter<DeviceConfig> {
  @override
  final int typeId = 3;

  @override
  DeviceConfig read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DeviceConfig(
      groupId: fields[2] as String,
      color: fields[4] as String?,
      id: fields[0] as int?,
      createat: fields[3] as String?,
      categorys: fields[5] as String?,
      config: fields[6] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, DeviceConfig obj) {
    writer
      ..writeByte(6)
      ..writeByte(4)
      ..write(obj.color)
      ..writeByte(5)
      ..write(obj.categorys)
      ..writeByte(6)
      ..write(obj.config)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(2)
      ..write(obj.groupId)
      ..writeByte(3)
      ..write(obj.createat);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DeviceConfigAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

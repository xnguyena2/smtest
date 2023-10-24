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
    );
  }

  @override
  void write(BinaryWriter writer, BootStrapData obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.products)
      ..writeByte(1)
      ..write(obj.carousel);
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

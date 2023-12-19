// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'store.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class StoreAdapter extends TypeAdapter<Store> {
  @override
  final int typeId = 9;

  @override
  Store read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Store(
      id: fields[0] as int?,
      groupId: fields[2] as String,
      createat: fields[3] as String?,
      name: fields[4] as String,
      time_open: fields[5] as String?,
      address: fields[6] as String?,
      phone: fields[7] as String?,
      status: fields[8] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Store obj) {
    writer
      ..writeByte(8)
      ..writeByte(4)
      ..write(obj.name)
      ..writeByte(5)
      ..write(obj.time_open)
      ..writeByte(6)
      ..write(obj.address)
      ..writeByte(7)
      ..write(obj.phone)
      ..writeByte(8)
      ..write(obj.status)
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
      other is StoreAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

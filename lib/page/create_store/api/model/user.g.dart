// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserAdapter extends TypeAdapter<User> {
  @override
  final int typeId = 12;

  @override
  User read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return User(
      username: fields[4] as String,
      id: fields[0] as int?,
      groupId: fields[2] as String,
      createat: fields[3] as String?,
      password: fields[5] as String?,
      createby: fields[6] as String?,
      phone_number: fields[7] as String?,
      phone_number_clean: fields[8] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, User obj) {
    writer
      ..writeByte(8)
      ..writeByte(4)
      ..write(obj.username)
      ..writeByte(5)
      ..write(obj.password)
      ..writeByte(6)
      ..write(obj.createby)
      ..writeByte(7)
      ..write(obj.phone_number)
      ..writeByte(8)
      ..write(obj.phone_number_clean)
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
      other is UserAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

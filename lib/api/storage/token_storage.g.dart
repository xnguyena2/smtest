// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'token_storage.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TokenStorageAdapter extends TypeAdapter<TokenStorage> {
  @override
  final int typeId = 8;

  @override
  TokenStorage read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TokenStorage(
      token: fields[0] as String,
    );
  }

  @override
  void write(BinaryWriter writer, TokenStorage obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.token);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TokenStorageAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

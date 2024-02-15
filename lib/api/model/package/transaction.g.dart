// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TransactionHistoryAdapter extends TypeAdapter<TransactionHistory> {
  @override
  final int typeId = 16;

  @override
  TransactionHistory read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TransactionHistory(
      id: fields[0] as int?,
      groupId: fields[2] as String,
      createat: fields[3] as String?,
      packageSecondId: fields[4] as String,
      payment: fields[5] as double,
      type: fields[6] as String,
      detail: fields[7] as String,
    );
  }

  @override
  void write(BinaryWriter writer, TransactionHistory obj) {
    writer
      ..writeByte(7)
      ..writeByte(4)
      ..write(obj.packageSecondId)
      ..writeByte(5)
      ..write(obj.payment)
      ..writeByte(6)
      ..write(obj.type)
      ..writeByte(7)
      ..write(obj.detail)
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
      other is TransactionHistoryAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

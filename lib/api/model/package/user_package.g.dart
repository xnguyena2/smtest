// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_package.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserPackageAdapter extends TypeAdapter<UserPackage> {
  @override
  final int typeId = 18;

  @override
  UserPackage read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserPackage(
      id: fields[0] as int,
      groupId: fields[2] as String,
      createat: fields[3] as String?,
      packageSecondId: fields[4] as String,
      deviceId: fields[5] as String,
      productSecondId: fields[6] as String,
      productUnitSecondId: fields[7] as String,
      numberUnit: fields[8] as int,
      price: fields[9] as double,
      buyPrice: fields[10] as double,
      discountAmount: fields[11] as double,
      discountPercent: fields[12] as double,
      discountPromotional: fields[16] as double?,
      note: fields[13] as String?,
      status: fields[14] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, UserPackage obj) {
    writer
      ..writeByte(15)
      ..writeByte(4)
      ..write(obj.packageSecondId)
      ..writeByte(5)
      ..write(obj.deviceId)
      ..writeByte(6)
      ..write(obj.productSecondId)
      ..writeByte(7)
      ..write(obj.productUnitSecondId)
      ..writeByte(8)
      ..write(obj.numberUnit)
      ..writeByte(9)
      ..write(obj.price)
      ..writeByte(10)
      ..write(obj.buyPrice)
      ..writeByte(11)
      ..write(obj.discountAmount)
      ..writeByte(12)
      ..write(obj.discountPercent)
      ..writeByte(13)
      ..write(obj.note)
      ..writeByte(14)
      ..write(obj.status)
      ..writeByte(16)
      ..write(obj.discountPromotional)
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
      other is UserPackageAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

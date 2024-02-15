// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'buyer.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BuyerAdapter extends TypeAdapter<Buyer> {
  @override
  final int typeId = 21;

  @override
  Buyer read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Buyer(
      id: fields[0] as int,
      groupId: fields[2] as String,
      createat: fields[3] as String?,
      deviceId: fields[4] as String,
      regionId: fields[9] as int,
      districtId: fields[10] as int,
      wardId: fields[11] as int,
      realPrice: fields[12] as double,
      totalPrice: fields[13] as double,
      shipPrice: fields[14] as double,
      discount: fields[15] as double,
      point: fields[16] as int,
      reciverFullname: fields[5] as String?,
      phoneNumberClean: fields[6] as String?,
      phoneNumber: fields[7] as String?,
      reciverAddress: fields[8] as String?,
      status: fields[17] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Buyer obj) {
    writer
      ..writeByte(17)
      ..writeByte(4)
      ..write(obj.deviceId)
      ..writeByte(5)
      ..write(obj.reciverFullname)
      ..writeByte(6)
      ..write(obj.phoneNumberClean)
      ..writeByte(7)
      ..write(obj.phoneNumber)
      ..writeByte(8)
      ..write(obj.reciverAddress)
      ..writeByte(9)
      ..write(obj.regionId)
      ..writeByte(10)
      ..write(obj.districtId)
      ..writeByte(11)
      ..write(obj.wardId)
      ..writeByte(12)
      ..write(obj.realPrice)
      ..writeByte(13)
      ..write(obj.totalPrice)
      ..writeByte(14)
      ..write(obj.shipPrice)
      ..writeByte(15)
      ..write(obj.discount)
      ..writeByte(16)
      ..write(obj.point)
      ..writeByte(17)
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
      other is BuyerAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

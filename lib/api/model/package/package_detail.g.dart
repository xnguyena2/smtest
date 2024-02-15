// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'package_detail.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PackageDetailAdapter extends TypeAdapter<PackageDetail> {
  @override
  final int typeId = 14;

  @override
  PackageDetail read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PackageDetail(
      id: fields[0] as int?,
      groupId: fields[2] as String,
      createat: fields[3] as String?,
      packageSecondId: fields[4] as String,
      deviceId: fields[5] as String?,
      staff_id: fields[6] as String?,
      price: fields[13] as double,
      payment: fields[14] as double,
      discountAmount: fields[15] as double,
      discountPercent: fields[16] as double,
      shipPrice: fields[17] as double,
      cost: fields[18] as double,
      profit: fields[19] as double,
      point: fields[20] as int,
      packageType: fields[11] as DeliverType,
      areaId: fields[7] as String?,
      areaName: fields[8] as String?,
      tableId: fields[9] as String?,
      tableName: fields[10] as String?,
      voucher: fields[12] as String?,
      note: fields[21] as String?,
      image: fields[22] as String?,
      progress: fields[23] as Progress?,
      status: fields[24] as PackageStatusType?,
    );
  }

  @override
  void write(BinaryWriter writer, PackageDetail obj) {
    writer
      ..writeByte(24)
      ..writeByte(4)
      ..write(obj.packageSecondId)
      ..writeByte(5)
      ..write(obj.deviceId)
      ..writeByte(6)
      ..write(obj.staff_id)
      ..writeByte(7)
      ..write(obj.areaId)
      ..writeByte(8)
      ..write(obj.areaName)
      ..writeByte(9)
      ..write(obj.tableId)
      ..writeByte(10)
      ..write(obj.tableName)
      ..writeByte(11)
      ..write(obj.packageType)
      ..writeByte(12)
      ..write(obj.voucher)
      ..writeByte(13)
      ..write(obj.price)
      ..writeByte(14)
      ..write(obj.payment)
      ..writeByte(15)
      ..write(obj.discountAmount)
      ..writeByte(16)
      ..write(obj.discountPercent)
      ..writeByte(17)
      ..write(obj.shipPrice)
      ..writeByte(18)
      ..write(obj.cost)
      ..writeByte(19)
      ..write(obj.profit)
      ..writeByte(20)
      ..write(obj.point)
      ..writeByte(21)
      ..write(obj.note)
      ..writeByte(22)
      ..write(obj.image)
      ..writeByte(23)
      ..write(obj.progress)
      ..writeByte(24)
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
      other is PackageDetailAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class ProgressAdapter extends TypeAdapter<Progress> {
  @override
  final int typeId = 17;

  @override
  Progress read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Progress(
      transaction: (fields[0] as List?)?.cast<TransactionHistory>(),
    );
  }

  @override
  void write(BinaryWriter writer, Progress obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.transaction);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProgressAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class DeliverTypeAdapter extends TypeAdapter<DeliverType> {
  @override
  final int typeId = 15;

  @override
  DeliverType read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return DeliverType.deliver;
      case 1:
        return DeliverType.takeaway;
      case 2:
        return DeliverType.table;
      default:
        return DeliverType.deliver;
    }
  }

  @override
  void write(BinaryWriter writer, DeliverType obj) {
    switch (obj) {
      case DeliverType.deliver:
        writer.writeByte(0);
        break;
      case DeliverType.takeaway:
        writer.writeByte(1);
        break;
      case DeliverType.table:
        writer.writeByte(2);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DeliverTypeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class PackageStatusTypeAdapter extends TypeAdapter<PackageStatusType> {
  @override
  final int typeId = 13;

  @override
  PackageStatusType read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return PackageStatusType.CREATE;
      case 1:
        return PackageStatusType.DONE;
      case 2:
        return PackageStatusType.DELETE;
      case 3:
        return PackageStatusType.CANCEL;
      case 4:
        return PackageStatusType.RETURN;
      default:
        return PackageStatusType.CREATE;
    }
  }

  @override
  void write(BinaryWriter writer, PackageStatusType obj) {
    switch (obj) {
      case PackageStatusType.CREATE:
        writer.writeByte(0);
        break;
      case PackageStatusType.DONE:
        writer.writeByte(1);
        break;
      case PackageStatusType.DELETE:
        writer.writeByte(2);
        break;
      case PackageStatusType.CANCEL:
        writer.writeByte(3);
        break;
      case PackageStatusType.RETURN:
        writer.writeByte(4);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PackageStatusTypeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

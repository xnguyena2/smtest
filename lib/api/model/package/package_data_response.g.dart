// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'package_data_response.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PackageDataResponseAdapter extends TypeAdapter<PackageDataResponse> {
  @override
  final int typeId = 20;

  @override
  PackageDataResponse read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PackageDataResponse(
      id: fields[0] as int?,
      groupId: fields[2] as String,
      createat: fields[3] as String?,
      packageSecondId: fields[4] as String,
      deviceId: fields[5] as String?,
      staff_id: fields[6] as String?,
      price: fields[13] as double,
      cost: fields[18] as double,
      profit: fields[19] as double,
      point: fields[20] as int,
      payment: fields[14] as double,
      discountAmount: fields[15] as double,
      discountPercent: fields[16] as double,
      shipPrice: fields[17] as double,
      status: fields[24] as PackageStatusType?,
      packageType: fields[11] as DeliverType,
      areaId: fields[7] as String?,
      areaName: fields[8] as String?,
      tableId: fields[9] as String?,
      tableName: fields[10] as String?,
      voucher: fields[12] as String?,
      note: fields[21] as String?,
      image: fields[22] as String?,
      progress: fields[23] as Progress?,
      items: (fields[26] as List).cast<ProductInPackageResponse>(),
      buyer: fields[27] as BuyerData?,
      discountPromotional: fields[28] as double?,
      discountByPoint: fields[29] as double?,
      additionalFee: fields[30] as double?,
      additionalConfig: fields[31] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, PackageDataResponse obj) {
    writer
      ..writeByte(30)
      ..writeByte(26)
      ..write(obj.items)
      ..writeByte(27)
      ..write(obj.buyer)
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
      ..writeByte(28)
      ..write(obj.discountPromotional)
      ..writeByte(29)
      ..write(obj.discountByPoint)
      ..writeByte(30)
      ..write(obj.additionalFee)
      ..writeByte(31)
      ..write(obj.additionalConfig)
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
      other is PackageDataResponseAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class ProductInPackageResponseAdapter
    extends TypeAdapter<ProductInPackageResponse> {
  @override
  final int typeId = 19;

  @override
  ProductInPackageResponse read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ProductInPackageResponse(
      id: fields[0] as int,
      groupId: fields[2] as String,
      deviceId: fields[5] as String,
      packageSecondId: fields[4] as String,
      createat: fields[3] as String?,
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
      beerSubmitData: fields[15] as BeerSubmitData?,
    );
  }

  @override
  void write(BinaryWriter writer, ProductInPackageResponse obj) {
    writer
      ..writeByte(16)
      ..writeByte(15)
      ..write(obj.beerSubmitData)
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
      other is ProductInPackageResponseAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class BuyerDataAdapter extends TypeAdapter<BuyerData> {
  @override
  final int typeId = 22;

  @override
  BuyerData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return BuyerData(
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
      region: fields[18] as String?,
      district: fields[19] as String?,
      ward: fields[20] as String?,
      reciverFullname: fields[5] as String?,
      phoneNumberClean: fields[6] as String?,
      phoneNumber: fields[7] as String?,
      reciverAddress: fields[8] as String?,
      status: fields[17] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, BuyerData obj) {
    writer
      ..writeByte(20)
      ..writeByte(18)
      ..write(obj.region)
      ..writeByte(19)
      ..write(obj.district)
      ..writeByte(20)
      ..write(obj.ward)
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
      other is BuyerDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

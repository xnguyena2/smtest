// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'beer_submit_data.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BeerSubmitDataAdapter extends TypeAdapter<BeerSubmitData> {
  @override
  final int typeId = 2;

  @override
  BeerSubmitData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return BeerSubmitData(
      id: fields[0] as int?,
      groupId: fields[2] as String,
      createat: fields[3] as String?,
      beerSecondID: fields[4] as String,
      name: fields[5] as String,
      detail: fields[6] as String?,
      category: fields[7] as String,
      status: fields[8] as String,
      meta_search: fields[9] as String?,
      images: (fields[10] as List).cast<Images>(),
      listUnit: (fields[11] as List?)?.cast<BeerUnit>(),
      list_categorys: (fields[12] as List?)?.cast<String>(),
      unit_category_config: fields[15] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, BeerSubmitData obj) {
    writer
      ..writeByte(13)
      ..writeByte(4)
      ..write(obj.beerSecondID)
      ..writeByte(5)
      ..write(obj.name)
      ..writeByte(6)
      ..write(obj.detail)
      ..writeByte(7)
      ..write(obj.category)
      ..writeByte(8)
      ..write(obj.status)
      ..writeByte(9)
      ..write(obj.meta_search)
      ..writeByte(10)
      ..write(obj.images)
      ..writeByte(11)
      ..write(obj.listUnit)
      ..writeByte(12)
      ..write(obj.list_categorys)
      ..writeByte(15)
      ..write(obj.unit_category_config)
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
      other is BeerSubmitDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class ImagesAdapter extends TypeAdapter<Images> {
  @override
  final int typeId = 4;

  @override
  Images read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Images(
      groupId: fields[0] as String,
      createat: fields[1] as String,
      id: fields[2] as int,
      imgid: fields[3] as String,
      tag: fields[4] as String?,
      thumbnail: fields[5] as String,
      medium: fields[6] as String,
      large: fields[7] as String,
      category: fields[8] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Images obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.groupId)
      ..writeByte(1)
      ..write(obj.createat)
      ..writeByte(2)
      ..write(obj.id)
      ..writeByte(3)
      ..write(obj.imgid)
      ..writeByte(4)
      ..write(obj.tag)
      ..writeByte(5)
      ..write(obj.thumbnail)
      ..writeByte(6)
      ..write(obj.medium)
      ..writeByte(7)
      ..write(obj.large)
      ..writeByte(8)
      ..write(obj.category);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ImagesAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class BeerUnitAdapter extends TypeAdapter<BeerUnit> {
  @override
  final int typeId = 5;

  @override
  BeerUnit read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return BeerUnit(
      groupId: fields[0] as String,
      beer: fields[1] as String,
      name: fields[2] as String,
      price: fields[3] as double,
      buyPrice: fields[4] as double,
      discount: fields[5] as double,
      dateExpir: fields[6] as DateExpir?,
      volumetric: fields[7] as double,
      weight: fields[8] as double?,
      beerUnitSecondId: fields[9] as String,
      status: fields[10] as String,
      wholesale_price: fields[11] as double?,
      wholesale_number: fields[12] as int?,
      sku: fields[13] as String?,
      upc: fields[14] as String?,
      promotional_price: fields[15] as double?,
      inventory_number: fields[16] as int?,
      visible: fields[17] as bool?,
      enable_warehouse: fields[18] as bool?,
    );
  }

  @override
  void write(BinaryWriter writer, BeerUnit obj) {
    writer
      ..writeByte(19)
      ..writeByte(0)
      ..write(obj.groupId)
      ..writeByte(1)
      ..write(obj.beer)
      ..writeByte(2)
      ..write(obj.name)
      ..writeByte(3)
      ..write(obj.price)
      ..writeByte(4)
      ..write(obj.buyPrice)
      ..writeByte(5)
      ..write(obj.discount)
      ..writeByte(6)
      ..write(obj.dateExpir)
      ..writeByte(7)
      ..write(obj.volumetric)
      ..writeByte(8)
      ..write(obj.weight)
      ..writeByte(9)
      ..write(obj.beerUnitSecondId)
      ..writeByte(10)
      ..write(obj.status)
      ..writeByte(11)
      ..write(obj.wholesale_price)
      ..writeByte(12)
      ..write(obj.wholesale_number)
      ..writeByte(13)
      ..write(obj.sku)
      ..writeByte(14)
      ..write(obj.upc)
      ..writeByte(15)
      ..write(obj.promotional_price)
      ..writeByte(16)
      ..write(obj.inventory_number)
      ..writeByte(17)
      ..write(obj.visible)
      ..writeByte(18)
      ..write(obj.enable_warehouse);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BeerUnitAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class DateExpirAdapter extends TypeAdapter<DateExpir> {
  @override
  final int typeId = 6;

  @override
  DateExpir read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DateExpir(
      day: fields[0] as int,
      month: fields[1] as int,
      year: fields[2] as int,
    );
  }

  @override
  void write(BinaryWriter writer, DateExpir obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.day)
      ..writeByte(1)
      ..write(obj.month)
      ..writeByte(2)
      ..write(obj.year);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DateExpirAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

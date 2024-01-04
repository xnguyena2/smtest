// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'local_storage.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RequestStorageAdapter extends TypeAdapter<RequestStorage> {
  @override
  final int typeId = 10;

  @override
  RequestStorage read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return RequestStorage(
      type: fields[0] as RequestType,
      path: fields[1] as String,
      id: fields[2] as String,
      body: fields[3] as String,
      timeStamp: fields[4] as int,
    );
  }

  @override
  void write(BinaryWriter writer, RequestStorage obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.type)
      ..writeByte(1)
      ..write(obj.path)
      ..writeByte(2)
      ..write(obj.id)
      ..writeByte(3)
      ..write(obj.body)
      ..writeByte(4)
      ..write(obj.timeStamp);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RequestStorageAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class RequestTypeAdapter extends TypeAdapter<RequestType> {
  @override
  final int typeId = 11;

  @override
  RequestType read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return RequestType.POST_C;
      case 1:
        return RequestType.POST_E;
      case 2:
        return RequestType.DELETE_C;
      case 3:
        return RequestType.DELETE_E;
      default:
        return RequestType.POST_C;
    }
  }

  @override
  void write(BinaryWriter writer, RequestType obj) {
    switch (obj) {
      case RequestType.POST_C:
        writer.writeByte(0);
        break;
      case RequestType.POST_E:
        writer.writeByte(1);
        break;
      case RequestType.DELETE_C:
        writer.writeByte(2);
        break;
      case RequestType.DELETE_E:
        writer.writeByte(3);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RequestTypeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

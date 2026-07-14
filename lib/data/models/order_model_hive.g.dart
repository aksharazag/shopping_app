// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_model_hive.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class OrderModelHiveAdapter extends TypeAdapter<OrderModelHive> {
  @override
  final int typeId = 2;

  @override
  OrderModelHive read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return OrderModelHive(
      orderId: fields[0] as String,
      items: (fields[1] as List).cast<CartProductModel>(),
      dateTime: fields[2] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, OrderModelHive obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.orderId)
      ..writeByte(1)
      ..write(obj.items)
      ..writeByte(2)
      ..write(obj.dateTime);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OrderModelHiveAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

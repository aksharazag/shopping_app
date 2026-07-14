// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_model_hive.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ProductModelHiveAdapter extends TypeAdapter<ProductModelHive> {
  @override
  final int typeId = 0;

  @override
  ProductModelHive read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ProductModelHive(
      id: fields[0] as String,
      productName: fields[1] as String,
      price: fields[2] as double,
      description: fields[3] as String,
      category: fields[4] as String,
      brand: fields[5] as String,
      images: (fields[6] as List).cast<String>(),
      discount: fields[7] as int,
      quantity: fields[8] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, ProductModelHive obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.productName)
      ..writeByte(2)
      ..write(obj.price)
      ..writeByte(3)
      ..write(obj.description)
      ..writeByte(4)
      ..write(obj.category)
      ..writeByte(5)
      ..write(obj.brand)
      ..writeByte(6)
      ..write(obj.images)
      ..writeByte(7)
      ..write(obj.discount)
      ..writeByte(8)
      ..write(obj.quantity);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProductModelHiveAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

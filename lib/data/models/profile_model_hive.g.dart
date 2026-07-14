// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_model_hive.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ProfileModelHiveAdapter extends TypeAdapter<ProfileModelHive> {
  @override
  final int typeId = 3;

  @override
  ProfileModelHive read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ProfileModelHive(
      email: fields[0] as String,
      name: fields[1] as String,
      address: fields[2] as String,
      phone: fields[3] as String,
      pinCode: fields[4] as String,
      imagePath: fields[5] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, ProfileModelHive obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.email)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.address)
      ..writeByte(3)
      ..write(obj.phone)
      ..writeByte(4)
      ..write(obj.pinCode)
      ..writeByte(5)
      ..write(obj.imagePath);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProfileModelHiveAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contactdatabase.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ContactdbAdapter extends TypeAdapter<Contactdb> {
  @override
  final int typeId = 1;

  @override
  Contactdb read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Contactdb(
      name: fields[0] as String,
      
      phone: fields[1] as String,
      group: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Contactdb obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.phone)
      ..writeByte(2)
      ..write(obj.group);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ContactdbAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

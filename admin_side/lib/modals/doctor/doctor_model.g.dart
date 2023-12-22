// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'doctor_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DoctorModelAdapter extends TypeAdapter<DoctorModel> {
  @override
  final int typeId = 1;

  @override
  DoctorModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DoctorModel(
      name: fields[2] as String,
      image_url: fields[3] as String,
      id_hive: fields[0] as String,
      fb_id: fields[1] as String,
      category: (fields[4] as Map).cast<dynamic, dynamic>(),
      fee: fields[5] as String,
      experience: fields[6] as String,
    );
  }

  @override
  void write(BinaryWriter writer, DoctorModel obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id_hive)
      ..writeByte(1)
      ..write(obj.fb_id)
      ..writeByte(2)
      ..write(obj.name)
      ..writeByte(3)
      ..write(obj.image_url)
      ..writeByte(4)
      ..write(obj.category)
      ..writeByte(5)
      ..write(obj.fee)
      ..writeByte(6)
      ..write(obj.experience);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DoctorModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

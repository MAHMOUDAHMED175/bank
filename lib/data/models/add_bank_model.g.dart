// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_bank_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************
class AddBankModelAdapter extends TypeAdapter<AddBankModel> {
  @override
  final int typeId = 0;

  @override
  AddBankModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AddBankModel(
      bankName: fields[0] as String,
      amount: fields[1] as String,
      year: fields[2] as String,
      percent: fields[3] as String,
      finalAmount: fields[4] as String,
      amountAfterYears: fields[5] as String?,
      createAt: fields[6] != null ? DateTime.fromMillisecondsSinceEpoch(fields[6] as int) : null,
    );
  }

  @override
  void write(BinaryWriter writer, AddBankModel obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.bankName)
      ..writeByte(1)
      ..write(obj.amount)
      ..writeByte(2)
      ..write(obj.year)
      ..writeByte(3)
      ..write(obj.percent)
      ..writeByte(4)
      ..write(obj.finalAmount)
      ..writeByte(5)
      ..write(obj.amountAfterYears)
      ..writeByte(6)
      ..write(obj.createAt?.millisecondsSinceEpoch); // تحويل DateTime إلى int
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AddBankModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

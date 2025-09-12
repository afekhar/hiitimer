// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'workout_config.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TimerBlockAdapter extends TypeAdapter<TimerBlock> {
  @override
  final int typeId = 0;

  @override
  TimerBlock read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TimerBlock(
      intervals: (fields[0] as List).cast<int>(),
      rounds: fields[1] as int,
    );
  }

  @override
  void write(BinaryWriter writer, TimerBlock obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.intervals)
      ..writeByte(1)
      ..write(obj.rounds);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TimerBlockAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class WorkoutConfigAdapter extends TypeAdapter<WorkoutConfig> {
  @override
  final int typeId = 1;

  @override
  WorkoutConfig read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return WorkoutConfig(
      name: fields[0] as String,
      blocks: (fields[1] as List).cast<TimerBlock>(),
    );
  }

  @override
  void write(BinaryWriter writer, WorkoutConfig obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.blocks);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WorkoutConfigAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

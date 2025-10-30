// GENERATED CODE - DO NOT MODIFY BY HAND




part of 'mood_entry.dart';




// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************




class MoodEntryAdapter extends TypeAdapter<MoodEntry> {
 @override
 final int typeId = 0;




 @override
 MoodEntry read(BinaryReader reader) {
   final numOfFields = reader.readByte();
   final fields = <int, dynamic>{
     for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
   };
   return MoodEntry(
     mood: fields[0] as String,
     date: fields[1] as DateTime,
     note: fields[2] as String,
   );
 }




 @override
 void write(BinaryWriter writer, MoodEntry obj) {
   writer
     ..writeByte(3)
     ..writeByte(0)
     ..write(obj.mood)
     ..writeByte(1)
     ..write(obj.date)
     ..writeByte(2)
     ..write(obj.note);
 }




 @override
 int get hashCode => typeId.hashCode;




 @override
 bool operator ==(Object other) =>
     identical(this, other) ||
     other is MoodEntryAdapter &&
         runtimeType == other.runtimeType &&
         typeId == other.typeId;
}

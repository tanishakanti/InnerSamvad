import 'package:hive/hive.dart';


part 'mood_entry.g.dart';


@HiveType(typeId: 0)
class MoodEntry extends HiveObject {
  @HiveField(0)
  String mood;


  @HiveField(1)
  DateTime date;


  @HiveField(2)
  String note;


  MoodEntry({
    required this.mood,
    required this.date,
    required this.note,
  });
}

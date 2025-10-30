import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:inner_samvad/moodTracker/models/mood_entry.dart';

class MoodTrackerScreen extends StatefulWidget {
  const MoodTrackerScreen({super.key});

  @override
  State<MoodTrackerScreen> createState() => _MoodTrackerScreenState();
}

class _MoodTrackerScreenState extends State<MoodTrackerScreen>
    with TickerProviderStateMixin {
  late Box<MoodEntry> moodBox;

  String selectedMood = "Happy";
  final TextEditingController noteController = TextEditingController();
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  final Map<String, double> _moodValue = {
    "Very Sad": 1.0,
    "Sad": 2.0,
    "Neutral": 3.0,
    "Good": 4.0,
    "Happy": 5.0,
  };

  final List<String> _moodOrder = ["Very Sad", "Sad", "Neutral", "Good", "Happy"];

  final Map<String, Color> _moodColor = {
    "Very Sad": const Color(0xFFBFD7FF),
    "Sad": const Color(0xFFCADCFF),
    "Neutral": const Color(0xFFD8E4FF),
    "Good": const Color(0xFFFFE9B3),
    "Happy": const Color(0xFFFFE0A3),
  };

  final bgStart = const Color.fromARGB(255, 175, 215, 240);
  final bgEnd = const Color.fromARGB(255, 234, 240, 246);
  final cardBg = const Color(0xFFF7FAFC);

  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _selectedDay = DateTime.now();
    _tabController = TabController(length: 2, vsync: this);
    _initHive();
  }

  Future<void> _initHive() async {
    await Hive.initFlutter();
    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(MoodEntryAdapter());
    }
    moodBox = await Hive.openBox<MoodEntry>('moodBox');
    setState(() {});
  }

  void _saveMood() {
    final entry = MoodEntry(
      mood: selectedMood,
      date: DateTime.now(),
      note: noteController.text,
    );
    moodBox.add(entry);
    noteController.clear();
    setState(() {});
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Mood saved')),
    );
  }

  List<MoodEntry> _entriesForDay(DateTime day) {
    final start = DateTime(day.year, day.month, day.day);
    final end = start.add(const Duration(days: 1));
    return moodBox.values
        .where((e) =>
            e.date.isAfter(start.subtract(const Duration(milliseconds: 1))) &&
            e.date.isBefore(end))
        .toList();
  }

  Map<DateTime, List<MoodEntry>> _groupEntriesByDay() {
    final Map<DateTime, List<MoodEntry>> map = {};
    for (var e in moodBox.values) {
      final d = DateTime(e.date.year, e.date.month, e.date.day);
      map.putIfAbsent(d, () => []).add(e);
    }
    return map;
  }

  Map<String, double> _weeklyAverages() {
    final now = DateTime.now();
    final Map<String, List<double>> perDay = {};

    for (int i = 6; i >= 0; i--) {
      final day = now.subtract(Duration(days: i));
      perDay[DateFormat('EEE').format(day)] = [];
    }

    for (var e in moodBox.values) {
      final dayKey = DateFormat('EEE').format(e.date);
      if (perDay.containsKey(dayKey)) {
        perDay[dayKey]!.add(_moodValue[e.mood] ?? 3.0);
      }
    }

    final Map<String, double> result = {};
    perDay.forEach((k, v) {
      result[k] = v.isEmpty ? 0.0 : (v.reduce((a, b) => a + b) / v.length);
    });
    return result;
  }

  Map<String, int> _dailyMoodCounts(DateTime day) {
    final entries = _entriesForDay(day);
    final Map<String, int> counts = {};
    for (var mood in _moodOrder) counts[mood] = 0;
    for (var e in entries) {
      counts[e.mood] = (counts[e.mood] ?? 0) + 1;
    }
    counts.removeWhere((k, v) => v == 0);
    return counts;
  }

  List<PieChartSectionData> _buildPieSections(Map<String, int> counts) {
    final total = counts.values.fold<int>(0, (p, n) => p + n);
    if (total == 0) return [];
    final List<PieChartSectionData> sections = [];
    counts.forEach((mood, cnt) {
      final percent = cnt / total;
      sections.add(
        PieChartSectionData(
          value: cnt.toDouble(),
          radius: 50,
          color: _moodColor[mood] ?? Colors.grey,
          borderSide: const BorderSide(color: Colors.white, width: 2),
          title: _emojiFor(mood),
          titleStyle: const TextStyle(
              fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
        ),
      );
    });
    return sections;
  }

  List<FlSpot> _buildWeeklySpots(Map<String, double> weekly) {
    final keys = weekly.keys.toList();
    final List<FlSpot> spots = [];
    for (var i = 0; i < keys.length; i++) {
      final v = weekly[keys[i]] ?? 0.0;
      spots.add(FlSpot(i.toDouble(), v));
    }
    return spots;
  }

  String _timeString(DateTime dt) => DateFormat('hh:mm a').format(dt);

  String _emojiFor(String mood) {
    switch (mood) {
      case "Happy":
        return "😊";
      case "Good":
        return "🙂";
      case "Neutral":
        return "😐";
      case "Sad":
        return "😔";
      case "Very Sad":
        return "😢";
      default:
        return "🙂";
    }
  }

  @override
  Widget build(BuildContext context) {
    if (moodBox == null || !moodBox.isOpen) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    final grouped = _groupEntriesByDay();
    final dailyCounts = _dailyMoodCounts(_selectedDay ?? DateTime.now());
    final weekly = _weeklyAverages();
    final weeklySpots = _buildWeeklySpots(weekly);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mood Tracker'),
        backgroundColor: bgStart,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [bgStart, bgEnd],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Column(
            children: [
              const SizedBox(height: 12),
              const Text(
                'Log your feelings and reflect on your journey',
                style: TextStyle(fontSize: 14, color: Colors.black54),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),

              // Mood input card
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: cardBg,
                  borderRadius: BorderRadius.circular(22),
                  border: Border.all(color: Colors.blue.shade100, width: 2),
                ),
                padding: const EdgeInsets.all(18),
                child: Column(
                  children: [
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text('How are you feeling today?',
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF243B6B))),
                    ),
                    const SizedBox(height: 14),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: _moodOrder.map((m) {
                        final isSelected = selectedMood == m;
                        return GestureDetector(
                          onTap: () => setState(() => selectedMood = m),
                          child: Container(
                            padding: const EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: isSelected
                                  ? Border.all(
                                      color: Colors.blue.shade300, width: 3)
                                  : null,
                            ),
                            child: Text(
                              _emojiFor(m),
                              style: const TextStyle(fontSize: 36),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: noteController,
                      decoration: InputDecoration(
                        hintText: 'Why do you feel this way?',
                        filled: true,
                        fillColor: const Color(0xFFF7F9FC),
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 14),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none),
                      ),
                      maxLines: 2,
                    ),
                    const SizedBox(height: 14),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ElevatedButton(
                          onPressed: _saveMood,
                          style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF6B8EFF),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12))),
                          child: const Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            child: Text('Save', style: TextStyle(fontSize: 16)),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              // Tabs
              TabBar(
                controller: _tabController,
                labelColor: Colors.blueAccent,
                unselectedLabelColor: Colors.black54,
                indicatorColor: Colors.blueAccent,
                tabs: const [
                  Tab(text: 'Daily'),
                  Tab(text: 'Weekly'),
                ],
              ),

              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    // Daily tab
                    SingleChildScrollView(
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        children: [
                          // Calendar
                          Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                                color: cardBg,
                                borderRadius: BorderRadius.circular(18),
                                border: Border.all(
                                    color: Colors.blue.shade100, width: 2)),
                            padding: const EdgeInsets.all(12),
                            child: TableCalendar(
                              firstDay: DateTime.utc(2020, 1, 1),
                              lastDay: DateTime.utc(2100, 12, 31),
                              focusedDay: _focusedDay,
                              selectedDayPredicate: (day) =>
                                  isSameDay(_selectedDay, day),
                              onDaySelected: (selectedDay, focusedDay) {
                                setState(() {
                                  _selectedDay = selectedDay;
                                  _focusedDay = focusedDay;
                                });
                              },
                              calendarFormat: CalendarFormat.month,
                              headerStyle: const HeaderStyle(
                                  formatButtonVisible: false,
                                  titleCentered: true),
                              calendarBuilders: CalendarBuilders(
                                defaultBuilder: (context, day, focusedDay) {
                                  final key =
                                      DateTime(day.year, day.month, day.day);
                                  if (grouped.containsKey(key)) {
                                    return Container(
                                      margin: const EdgeInsets.all(6),
                                      decoration: BoxDecoration(
                                          color: Colors.blue.shade100,
                                          borderRadius:
                                              BorderRadius.circular(6)),
                                      child: Center(
                                          child: Text(
                                        '${day.day}',
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold),
                                      )),
                                    );
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ),

                          const SizedBox(height: 12),

                          // Daily pie chart
                          Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                                color: cardBg,
                                borderRadius: BorderRadius.circular(14),
                                border: Border.all(
                                    color: Colors.blue.shade100, width: 2)),
                            padding: const EdgeInsets.all(12),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Daily Summary (${DateFormat('EEE, MMM d').format(_selectedDay ?? DateTime.now())})',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w600),
                                ),
                                const SizedBox(height: 8),
                                if (dailyCounts.isEmpty)
                                  const Padding(
                                    padding: EdgeInsets.symmetric(vertical: 20),
                                    child: Center(
                                        child: Text('No entries for this day')),
                                  )
                                else
                                  SizedBox(
                                    height: 180,
                                    child: PieChart(
                                      PieChartData(
                                        sections: _buildPieSections(dailyCounts),
                                        sectionsSpace: 4,
                                        centerSpaceRadius: 24,
                                        borderData: FlBorderData(
                                            show: true,
                                            border: Border.all(
                                                color: Colors.blue.shade100,
                                                width: 2)),
                                      ),
                                    ),
                                  ),
                                const SizedBox(height: 8),
                                Column(
                                  children: dailyCounts.entries.map((e) {
                                    final percent = (e.value /
                                            dailyCounts.values
                                                .fold<int>(0, (p, n) => p + n) *
                                            100)
                                        .round();
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 4.0),
                                      child: Row(
                                        children: [
                                          Text(_emojiFor(e.key),
                                              style:
                                                  const TextStyle(fontSize: 18)),
                                          const SizedBox(width: 8),
                                          Text('${e.key} — ${e.value} ($percent%)'),
                                        ],
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(height: 12),

                          // Entries list
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                                color: cardBg,
                                borderRadius: BorderRadius.circular(14),
                                border: Border.all(
                                    color: Colors.blue.shade100, width: 2)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                    'Entries on ${DateFormat('EEE, MMM d, yyyy').format(_selectedDay ?? DateTime.now())}',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w600)),
                                const SizedBox(height: 8),
                                Builder(builder: (context) {
                                  final entries =
                                      _entriesForDay(_selectedDay ?? DateTime.now());
                                  if (entries.isEmpty) {
                                    return const Padding(
                                      padding: EdgeInsets.symmetric(vertical: 10),
                                      child: Text('No entries for this date'),
                                    );
                                  }
                                  entries.sort((a, b) => b.date.compareTo(a.date));
                                  return Column(
                                    children: entries.map((e) {
                                      return Container(
                                        margin:
                                            const EdgeInsets.symmetric(vertical: 6),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(12),
                                          border: Border.all(
                                              color: Colors.blue.shade100, width: 1.5),
                                          boxShadow: [
                                            BoxShadow(
                                                color:
                                                    Colors.black12.withOpacity(0.03),
                                                blurRadius: 4,
                                                offset: const Offset(0, 2))
                                          ],
                                        ),
                                        child: ListTile(
                                          leading: CircleAvatar(
                                              backgroundColor:
                                                  _moodColor[e.mood] ?? Colors.grey,
                                              child: Text(_emojiFor(e.mood))),
                                          title: Text(e.mood),
                                          subtitle: Text(e.note.isEmpty
                                              ? _timeString(e.date)
                                              : '${_timeString(e.date)} · ${e.note}'),
                                        ),
                                      );
                                    }).toList(),
                                  );
                                }),
                              ],
                            ),
                          ),
                          const SizedBox(height: 18),
                        ],
                      ),
                    ),

                    // Weekly tab
                    SingleChildScrollView(
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        children: [
                          Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                                color: cardBg,
                                borderRadius: BorderRadius.circular(14),
                                border: Border.all(
                                    color: Colors.blue.shade100, width: 2)),
                            padding: const EdgeInsets.all(12),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('Weekly Trend',
                                    style: TextStyle(fontWeight: FontWeight.w600)),
                                const SizedBox(height: 8),
                                SizedBox(
                                  height: 200,
                                  child: weeklySpots.isEmpty
                                      ? const Center(
                                          child: Text('Not enough data'),
                                        )
                                      : LineChart(
                                          LineChartData(
                                            minY: 0,
                                            maxY: 5,
                                            gridData: FlGridData(
                                                show: true, horizontalInterval: 1),
                                            titlesData: FlTitlesData(
                                              bottomTitles: AxisTitles(
                                                sideTitles: SideTitles(
                                                  showTitles: true,
                                                  getTitlesWidget: (val, meta) {
                                                    final idx = val.toInt();
                                                    final keys = weekly.keys.toList();
                                                    if (idx >= 0 &&
                                                        idx < keys.length) {
                                                      return Text(keys[idx]);
                                                    }
                                                    return const Text('');
                                                  },
                                                ),
                                              ),
                                              leftTitles: AxisTitles(
                                                sideTitles: SideTitles(
                                                    showTitles: true, interval: 1),
                                              ),
                                            ),
                                            borderData: FlBorderData(
                                                show: true,
                                                border: Border.all(
                                                    color: Colors.blue.shade100,
                                                    width: 2)),
                                            lineBarsData: [
                                              LineChartBarData(
                                                spots: weeklySpots,
                                                isCurved: true,
                                                barWidth: 4,
                                                color: Colors.blueAccent,
                                                dotData: FlDotData(show: true),
                                              ),
                                            ],
                                          ),
                                        ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

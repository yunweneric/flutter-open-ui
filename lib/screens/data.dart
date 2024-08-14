List<Condition> weather = [
  Condition(day: "today", temperature: 31),
  Condition(day: "tomorrow", temperature: 29),
  Condition(day: "monday", temperature: 7),
  Condition(day: "tuesday", temperature: 30),
  Condition(day: "wednesday", temperature: 18),
];

class Condition {
  final String day;
  final int temperature;

  Condition({required this.day, required this.temperature});
}

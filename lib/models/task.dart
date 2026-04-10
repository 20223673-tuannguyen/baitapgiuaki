class Task {
  String name;
  String time;
  String location;
  bool remind;
  String remindType;
  bool done;

  Task({
    required this.name,
    required this.time,
    required this.location,
    required this.remind,
    required this.remindType,
    this.done = false,
  });
}
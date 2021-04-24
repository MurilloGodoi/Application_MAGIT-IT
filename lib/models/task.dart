class Task {
  late int id;
  final int userId;
  late bool active;
  late bool paused;
  final String title;
  final String subtitle;
  final String housePlace;
  final DateTime assignedDate;
  late DateTime startTime;
  late DateTime endTime;
  late DateTime auxTime;
  late double totalHours;
  late String occurrence;

  Task(this.userId, this.active, this.paused, this.title, this.subtitle,
      this.housePlace, this.assignedDate);
}

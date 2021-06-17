class Task {
  late int id;
  final int userId;
  late int active;
  late int paused;
  late int initiated;
  final String title;
  final String subtitle;
  final String housePlace;
  final String assignedDate;
  final String assigedTime;
  final String imagePath;
  late String startTime;
  late String endTime;
  late String auxTime;
  late String totalHours;
  late String occurrence;

  Task(
      this.userId,
      this.active,
      this.paused,
      this.initiated,
      this.title,
      this.subtitle,
      this.housePlace,
      this.assignedDate,
      this.assigedTime,
      this.imagePath,
      this.totalHours);
}

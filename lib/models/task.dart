class Task {
  final int id;
  final int userId;
  late bool _active;
  final String title;
  final String subtitle;
  final DateTime assignedDate;
  late DateTime _startTime;
  late DateTime _endTime;

  Task(this.id, this.userId, this.title, this.subtitle, this.assignedDate,
      this._active);

  set endTime(DateTime endTime) {
    _endTime = endTime;
  }

  set startTime(DateTime startTime) {
    _startTime = startTime;
  }

  set active(bool active) {
    _active = active;
  }
}

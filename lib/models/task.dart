class Task {
  late int id;
  final int userId;
  late bool _active;
  late bool _paused;
  final String title;
  final String subtitle;
  final String housePlace;
  final DateTime assignedDate;
  late DateTime _startTime;
  late DateTime _endTime;
  late DateTime _auxTime;
  late double _totalHours;
  late String _occurrence;

  Task(this.userId, this._active, this._paused, this.title, this.subtitle,
      this.housePlace, this.assignedDate);

  set endTime(DateTime endTime) {
    _endTime = endTime;
  }

  set startTime(DateTime startTime) {
    _startTime = startTime;
  }

  set active(bool active) {
    _active = active;
  }

  set auxTime(DateTime auxTime) {
    _auxTime = auxTime;
  }

  set totalHours(double totalHours) {
    _totalHours = totalHours;
  }

  set paused(bool paused) {
    _paused = paused;
  }

  set occurrence(String occurrence) {
    _occurrence = occurrence;
  }
}

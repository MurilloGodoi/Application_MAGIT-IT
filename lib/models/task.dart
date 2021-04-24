class Task {
  final int id;
  final int userId;
  late bool _active;
  late bool _paused;
  final String title;
  final String subtitle;
  final String  housePlace;
  final DateTime assignedDate;
  late DateTime _startTime;
  late DateTime _endTime;
  late DateTime _auxTime;
  late double _totalTime;
  final String occurrence;

  Task(this.id, this.userId, this.title, this.subtitle, this.assignedDate,
      this._active, this.housePlace, this.occurrence);

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

  set totalTime(double totalTime) {
    _totalTime = totalTime;
  }

  set paused(bool paused) {
    _paused = paused;
  }
}

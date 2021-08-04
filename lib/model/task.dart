class Task {
  late String id;
  late String userId;
  late bool active;
  late bool paused;
  late bool initiated;
  late String title;
  late String subtitle;
  late String housePlace;
  late String assignedDate;
  late String assignedTime;
  late String imagePath;
  late String startTime;
  late String endTime;
  late String auxTime;
  late String totalHours;
  late String occurrence;

  Task(
    this.id,
    this.userId,
    this.active,
    this.paused,
    this.initiated,
    this.title,
    this.subtitle,
    this.housePlace,
    this.assignedDate,
    this.assignedTime,
    this.imagePath,
    this.startTime,
    this.endTime,
    this.auxTime,
    this.totalHours,
    this.occurrence,
  );

  Task.fromJson(Map<String, dynamic> map, String id) {
    this.id = id;
    this.userId = map['userId'];
    this.active = map['active'];
    this.paused = map['paused'];
    this.initiated = map['initiated'];
    this.title = map['title'];
    this.subtitle = map['subtitle'];
    this.housePlace = map['housePlace'];
    this.assignedDate = map['assignedDate'];
    this.assignedTime = map['assignedTime'];
    this.imagePath = map['imagePath'];
    this.startTime = map['startTime'];
    this.endTime = map['endTime'];
    this.auxTime = map['auxTime'];
    this.totalHours = map['totalHours'];
    this.occurrence = map['occurrence'];
  }

  //Converter um OBJETO em um DOCUMENTO
  Map<String, dynamic> toJson() {
    return {
      'id': this.id,
      'userId': this.userId,
      'active': this.active,
      'paused': this.paused,
      'initiated': this.initiated,
      'title': this.title,
      'subtitle': this.subtitle,
      'housePlace': this.housePlace,
      'assignedDate': this.assignedDate,
      'assignedTime': this.assignedTime,
      'imagePath': this.imagePath,
      'totalHours': this.totalHours,
    };
  }
}

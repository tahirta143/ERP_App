class AssignTaskStaffModel {
  final String assignid;
  final String task;
  final String staff;

  AssignTaskStaffModel({
    required this.assignid,
    required this.task,
    required this.staff,
  });

  factory AssignTaskStaffModel.fromJson(Map<String, dynamic> json) {
    return AssignTaskStaffModel(
      assignid: json['assignid'] ?? '',
      task: json['task'] ?? json['name'] ?? '',
      staff: json['staff'] ?? json['price'] ?? '',
    );
  }
}

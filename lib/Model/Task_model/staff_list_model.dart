class StaffListModel {
  final String staffId;
  final String staffName;
  final String staffAddress;
  final String staffPhone;
  final String staffEmail;
  StaffListModel({
    required this.staffId,
    required this.staffName,
    required this.staffAddress,
    required this.staffPhone,
    required this.staffEmail
});
  factory StaffListModel.fromJson(Map<String,dynamic>json)
   {
    return StaffListModel(
  staffId: json['staffId']??"",
  staffName: json['staffName']?? "",
  staffAddress: json['staffAddress']??"",
  staffPhone: json['staffPhone']?? "",
  staffEmail: json['staffEmail']??"");
  }

}
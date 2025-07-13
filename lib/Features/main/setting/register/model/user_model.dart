class UserModel {
  final int userID;
  final String userName;
  final String? password;
  final String fullUserName;
  final int? employeeID;
  final String? employeeName;
  final String? serverName;
  final String? dbName;
  final String? serverUserName;
  final String? serverPassword;
  final dynamic accessPermission;
  int? haveDiscount;
  final List<dynamic> userPermissions;

  UserModel({
    required this.userID,
    required this.userName,
    this.password,
    required this.fullUserName,
    this.employeeID,
    this.employeeName,
    this.serverName,
    this.dbName,
    this.serverUserName,
    this.serverPassword,
    this.accessPermission,
    required this.haveDiscount,
    required this.userPermissions,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      userID: json['UserID'],
      userName: json['UserName'],
      password: json['PassWord'],
      fullUserName: json['FullUserName'],
      employeeID: json['EmployeeID'],
      employeeName: json['EmployeeName'],
      serverName: json['serverName'],
      dbName: json['DBName'],
      serverUserName: json['serverUserName'],
      serverPassword: json['serverPassword'],
      accessPermission: json['AccessPermission'],
      haveDiscount: json['HaveDiscount'] ?? 1,
      userPermissions: json['UserPermissions'] ?? [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'UserID': userID,
      'UserName': userName,
      'PassWord': password,
      'FullUserName': fullUserName,
      'EmployeeID': employeeID,
      'EmployeeName': employeeName,
      'serverName': serverName,
      'DBName': dbName,
      'serverUserName': serverUserName,
      'serverPassword': serverPassword,
      'AccessPermission': accessPermission,
      'HaveDiscount': haveDiscount,
      'UserPermissions': userPermissions,
    };
  }
}

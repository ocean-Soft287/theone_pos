class CompanyModel {
  String? dbName;
  String? serverName;
  String? descriptionName;
  String? arabicDBName;
  String? englishDBName;
  String? userName;
  String? password;
  String? arabicAddress;
  String? englishAddress;
  int? numberOfPrint;
  String? fax;
  String? phone;
  String? logoImage;
  dynamic deviceConfig;
  String? signatureImage;
  String? stampImage;
  dynamic platformID;

  CompanyModel({
    this.dbName,
    this.serverName,
    this.descriptionName,
    this.arabicDBName,
    this.englishDBName,
    this.userName,
    this.password,
    this.arabicAddress,
    this.englishAddress,
    this.numberOfPrint,
    this.fax,
    this.phone,
    this.logoImage,
    this.deviceConfig,
    this.signatureImage,
    this.stampImage,
    this.platformID,
  });

  factory CompanyModel.fromJson(Map<String, dynamic> json) {
    return CompanyModel(
      dbName: json['DBName'],
      serverName: json['ServerName'],
      descriptionName: json['DescriptionName'],
      arabicDBName: json['ArabicDBName'],
      englishDBName: json['EnglishDBName'],
      userName: json['UserName'],
      password: json['Password'],
      arabicAddress: json['ArabicAddress'],
      englishAddress: json['EnglishAddress'],
      numberOfPrint: json['NumberOfPrint'],
      fax: json['Fax'],
      phone: json['Phone'],
      logoImage: json['LogoImage'],
      deviceConfig: json['DeviceConfig'],
      signatureImage: json['SignatureImage'],
      stampImage: json['StampImage'],
      platformID: json['PlatformID'],
    );
  }
}

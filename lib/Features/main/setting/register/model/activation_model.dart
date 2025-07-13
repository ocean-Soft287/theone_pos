class ActivationModel {
  String? connectionID;
  String? dBDescription;
  String? dBName;
  String? passWord;
  String? server;
  String? userName;
  String? publicKey;
  String? privateKey;
  String? authorization;
  String? lastLoginName;
  String? lastLoginPassword;
  String? basUrl;

  ActivationModel({
    this.connectionID,
    this.dBDescription,
    this.dBName,
    this.passWord,
    this.server,
    this.userName,
    this.publicKey,
    this.privateKey,
    this.authorization,
    this.lastLoginName,
    this.lastLoginPassword,
    this.basUrl,
  });

  ActivationModel.fromJson(Map<String, dynamic> json) {
    connectionID = json['ConnectionID'] ?? '';
    dBDescription = json['DBDescription'] ?? '';
    dBName = json['DBName'] ?? '';
    passWord = json['PassWord'] ?? '';
    server = json['Server'] ?? '';
    userName = json['UserName'] ?? '';
    publicKey = json['PublicKey'];
    privateKey = json['PrivateKey'] ?? '';
    authorization = json['Authorization'] ?? '';
    lastLoginName = json['LastLoginName'] ?? '';
    lastLoginPassword = json['LastLoginPassword'] ?? '';
    basUrl = json['BaseURL'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ConnectionID'] = connectionID;
    data['DBDescription'] = dBDescription;
    data['DBName'] = dBName;
    data['PassWord'] = passWord;
    data['Server'] = server;
    data['UserName'] = userName;
    data['PublicKey'] = publicKey;
    data['PrivateKey'] = privateKey;
    data['Authorization'] = authorization;
    data['LastLoginName'] = lastLoginName;
    data['LastLoginPassword'] = lastLoginPassword;
    data['BaseURL'] = basUrl;

    return data;
  }
}

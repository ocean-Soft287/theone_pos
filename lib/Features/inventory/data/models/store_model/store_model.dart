class StoreModel {
  final int id;
  final int branchId;
  final String branchName;
  final String branchEName;
  final String? brShortName;
  final String? loc;
  final String? tel;
  final String? fax;
  final int brIndex;
  final int gBr;
  final int debitAccId;
  final int creditAccId;
  final bool stoped;
  final String? acNameDebit;
  final String? acENameDebit;
  final String? acCodeCredit;
  final String? acNameCredit;
  final String? acENameCredit;

  StoreModel({
    required this.id,
    required this.branchId,
    required this.branchName,
    required this.branchEName,
    this.brShortName,
    this.loc,
    this.tel,
    this.fax,
    required this.brIndex,
    required this.gBr,
    required this.debitAccId,
    required this.creditAccId,
    required this.stoped,
    this.acNameDebit,
    this.acENameDebit,
    this.acCodeCredit,
    this.acNameCredit,
    this.acENameCredit,
  });

  factory StoreModel.fromJson(Map<String, dynamic> json) {
    return StoreModel(
      id: json['ID'],
      branchId: json['BranchID'],
      branchName: json['BranchName'],
      branchEName: json['BranchEName'],
      brShortName: json['BrShortName'],
      loc: json['Loc'],
      tel: json['Tel'],
      fax: json['Fax'],
      brIndex: json['BrIndex'],
      gBr: json['GBr'],
      debitAccId: json['DebitAccID'],
      creditAccId: json['CreditAccID'],
      stoped: json['stoped'],
      acNameDebit: json['AcName_Debit'],
      acENameDebit: json['AcEName_Debit'],
      acCodeCredit: json['AcCode_Credit'],
      acNameCredit: json['AcName_Credit'],
      acENameCredit: json['AcEName_Credit'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ID': id,
      'BranchID': branchId,
      'BranchName': branchName,
      'BranchEName': branchEName,
      'BrShortName': brShortName,
      'Loc': loc,
      'Tel': tel,
      'Fax': fax,
      'BrIndex': brIndex,
      'GBr': gBr,
      'DebitAccID': debitAccId,
      'CreditAccID': creditAccId,
      'stoped': stoped,
      'AcName_Debit': acNameDebit,
      'AcEName_Debit': acENameDebit,
      'AcCode_Credit': acCodeCredit,
      'AcName_Credit': acNameCredit,
      'AcEName_Credit': acENameCredit,
    };
  }
}
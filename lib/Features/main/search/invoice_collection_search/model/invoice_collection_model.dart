class VoucherModel {
  dynamic voucherType;
  dynamic voucherNumber;
  String? creationDateTime;
  dynamic cashAcId;
  String? cashAcCode;
  String? cashAcName;
  String? cashAcLatinName;
  double voucherValue;
  dynamic cashAcType;
  dynamic currencyId;
  String? currencyName;
  String? currencyLatinName;
  dynamic currencyIndex;
  double? currencyRate;
  String? cvNumber;
  bool isPosted;
  String? checkNumber;
  String? checkDueDate;
  String? notes;
  dynamic employeeId;
  String? employeeName;
  String? auditedBy;
  String? createdBy;
  String? postedBy;
  bool isAudited;
  dynamic postNumber;
  String? receivedFrom;
  dynamic payNo;
  String creationTime;
  bool isCanceled;
  dynamic branchId;
  dynamic entryLevel;
  bool isFromPaying;
  dynamic bankAcId;
  String? bankAcCode;
  String? bankAcName;
  String? bankAcLatinName;
  dynamic discountAcId;
  String? discountAcCode;
  String? discountAcName;
  String? discountLatinName;
  double discountValue;
  String? referenceNo;
  String? entryNature;
  String? customerPhone;
  dynamic parentAcID;
  dynamic invoiceCollecting;
  dynamic invoiceID;
  dynamic invoiceNo;
  dynamic codePW;
  String namePW;
  String eNamePW;
  String voucherName;
  String voucherEnglishName;
  double balance;
  double agreementNo;
  double keyNet;
  List<VoucherAccount> voucherAccounts;

  VoucherModel({
    required this.voucherType,
    required this.voucherNumber,
    required this.creationDateTime,
    this.cashAcId,
    this.cashAcCode,
    this.cashAcName,
    this.cashAcLatinName,
    required this.voucherValue,
    this.cashAcType,
    this.currencyId,
    this.currencyName,
    this.currencyLatinName,
    this.currencyIndex,
    this.currencyRate,
    this.cvNumber,
    required this.isPosted,
    this.checkNumber,
    required this.checkDueDate,
    this.notes,
    this.employeeId,
    this.employeeName,
    this.auditedBy,
    this.createdBy,
    this.postedBy,
    required this.isAudited,
    required this.postNumber,
    this.receivedFrom,
    required this.payNo,
    required this.creationTime,
    required this.isCanceled,
    required this.branchId,
    required this.entryLevel,
    required this.isFromPaying,
    this.bankAcId,
    this.bankAcCode,
    this.bankAcName,
    this.bankAcLatinName,
    this.discountAcId,
    this.discountAcCode,
    this.discountAcName,
    this.discountLatinName,
    required this.discountValue,
    this.referenceNo,
    this.entryNature,
    this.customerPhone,
    required this.parentAcID,
    required this.invoiceCollecting,
    required this.invoiceID,
    required this.invoiceNo,
    required this.codePW,
    required this.namePW,
    required this.eNamePW,
    required this.voucherName,
    required this.voucherEnglishName,
    required this.balance,
    required this.agreementNo,
    required this.keyNet,
    required this.voucherAccounts,
  });

  factory VoucherModel.fromJson(Map<String, dynamic> json) {
    return VoucherModel(
      voucherType: json['VoucherType'],
      voucherNumber: json['VoucherNumber'],
      creationDateTime: json['CreationDateTime'],
      cashAcId: json['CashAcId'],
      cashAcCode: json['CashAcCode'],
      cashAcName: json['CashAcName'],
      cashAcLatinName: json['CashAcLatinName'],
      voucherValue: (json['VoucherValue'] ?? 0).toDouble(),
      cashAcType: json['CashAcType'],
      currencyId: json['CurrencyId'],
      currencyName: json['CurrencyName'],
      currencyLatinName: json['CurrencyLatinName'],
      currencyIndex: json['CurrencyIndex'],
      currencyRate: (json['CurrencyRate'] ?? 0).toDouble(),
      cvNumber: json['CVNumber'],
      isPosted: json['IsPosted'],
      checkNumber: json['CheckNumber'],
      checkDueDate: json['CheckDueDate'],
      notes: json['Notes'],
      employeeId: json['EmployeeId'],
      employeeName: json['EmployeeName'],
      auditedBy: json['AuditedBy'],
      createdBy: json['CreatedBy'],
      postedBy: json['PostedBy'],
      isAudited: json['IsAudited'],
      postNumber: json['PostNumber'],
      receivedFrom: json['ReceivedFrom'],
      payNo: json['PayNO'],
      creationTime: json['CreationTime'],
      isCanceled: json['IsCanceled'],
      branchId: json['BranchId'],
      entryLevel: json['EntryLevel'],
      isFromPaying: json['IsFromPaying'],
      bankAcId: json['BankAcId'],
      bankAcCode: json['BankAcCode'],
      bankAcName: json['BankAcName'],
      bankAcLatinName: json['BankAcLatinName'],
      discountAcId: json['DiscountAcId'],
      discountAcCode: json['DiscountAcCode'],
      discountAcName: json['DiscountAcName'],
      discountLatinName: json['DiscountLatinName'],
      discountValue: (json['DiscountValue'] ?? 0).toDouble(),
      referenceNo: json['ReferenceNO'],
      entryNature: json['EntryNature'],
      customerPhone: json['CustomerPhone'],
      parentAcID: json['ParentAcID'],
      invoiceCollecting: json['InvoiceCollecting'],
      invoiceID: json['InvoiceID'],
      invoiceNo: json['InvoiceNo'],
      codePW: json['Code_PW'] ?? '',
      namePW: json['Name_PW'] ?? '',
      eNamePW: json['EName_PW'] ?? '',
      voucherName: json['VoucherName'],
      voucherEnglishName: json['VoucherEnglishName'],
      balance: (json['Balance'] ?? 0).toDouble(),
      agreementNo: (json['AgreementNo'] ?? 0).toDouble(),
      keyNet: (json['KeyNet'] ?? 0).toDouble(),
      voucherAccounts:
          (json['VoucherAccounts'] as List<dynamic>?)
              ?.map((e) => VoucherAccount.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }
}

class VoucherAccount {
  dynamic voucherType;
  dynamic voucherNumber;
  dynamic acId;
  String acCode;
  String acName;
  String acLatinName;
  dynamic acType;
  dynamic acBranchId;
  String? acBranchName;
  String? acBranchLatinName;
  dynamic number;
  double? debit;
  double? credit;
  dynamic currencyId;
  String? currencyName;
  String? currencyLatinName;
  double? currencyRate;
  String? currencySymbol;
  dynamic costCenterId;
  String? costCenterName;
  String? costCenterLatinName;
  String? notes;
  double equivalent;
  dynamic itemRowNumber;
  dynamic employeeId;
  String? employeeName;
  dynamic agreementNo;
  dynamic keyNet;
  dynamic pricesDigits;
  double entryRate;
  double entryEquivalent;
  dynamic discountAcId;
  String? discountAcName;
  String? discountAcLatinName;
  double discountAcValue;
  dynamic stoppingAccount;
  String? notes2;
  dynamic studentInstallmentId;
  String? installmentName;
  String? installmentLatinName;
  String? rowState;

  VoucherAccount({
    required this.voucherType,
    required this.voucherNumber,
    required this.acId,
    required this.acCode,
    required this.acName,
    required this.acLatinName,
    required this.acType,
    this.acBranchId,
    this.acBranchName,
    this.acBranchLatinName,
    required this.number,
    this.debit,
    this.credit,
    this.currencyId,
    this.currencyName,
    this.currencyLatinName,
    this.currencyRate,
    this.currencySymbol,
    this.costCenterId,
    this.costCenterName,
    this.costCenterLatinName,
    this.notes,
    required this.equivalent,
    required this.itemRowNumber,
    this.employeeId,
    this.employeeName,
    required this.agreementNo,
    required this.keyNet,
    this.pricesDigits,
    required this.entryRate,
    required this.entryEquivalent,
    required this.discountAcId,
    this.discountAcName,
    this.discountAcLatinName,
    required this.discountAcValue,
    required this.stoppingAccount,
    this.notes2,
    required this.studentInstallmentId,
    this.installmentName,
    this.installmentLatinName,
    this.rowState,
  });
  factory VoucherAccount.fromJson(Map<String, dynamic> json) {
    return VoucherAccount(
      voucherType: json['VoucherType'] as dynamic,
      voucherNumber: json['VoucherNumber'] as dynamic,
      acId: json['AcId'] as dynamic,
      acCode: json['AcCode'] as String,
      acName: json['AcName'] as String,
      acLatinName: json['AcLatinName'] as String,
      acType: json['AcType'] as dynamic,
      acBranchId: json['AcBranchId'] as dynamic,
      acBranchName: json['AcBranchName'] as String?,
      acBranchLatinName: json['AcBranchLatinName'] as String?,
      number: json['Number'] as dynamic,
      debit: (json['Debit'] as num?)?.toDouble(),
      credit: (json['Credit'] as num?)?.toDouble(),
      currencyId: json['CurrencyId'] as dynamic,
      currencyName: json['CurrencyName'] as String?,
      currencyLatinName: json['CurrencyLatinName'] as String?,
      currencyRate: (json['CurrencyRate'] as num?)?.toDouble(),
      currencySymbol: json['CurrencySymbol'] as String?,
      costCenterId: json['CostCenterId'] as dynamic,
      costCenterName: json['CostCenterName'] as String?,
      costCenterLatinName: json['CostCenterLatinName'] as String?,
      notes: json['Notes'] as String?,
      equivalent: (json['Equivalent'] as num).toDouble(),
      itemRowNumber: json['ItemRowNumber'] as dynamic,
      employeeId: json['EmployeeId'] as dynamic,
      employeeName: json['EmployeeName'] as String?,
      agreementNo: json['AgreementNo'] as dynamic,
      keyNet: json['KeyNet'] as dynamic,
      pricesDigits: json['PricesDigits'] as dynamic,
      entryRate: (json['EntryRate'] as num).toDouble(),
      entryEquivalent: (json['EntryEquivalent'] as num).toDouble(),
      discountAcId: json['DiscountAcId'] as dynamic,
      discountAcName: json['DiscountAcName'] as String?,
      discountAcLatinName: json['DiscountAcLatinName'] as String?,
      discountAcValue: (json['DiscountAcValue'] as num).toDouble(),
      stoppingAccount: json['StoppingAccount'] as dynamic,
      notes2: json['Notes2'] as String?,
      studentInstallmentId: json['StudentInstallmentId'] as dynamic,
      installmentName: json['InstallmentName'] as String?,
      installmentLatinName: json['InstallmentLatinName'] as String?,
      rowState: json['RowSate'] as String?,
    );
  }
}

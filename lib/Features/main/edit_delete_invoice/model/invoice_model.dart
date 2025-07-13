class InvoiceModel {
  int invoiceID;
  int invoiceNo;

  DateTime invoiceDate;
  int payingType;
  double rate;
  double totalValue;
  double finalValue;
  String? notes;
  double totalDiscount;
  double totalAddition;
  bool isPosted;
  int storeID;
  int storeCode;
  String storeName;
  String storeEnName;
  int customerID;
  String customerCode;
  String? patternArName;
  String? patternLatinName;
  String? payTypeArName;
  String? payTypeEnName;

  String customerName;
  String customerEnName;
  String? customerBranchID;
  String? brCode;
  String? brName;
  String? customerBranchEnName;
  String? costCenterID;
  String? costCenter;
  String? costCenterEnName;
  String? employeeID;
  String? employeeName;
  int materialAccountID;
  String materialAccountCode;
  String materialAccountName;
  String materialAccountEnName;
  int currencyID;
  String currencyName;
  String currencyEnName;
  int companyBranchID;
  String companyBranchCode;
  String companyBranchName;
  String companyBranchEnName;
  String createdBy;
  String creationTime;
  double remainder;
  double prePaid;
  int invoiceTypeID;
  double firstPay;
  List<SalesInvoiceItem> salesInvoiceItems;

  List<SalesInvoicePayWay> salesInvoicePayWay;

  InvoiceModel({
    required this.invoiceID,
    required this.invoiceNo,
    required this.invoiceDate,
    required this.payingType,
    required this.rate,
    required this.totalValue,
    required this.finalValue,
    this.notes,

    required this.totalDiscount,
    required this.totalAddition,
    required this.isPosted,
    required this.storeID,
    required this.storeCode,
    required this.storeName,
    required this.storeEnName,
    required this.customerID,
    required this.customerCode,
    required this.customerName,
    required this.customerEnName,
    this.patternArName,
    this.patternLatinName,
    this.payTypeArName,
    this.payTypeEnName,
    this.customerBranchID,
    this.brCode,
    this.brName,
    this.customerBranchEnName,
    this.costCenterID,
    this.costCenter,
    this.costCenterEnName,
    this.employeeID,
    this.employeeName,
    required this.materialAccountID,
    required this.materialAccountCode,
    required this.materialAccountName,
    required this.materialAccountEnName,
    required this.currencyID,
    required this.currencyName,
    required this.currencyEnName,
    required this.companyBranchID,
    required this.companyBranchCode,
    required this.companyBranchName,
    required this.companyBranchEnName,
    required this.createdBy,
    required this.creationTime,
    required this.remainder,
    required this.prePaid,
    required this.invoiceTypeID,
    required this.firstPay,
    required this.salesInvoiceItems,
    required this.salesInvoicePayWay,
  });

  factory InvoiceModel.fromJson(Map<String, dynamic> json) {
    return InvoiceModel(
      invoiceID: json['InvoiceID'],
      invoiceNo: json['InvoiceNo'],
      invoiceDate: DateTime.parse(json['InvoiceDate']),
      payingType: json['PayingType'],
      payTypeArName: json['PayTypeArName'] ?? '',
      payTypeEnName: json['PayTypeEnName'] ?? '',
      patternLatinName: json['PatternLatinName'] ?? '',
      patternArName: json['PatternArName'] ?? '',

      rate: json['Rate'],
      totalValue: json['TotalValue'],
      finalValue: json['FinalValue'],

      notes: json['Notes'],
      totalDiscount: json['TotalDiscount'],
      totalAddition: json['TotalAddition'],
      isPosted: json['IsPosted'],
      storeID: json['StoreID'],
      storeCode: json['StoreCode'],
      storeName: json['StoreName'],
      storeEnName: json['StoreEnName'],
      customerID: json['CustomerID'],
      customerCode: json['CustomerCode'],
      customerName: json['CustomerName'],
      customerEnName: json['CustomerEnName'],
      customerBranchID: json['CustomerBranchID'],
      brCode: json['BrCode'],
      brName: json['BrName'],
      customerBranchEnName: json['CustomerBranchEnName'],
      costCenterID: json['CostCenterID'],
      costCenter: json['CostCenter'],
      costCenterEnName: json['CostCenterEnName'],
      employeeID: json['EmployeeID'],
      employeeName: json['EmployeeName'],
      materialAccountID: json['MaterialAccountID'],
      materialAccountCode: json['MaterialAccountCode'],
      materialAccountName: json['MaterialAccountName'],
      materialAccountEnName: json['MaterialAccountEnName'],
      currencyID: json['CurrencyID'],
      currencyName: json['CurrencyName'],
      currencyEnName: json['CurrencyEnName'],
      companyBranchID: json['CompanyBranchID'],
      companyBranchCode: json['CompanyBranchCode'],
      companyBranchName: json['CompanyBranchName'],
      companyBranchEnName: json['CompanyBranchEnName'],
      createdBy: json['CreatedBy'],
      creationTime: json['CreationTime'],
      remainder: json['Remainder'],
      prePaid: json['PrePaid'],
      invoiceTypeID: json['InvoiceTypeID'],
      firstPay: json['FirstPay'],
      salesInvoiceItems: List<SalesInvoiceItem>.from(
        json['SalesInvoiceItems'].map(
          (x) => SalesInvoiceItem.fromJson(Map<String, dynamic>.from(x)),
        ),
      ),
      salesInvoicePayWay: List<SalesInvoicePayWay>.from(
        json['SalesInvoicePayWays'].map(
          (x) => SalesInvoicePayWay.fromJson(Map<String, dynamic>.from(x)),
        ),
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'InvoiceID': invoiceID,
      'InvoiceNo': invoiceNo,
      'InvoiceDate': invoiceDate.toIso8601String(),
      'PayingType': payingType,
      'Rate': rate,
      'TotalValue': totalValue,
      'FinalValue': finalValue,
      'Notes': notes,
      'TotalDiscount': totalDiscount,
      'TotalAddition': totalAddition,
      'IsPosted': isPosted,
      'StoreID': storeID,
      'StoreCode': storeCode,
      'StoreName': storeName,
      'StoreEnName': storeEnName,
      'CustomerID': customerID,
      'CustomerCode': customerCode,
      'CustomerName': customerName,
      'CustomerEnName': customerEnName,
      'CustomerBranchID': customerBranchID,
      'BrCode': brCode,
      'BrName': brName,
      'CustomerBranchEnName': customerBranchEnName,
      'CostCenterID': costCenterID,
      'CostCenter': costCenter,
      'CostCenterEnName': costCenterEnName,
      'EmployeeID': employeeID,
      'EmployeeName': employeeName,
      'MaterialAccountID': materialAccountID,
      'MaterialAccountCode': materialAccountCode,
      'MaterialAccountName': materialAccountName,
      'MaterialAccountEnName': materialAccountEnName,
      'CurrencyID': currencyID,
      'CurrencyName': currencyName,
      'CurrencyEnName': currencyEnName,
      'CompanyBranchID': companyBranchID,
      'CompanyBranchCode': companyBranchCode,
      'CompanyBranchName': companyBranchName,
      'CompanyBranchEnName': companyBranchEnName,
      'CreatedBy': createdBy,
      'CreationTime': creationTime,
      'Remainder': remainder,
      'PrePaid': prePaid,
      'InvoiceTypeID': invoiceTypeID,
      'FirstPay': firstPay,
      'SalesInvoiceItems': salesInvoiceItems.map((x) => x.toJson()).toList(),
    };
  }
}

class SalesInvoiceItem {
  int invoiceNo;
  int invoiceID;
  int productID;
  double quantity;
  double price;
  double totalValue;
  double discount;
  String? notes;
  String? productionDate;
  String? expireDate;
  double gifts;
  int unitID;
  double discountPercent;
  double additionVal;
  double additionPercent;
  int ident;
  String? costCenterName;
  String? costCenterEnName;
  int? costCenterID;
  String? costCenterCode;
  String productCode;
  String productArName;
  String productEnName;
  String unitName;
  String unitEName;
  String storeName;
  String storeEnName;
  double productCost;
  int rowNumber;
  int storeID;
  String? productNotes;
  bool serialInput;
  bool serialOutput;
  String? salesAccountID;
  String? salesReturnAcID;
  String? purchaseAccountID;
  String? purchaseReturnAccountID;
  String? receivedQty;
  String? tax;
  bool isDelivering;
  double deliveringQty;
  double deliveredQty;
  bool isCollectiveItemSon;
  String? purchaseOrderID;
  String? purchaseOrderNo;
  String? purchaseOrderProductNumber;
  String? productLength;
  String? productWidth;
  String? productCount;
  String? salePrice;
  String? productColor;
  String? newProductName;
  double? percentExtraPrice;
  String? importInvoiceID;
  String? importInvoiceNo;
  String? importInvoiceNumber;
  bool keepLastPrice;
  String? notes1;
  String? notes2;
  bool fromBill;
  String? salesManID;
  String? secondCurrencyPrice;
  String? rowSate;
  String? salesInvoice;

  SalesInvoiceItem({
    required this.invoiceNo,
    required this.invoiceID,
    required this.productID,
    required this.quantity,
    required this.price,
    required this.totalValue,
    required this.discount,
    this.notes,
    this.productionDate,
    this.expireDate,
    required this.gifts,
    required this.unitID,
    required this.discountPercent,
    required this.additionVal,
    required this.additionPercent,
    required this.ident,
    this.costCenterName,
    this.costCenterEnName,
    this.costCenterID,
    this.costCenterCode,
    required this.productCode,
    required this.productArName,
    required this.productEnName,
    required this.unitName,
    required this.unitEName,
    required this.storeName,
    required this.storeEnName,
    required this.productCost,
    required this.rowNumber,
    required this.storeID,
    this.productNotes,
    required this.serialInput,
    required this.serialOutput,
    this.salesAccountID,
    this.salesReturnAcID,
    this.purchaseAccountID,
    this.purchaseReturnAccountID,
    this.receivedQty,
    this.tax,
    required this.isDelivering,
    required this.deliveringQty,
    required this.deliveredQty,
    required this.isCollectiveItemSon,
    this.purchaseOrderID,
    this.purchaseOrderNo,
    this.purchaseOrderProductNumber,
    this.productLength,
    this.productWidth,
    this.productCount,
    this.salePrice,
    this.productColor,
    this.newProductName,
    this.percentExtraPrice,
    this.importInvoiceID,
    this.importInvoiceNo,
    this.importInvoiceNumber,
    required this.keepLastPrice,
    this.notes1,
    this.notes2,
    required this.fromBill,
    this.salesManID,
    this.secondCurrencyPrice,
    this.rowSate,
    this.salesInvoice,
  });

  factory SalesInvoiceItem.fromJson(Map<String, dynamic> json) {
    return SalesInvoiceItem(
      invoiceNo: json['InvoiceNo'] ?? 0,
      invoiceID: json['InvoiceID'] ?? 0,
      productID: json['ProductID'] ?? 0,
      quantity: (json['Quantity'] ?? 0.0).toDouble(),
      price: (json['Price'] ?? 0.0).toDouble(),
      totalValue: (json['TotalValue'] ?? 0.0).toDouble(),
      discount: (json['Discount'] ?? 0.0).toDouble(),
      notes: json['Notes'],
      productionDate: json['ProductionDate'],
      expireDate: json['ExpireDate'],
      gifts: (json['Gifts'] ?? 0.0).toDouble(),
      unitID: json['UnitID'] ?? 0,
      discountPercent: (json['DiscountPercent'] ?? 0.0).toDouble(),
      additionVal: (json['AdditionVal'] ?? 0.0).toDouble(),
      additionPercent: (json['AdditionPercent'] ?? 0.0).toDouble(),
      ident: json['Ident'] ?? 0,
      costCenterName: json['CostCenterName'],
      costCenterEnName: json['CostCenterEnName'],
      costCenterID: json['CostCenterID'],
      costCenterCode: json['CostCenterCode'],
      productCode: json['ProductCode'] ?? '',
      productArName: json['ProductArName'] ?? '',
      productEnName: json['ProductEnName'] ?? '',
      unitName: json['UnitName'] ?? '',
      unitEName: json['UnitEName'] ?? '',
      storeName: json['StoreName'] ?? '',
      storeEnName: json['StoreEnName'] ?? '',
      productCost: (json['ProductCost'] ?? 0.0).toDouble(),
      rowNumber: json['RowNumber'] ?? 0,
      storeID: json['StoreID'] ?? 0,
      productNotes: json['ProductNotes'],
      serialInput: json['SerialInput'] ?? false,
      serialOutput: json['SerialOutput'] ?? false,
      salesAccountID: json['SalesAccountID'],
      salesReturnAcID: json['SalesReturnAcID'],
      purchaseAccountID: json['PurchaseAccountID'],
      purchaseReturnAccountID: json['PurchaseReturnAccountID'],
      receivedQty: json['ReceivedQty'],
      tax: json['Tax'],
      isDelivering: json['IsDelivering'] ?? false,
      deliveringQty: (json['DeliveringQty'] ?? 0.0).toDouble(),
      deliveredQty: (json['DeliveredQty'] ?? 0.0).toDouble(),
      isCollectiveItemSon: json['IsCollectiveItemSon'] ?? false,
      purchaseOrderID: json['PurchaseOrderID'],
      purchaseOrderNo: json['PurchaseOrderNo'],
      purchaseOrderProductNumber: json['PurchaseOrderProductNumber'],
      productLength: json['ProductLength'],
      productWidth: json['ProductWidth'],
      productCount: json['ProductCount'],
      salePrice: json['SalePrice'],
      productColor: json['ProductColor'],
      newProductName: json['NewProductName'],
      percentExtraPrice: (json['PercentExtraPrice'] ?? 0.0).toDouble(),
      importInvoiceID: json['ImportInvoiceID'],
      importInvoiceNo: json['ImportInvoiceNo'],
      importInvoiceNumber: json['ImportInvoiceNumber'],
      keepLastPrice: json['KeepLastPrice'] ?? false,
      notes1: json['Notes1'],
      notes2: json['Notes2'],
      fromBill: json['FromBill'] ?? false,
      salesManID: json['SalesManID'],
      secondCurrencyPrice: json['SecondCurrencyPrice'],
      rowSate: json['RowSate'],
      salesInvoice: json['SalesInvoice'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'InvoiceNo': invoiceNo,
      'InvoiceID': invoiceID,
      'ProductID': productID,
      'Quantity': quantity,
      'Price': price,
      'TotalValue': totalValue,
      'Discount': discount,
      'Notes': notes,
      'ProductionDate': productionDate,
      'ExpireDate': expireDate,
      'Gifts': gifts,
      'UnitID': unitID,
      'DiscountPercent': discountPercent,
      'AdditionVal': additionVal,
      'AdditionPercent': additionPercent,
      'Ident': ident,
      'CostCenterName': costCenterName,
      'CostCenterEnName': costCenterEnName,
      'CostCenterID': costCenterID,
      'CostCenterCode': costCenterCode,
      'ProductCode': productCode,
      'ProductArName': productArName,
      'ProductEnName': productEnName,
      'UnitName': unitName,
      'UnitEName': unitEName,
      'StoreName': storeName,
      'StoreEnName': storeEnName,
      'ProductCost': productCost,
      'RowNumber': rowNumber,
      'StoreID': storeID,
      'ProductNotes': productNotes,
      'SerialInput': serialInput,
      'SerialOutput': serialOutput,
      'SalesAccountID': salesAccountID,
      'SalesReturnAcID': salesReturnAcID,
      'PurchaseAccountID': purchaseAccountID,
      'PurchaseReturnAccountID': purchaseReturnAccountID,
      'ReceivedQty': receivedQty,
      'Tax': tax,
      'IsDelivering': isDelivering,
      'DeliveringQty': deliveringQty,
      'DeliveredQty': deliveredQty,
      'IsCollectiveItemSon': isCollectiveItemSon,
      'PurchaseOrderID': purchaseOrderID,
      'PurchaseOrderNo': purchaseOrderNo,
      'PurchaseOrderProductNumber': purchaseOrderProductNumber,
      'ProductLength': productLength,
      'ProductWidth': productWidth,
      'ProductCount': productCount,
      'SalePrice': salePrice,
      'ProductColor': productColor,
      'NewProductName': newProductName,
      'PercentExtraPrice': percentExtraPrice,
      'ImportInvoiceID': importInvoiceID,
      'ImportInvoiceNo': importInvoiceNo,
      'ImportInvoiceNumber': importInvoiceNumber,
      'KeepLastPrice': keepLastPrice,
      'Notes1': notes1,
      'Notes2': notes2,
      'FromBill': fromBill,
      'SalesManID': salesManID,
      'SecondCurrencyPrice': secondCurrencyPrice,
      'RowSate': rowSate,
      'SalesInvoice': salesInvoice,
    };
  }
}

class SalesInvoicePayWay {
  final int invoiceID;
  final int invoiceNo;
  final int payWayNO;
  final int payingType;
  final double payingValue;
  final String? referenceNo;
  final int accountID;
  final int currencyID;
  final double rate;
  final double localValue;
  final double equivalent;
  final String payWayName;
  final String payWayEnName;
  final dynamic salesInvoice;

  SalesInvoicePayWay({
    required this.invoiceID,
    required this.invoiceNo,
    required this.payWayNO,
    required this.payingType,
    required this.payingValue,
    this.referenceNo,
    required this.accountID,
    required this.currencyID,
    required this.rate,
    required this.localValue,
    required this.equivalent,
    required this.payWayName,
    required this.payWayEnName,
    this.salesInvoice,
  });

  factory SalesInvoicePayWay.fromJson(Map<String, dynamic> json) {
    return SalesInvoicePayWay(
      invoiceID: json['InvoiceID'],
      invoiceNo: json['InvoiceNo'],
      payWayNO: json['PayWayNO'],
      payingType: json['PayingType'],
      payingValue: json['PayingValue'].toDouble(),
      referenceNo: json['ReferenceNo'],
      accountID: json['AccountID'],
      currencyID: json['CurrencyID'],
      rate: json['Rate'].toDouble(),
      localValue: json['LocalValue'].toDouble(),
      equivalent: json['Equivalent'].toDouble(),
      payWayName: json['PayWayName'],
      payWayEnName: json['PayWayEnName'],
      salesInvoice: json['SalesInvoice'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'InvoiceID': invoiceID,
      'InvoiceNo': invoiceNo,
      'PayWayNO': payWayNO,
      'PayingType': payingType,
      'PayingValue': payingValue,
      'ReferenceNo': referenceNo,
      'AccountID': accountID,
      'CurrencyID': currencyID,
      'Rate': rate,
      'LocalValue': localValue,
      'Equivalent': equivalent,
      'PayWayName': payWayName,
      'PayWayEnName': payWayEnName,
      'SalesInvoice': salesInvoice,
    };
  }
}

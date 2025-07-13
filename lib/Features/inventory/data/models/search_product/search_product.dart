class SearchProductModel {
  final String? productCode;
  final String? barCode;
  final int? colorID;
  final String? colorArName;
  final String? colorEnName;
  final int? sizeID;
  final String? sizeName;
  final String? sizeEName;
  final String? productArName;
  final String? productEnName;
  final String? categoryId;
  final String? categoryCode;
  final String? categoryArName;
  final String? categoryEnName;
  final int? departmentId;
  final String? departmentArName;
  final String? departmentEnName;
  final int? descriptionID;
  final String? descriptionArName;
  final String? descriptionEnName;
  final int? seasonID;
  final String? seasonArName;
  final String? seasonEnName;
  final dynamic brandID;
  final String? brandArName;
  final String? brandEnName;
  final int? countryID;
  final String? countryArName;
  final String? countryEnName;
  final int? patternId;
  final String? patternArName;
  final String? patternEnName;
  final double? stockQuantity;
  final double? price;
  final double? priceAfterDiscount;
  final double? wholePrice;
  final double? halfWholePrice;
  final double? salePrice;
  final double? lastBuyPrice;
  final double? localCost;
  final dynamic exportPrice;
  final dynamic retailPrice;
  final String? specification;
  final int? productID;
  final double? priceUnit2;
  final double? wholePriceUnit2;
  final double? halfWholePriceUnit2;
  final double? salePriceUnit2;
  final double? lastBuyPriceUnit2;
  final dynamic exportPriceUnit2;
  final dynamic retailPriceUnit2;
  final double? priceUnit3;
  final double? wholePriceUnit3;
  final double? halfWholePriceUnit3;
  final double? salePriceUnit3;
  final double? lastBuyPriceUnit3;
  final dynamic exportPriceUnit3;
  final dynamic retailPriceUnit3;
  final int? discountPercent;
  final dynamic commissionValue;
  final dynamic commissionPercent;
  final String? specifications;
  final int? modelNo;
  final int? modelArName;
  final int? modelEnName;
  final int? supplierID;
  final String? supplierArName;
  final String? supplierEnName;
  final int? unitID1;
  final String? unit1ArName;
  final String? unit1EnName;
  final String? barcodeUnit1;
  final int? unitID2;
  final dynamic unit2Factor;
  final String? unit2ArName;
  final String? unit2EnName;
  final String? barcodeUnit2;
  final int? unitID3;
  final dynamic unit3Factor;
  final String? unit3ArName;
  final String? unit3EnName;
  final String? barcodeUnit3;
  final int? unitID4;
  final dynamic unit4Factor;
  final String? unit4ArName;
  final String? unit4EnName;
  final String? barcodeUnit4;
  final dynamic productWeight;
  final dynamic unit1points;
  final dynamic unit2points;
  final dynamic unit3points;
  final dynamic unit4points;
  final dynamic maxQtyLimt;
  final dynamic minQtyLimit;
  final dynamic priceUnit4;
  final dynamic wholePriceUnit4;
  final dynamic halfWholePriceUnit4;
  final dynamic salePriceUnit4;
  final dynamic lastBuyPriceUnit4;
  final dynamic exportPriceUnit4;
  final dynamic retailPriceUnit4;
  final int? producedProduct;
  final String? productPeiceNo;
  final bool? isWeighingProduct;
  final int? productionDateProduct;
  final int? expiredDateProduct;
  final int? defaultUnitNumber;
  final bool? branchesProduct;
  final dynamic additionalRate;
  final dynamic priceAddRatio;
  final dynamic taxesRate;
  final bool? serialInput;
  final bool? serialOutput;
  final int? priceEdit;
  final dynamic registerationDate;
  final int? stoppingProduct;
  final bool? isPureCostProduct;
  final bool? invisibleProduct;
  final int? productType;
  final int? productclassifyID;
  final String? productclassifyName;
  final String? productclassifyEnName;
  final int? createdBy;
  final String? productcImage;
  final int? isFavorite;
  final double? customerQuantity;
  final double? totalQuantity;
  final dynamic fromDate;
  final dynamic toDate;
  final double? soldQuantity;
  final double? remainQuantity;
  final int? requiredQTY;
  final int? giftQTY;
  final int? yGiftQty;
  final String? description1;
  final String? description2;
  final String? description3;
  final String? description4;
  final String? description5;
  final String? description6;
  final String? description7;
  final String? description8;
  final String? description9;
  final String? description10;
  final dynamic numOfPages;
  final String? defaultUnitArName;
  final String? defaultUnitEnName;
  final int? showGroup;
  final String? description11;
  final String? description12;
  final String? description13;
  final String? description14;
  final String? description15;
  final String? description16;
  final String? description17;
  final String? description18;
  final String? description19;
  final String? description20;
  final int? orderUnitID;
  final String? orderUnitName;
  final String? orderUnitEName;
  final dynamic unitEndUser;
  final dynamic unitDiscRate;
  final double? customerQtyFree;
  final double? totalQtyFree;
  final int? unitValue;
  final List<dynamic>? productColorsSizes;
  final List<dynamic>? productUnitsandPrices;
  final List<dynamic>? productImages;

  SearchProductModel({
    this.productCode,
    this.barCode,
    this.colorID,
    this.colorArName,
    this.colorEnName,
    this.sizeID,
    this.sizeName,
    this.sizeEName,
    this.productArName,
    this.productEnName,
    this.categoryId,
    this.categoryCode,
    this.categoryArName,
    this.categoryEnName,
    this.departmentId,
    this.departmentArName,
    this.departmentEnName,
    this.descriptionID,
    this.descriptionArName,
    this.descriptionEnName,
    this.seasonID,
    this.seasonArName,
    this.seasonEnName,
    this.brandID,
    this.brandArName,
    this.brandEnName,
    this.countryID,
    this.countryArName,
    this.countryEnName,
    this.patternId,
    this.patternArName,
    this.patternEnName,
    this.stockQuantity,
    this.price,
    this.priceAfterDiscount,
    this.wholePrice,
    this.halfWholePrice,
    this.salePrice,
    this.lastBuyPrice,
    this.localCost,
    this.exportPrice,
    this.retailPrice,
    this.specification,
    this.productID,
    this.priceUnit2,
    this.wholePriceUnit2,
    this.halfWholePriceUnit2,
    this.salePriceUnit2,
    this.lastBuyPriceUnit2,
    this.exportPriceUnit2,
    this.retailPriceUnit2,
    this.priceUnit3,
    this.wholePriceUnit3,
    this.halfWholePriceUnit3,
    this.salePriceUnit3,
    this.lastBuyPriceUnit3,
    this.exportPriceUnit3,
    this.retailPriceUnit3,
    this.discountPercent,
    this.commissionValue,
    this.commissionPercent,
    this.specifications,
    this.modelNo,
    this.modelArName,
    this.modelEnName,
    this.supplierID,
    this.supplierArName,
    this.supplierEnName,
    this.unitID1,
    this.unit1ArName,
    this.unit1EnName,
    this.barcodeUnit1,
    this.unitID2,
    this.unit2Factor,
    this.unit2ArName,
    this.unit2EnName,
    this.barcodeUnit2,
    this.unitID3,
    this.unit3Factor,
    this.unit3ArName,
    this.unit3EnName,
    this.barcodeUnit3,
    this.unitID4,
    this.unit4Factor,
    this.unit4ArName,
    this.unit4EnName,
    this.barcodeUnit4,
    this.productWeight,
    this.unit1points,
    this.unit2points,
    this.unit3points,
    this.unit4points,
    this.maxQtyLimt,
    this.minQtyLimit,
    this.priceUnit4,
    this.wholePriceUnit4,
    this.halfWholePriceUnit4,
    this.salePriceUnit4,
    this.lastBuyPriceUnit4,
    this.exportPriceUnit4,
    this.retailPriceUnit4,
    this.producedProduct,
    this.productPeiceNo,
    this.isWeighingProduct,
    this.productionDateProduct,
    this.expiredDateProduct,
    this.defaultUnitNumber,
    this.branchesProduct,
    this.additionalRate,
    this.priceAddRatio,
    this.taxesRate,
    this.serialInput,
    this.serialOutput,
    this.priceEdit,
    this.registerationDate,
    this.stoppingProduct,
    this.isPureCostProduct,
    this.invisibleProduct,
    this.productType,
    this.productclassifyID,
    this.productclassifyName,
    this.productclassifyEnName,
    this.createdBy,
    this.productcImage,
    this.isFavorite,
    this.customerQuantity,
    this.totalQuantity,
    this.fromDate,
    this.toDate,
    this.soldQuantity,
    this.remainQuantity,
    this.requiredQTY,
    this.giftQTY,
    this.yGiftQty,
    this.description1,
    this.description2,
    this.description3,
    this.description4,
    this.description5,
    this.description6,
    this.description7,
    this.description8,
    this.description9,
    this.description10,
    this.numOfPages,
    this.defaultUnitArName,
    this.defaultUnitEnName,
    this.showGroup,
    this.description11,
    this.description12,
    this.description13,
    this.description14,
    this.description15,
    this.description16,
    this.description17,
    this.description18,
    this.description19,
    this.description20,
    this.orderUnitID,
    this.orderUnitName,
    this.orderUnitEName,
    this.unitEndUser,
    this.unitDiscRate,
    this.customerQtyFree,
    this.totalQtyFree,
    this.unitValue,
    this.productColorsSizes,
    this.productUnitsandPrices,
    this.productImages,
  });

  factory SearchProductModel.fromJson(Map<String, dynamic> json) {
    return SearchProductModel(
      productCode: json['ProductCode'] as String?,
      barCode: json['BarCode'] as String?,
      colorID: json['ColorID'] as int?,
      colorArName: json['ColorArName'] as String?,
      colorEnName: json['ColorEnName'] as String?,
      sizeID: json['SizeID'] as int?,
      sizeName: json['SizeName'] as String?,
      sizeEName: json['SizeEName'] as String?,
      productArName: json['ProductArName'] as String?,
      productEnName: json['ProductEnName'] as String?,
      categoryId: json['CategoryId'] as String?,
      categoryCode: json['CategoryCode'] as String?,
      categoryArName: json['CategoryArName'] as String?,
      categoryEnName: json['CategoryEnName'] as String?,
      departmentId: json['DepartmentId'] as int?,
      departmentArName: json['DepartmentArName'] as String?,
      departmentEnName: json['DepartmentEnName'] as String?,
      descriptionID: json['DescriptionID'] as int?,
      descriptionArName: json['DescriptionArName'] as String?,
      descriptionEnName: json['DescriptionEnName'] as String?,
      seasonID: json['SeasonID'] as int?,
      seasonArName: json['SeasonArName'] as String?,
      seasonEnName: json['SeasonEnName'] as String?,
      brandID: json['BrandID'],
      brandArName: json['BrandArName'] as String?,
      brandEnName: json['BrandEnName'] as String?,
      countryID: json['CountryID'] as int?,
      countryArName: json['CountryArName'] as String?,
      countryEnName: json['CountryEnName'] as String?,
      patternId: json['PatternId'] as int?,
      patternArName: json['PatternArName'] as String?,
      patternEnName: json['PatternEnName'] as String?,
      stockQuantity: (json['StockQuantity'] as num?)?.toDouble(),
      price: (json['Price'] as num?)?.toDouble(),
      priceAfterDiscount: (json['PriceAfterDiscount'] as num?)?.toDouble(),
      wholePrice: (json['WholePrice'] as num?)?.toDouble(),
      halfWholePrice: (json['HalfWholePrice'] as num?)?.toDouble(),
      salePrice: (json['SalePrice'] as num?)?.toDouble(),
      lastBuyPrice: (json['LastBuyPrice'] as num?)?.toDouble(),
      localCost: (json['LocalCost'] as num?)?.toDouble(),
      exportPrice: json['ExportPrice'],
      retailPrice: json['RetailPrice'],
      specification: json['Specification'] as String?,
      productID: json['ProductID'] as int?,
      priceUnit2: (json['PriceUnit2'] as num?)?.toDouble(),
      wholePriceUnit2: (json['WholePriceUnit2'] as num?)?.toDouble(),
      halfWholePriceUnit2: (json['HalfWholePriceUnit2'] as num?)?.toDouble(),
      salePriceUnit2: (json['SalePriceUnit2'] as num?)?.toDouble(),
      lastBuyPriceUnit2: (json['LastBuyPriceUnit2'] as num?)?.toDouble(),
      exportPriceUnit2: json['ExportPriceUnit2'],
      retailPriceUnit2: json['RetailPriceUnit2'],
      priceUnit3: (json['PriceUnit3'] as num?)?.toDouble(),
      wholePriceUnit3: (json['WholePriceUnit3'] as num?)?.toDouble(),
      halfWholePriceUnit3: (json['HalfWholePriceUnit3'] as num?)?.toDouble(),
      salePriceUnit3: (json['SalePriceUnit3'] as num?)?.toDouble(),
      lastBuyPriceUnit3: (json['LastBuyPriceUnit3'] as num?)?.toDouble(),
      exportPriceUnit3: json['ExportPriceUnit3'],
      retailPriceUnit3: json['RetailPriceUnit3'],
      discountPercent: json['DiscountPercent'] as int?,
      commissionValue: json['CommissionValue'],
      commissionPercent: json['CommissionPercent'],
      specifications: json['Specifications'] as String?,
      modelNo: json['ModelNo'] as int?,
      modelArName: json['ModelArName'] as int?,
      modelEnName: json['ModelEnName'] as int?,
      supplierID: json['SupplierID'] as int?,
      supplierArName: json['SupplierArName'] as String?,
      supplierEnName: json['SupplierEnName'] as String?,
      unitID1: json['UnitID1'] as int?,
      unit1ArName: json['Unit1ArName'] as String?,
      unit1EnName: json['Unit1EnName'] as String?,
      barcodeUnit1: json['BarcodeUnit1'] as String?,
      unitID2: json['UnitID2'] as int?,
      unit2Factor: json['Unit2Factor'],
      unit2ArName: json['Unit2ArName'] as String?,
      unit2EnName: json['Unit2EnName'] as String?,
      barcodeUnit2: json['BarcodeUnit2'] as String?,
      unitID3: json['UnitID3'] as int?,
      unit3Factor: json['Unit3Factor'],
      unit3ArName: json['Unit3ArName'] as String?,
      unit3EnName: json['Unit3EnName'] as String?,
      barcodeUnit3: json['BarcodeUnit3'] as String?,
      unitID4: json['UnitID4'] as int?,
      unit4Factor: json['Unit4Factor'],
      unit4ArName: json['Unit4ArName'] as String?,
      unit4EnName: json['Unit4EnName'] as String?,
      barcodeUnit4: json['BarcodeUnit4'] as String?,
      productWeight: json['ProductWeight'],
      unit1points: json['Unit1points'],
      unit2points: json['Unit2points'],
      unit3points: json['Unit3points'],
      unit4points: json['Unit4points'],
      maxQtyLimt: json['MaxQtyLimt'],
      minQtyLimit: json['MinQtyLimit'],
      priceUnit4: (json['PriceUnit4'] as num?)?.toDouble(),
      wholePriceUnit4: (json['WholePriceUnit4'] as num?)?.toDouble(),
      halfWholePriceUnit4: (json['HalfWholePriceUnit4'] as num?)?.toDouble(),
      salePriceUnit4: (json['SalePriceUnit4'] as num?)?.toDouble(),
      lastBuyPriceUnit4: (json['LastBuyPriceUnit4'] as num?)?.toDouble(),
      exportPriceUnit4: json['ExportPriceUnit4'],
      retailPriceUnit4: json['RetailPriceUnit4'],
      producedProduct: json['producedProduct'] as int?,
      productPeiceNo: json['ProductPeiceNo'] as String?,
      isWeighingProduct: json['IsWeighingProduct'] as bool?,
      productionDateProduct: json['ProductionDateProduct'] as int?,
      expiredDateProduct: json['ExpiredDateProduct'] as int?,
      defaultUnitNumber: json['DefaultUnitNumber'] as int?,
      branchesProduct: json['BranchesProduct'] as bool?,
      additionalRate: json['AdditionalRate'],
      priceAddRatio: json['PriceAddRatio'],
      taxesRate: json['TaxesRate'],
      serialInput: json['SerialInput'] as bool?,
      serialOutput: json['SerialOutput'] as bool?,
      priceEdit: json['PriceEdit'] as int?,
      registerationDate: json['RegisterationDate'],
      stoppingProduct: json['StoppingProduct'] as int?,
      isPureCostProduct: json['IsPureCostProduct'] as bool?,
      invisibleProduct: json['InvisibleProduct'] as bool?,
      productType: json['ProductType'] as int?,
      productclassifyID: json['ProductclassifyID'] as int?,
      productclassifyName: json['ProductclassifyName'] as String?,
      productclassifyEnName: json['ProductclassifyEnName'] as String?,
      createdBy: json['CreatedBy'] as int?,
      productcImage: json['ProductcImage'] as String?,
      isFavorite: json['IsFavorite'] as int?,
      customerQuantity: (json['CustomerQuantity'] as num?)?.toDouble(),
      totalQuantity: (json['TotalQuantity'] as num?)?.toDouble(),
      fromDate: json['FromDate'],
      toDate: json['ToDate'],
      soldQuantity: (json['SoldQuantity'] as num?)?.toDouble(),
      remainQuantity: (json['RemainQuantity'] as num?)?.toDouble(),
      requiredQTY: json['RequiredQTY'] as int?,
      giftQTY: json['GiftQTY'] as int?,
      yGiftQty: json['Y_Gift_Qty'] as int?,
      description1: json['Description1'] as String?,
      description2: json['Description2'] as String?,
      description3: json['Description3'] as String?,
      description4: json['Description4'] as String?,
      description5: json['Description5'] as String?,
      description6: json['Description6'] as String?,
      description7: json['Description7'] as String?,
      description8: json['Description8'] as String?,
      description9: json['Description9'] as String?,
      description10: json['Description10'] as String?,
      numOfPages: json['NumOfPages'],
      defaultUnitArName: json['DefaultUnitArName'] as String?,
      defaultUnitEnName: json['DefaultUnitEnName'] as String?,
      showGroup: json['ShowGroup'] as int?,
      description11: json['Description11'] as String?,
      description12: json['Description12'] as String?,
      description13: json['Description13'] as String?,
      description14: json['Description14'] as String?,
      description15: json['Description15'] as String?,
      description16: json['Description16'] as String?,
      description17: json['Description17'] as String?,
      description18: json['Description18'] as String?,
      description19: json['Description19'] as String?,
      description20: json['Description20'] as String?,
      orderUnitID: json['OrderUnitID'] as int?,
      orderUnitName: json['OrderUnitName'] as String?,
      orderUnitEName: json['OrderUnitEName'] as String?,
      unitEndUser: json['UnitEndUser'],
      unitDiscRate: json['UnitDiscRate'],
      customerQtyFree: (json['CustomerQtyFree'] as num?)?.toDouble(),
      totalQtyFree: (json['TotalQtyFree'] as num?)?.toDouble(),
      unitValue: json['UnitValue'] as int?,
      productColorsSizes: json['Product_ColorsSizes'] as List?,
      productUnitsandPrices: json['Product_UnitsandPrices'] as List?,
      productImages: json['Product_Images'] as List?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ProductCode': productCode,
      'BarCode': barCode,
      'ColorID': colorID,
      'ColorArName': colorArName,
      'ColorEnName': colorEnName,
      'SizeID': sizeID,
      'SizeName': sizeName,
      'SizeEName': sizeEName,
      'ProductArName': productArName,
      'ProductEnName': productEnName,
      'CategoryId': categoryId,
      'CategoryCode': categoryCode,
      'CategoryArName': categoryArName,
      'CategoryEnName': categoryEnName,
      'DepartmentId': departmentId,
      'DepartmentArName': departmentArName,
      'DepartmentEnName': departmentEnName,
      'DescriptionID': descriptionID,
      'DescriptionArName': descriptionArName,
      'DescriptionEnName': descriptionEnName,
      'SeasonID': seasonID,
      'SeasonArName': seasonArName,
      'SeasonEnName': seasonEnName,
      'BrandID': brandID,
      'BrandArName': brandArName,
      'BrandEnName': brandEnName,
      'CountryID': countryID,
      'CountryArName': countryArName,
      'CountryEnName': countryEnName,
      'PatternId': patternId,
      'PatternArName': patternArName,
      'PatternEnName': patternEnName,
      'StockQuantity': stockQuantity,
      'Price': price,
      'PriceAfterDiscount': priceAfterDiscount,
      'WholePrice': wholePrice,
      'HalfWholePrice': halfWholePrice,
      'SalePrice': salePrice,
      'LastBuyPrice': lastBuyPrice,
      'LocalCost': localCost,
      'ExportPrice': exportPrice,
      'RetailPrice': retailPrice,
      'Specification': specification,
      'ProductID': productID,
      'PriceUnit2': priceUnit2,
      'WholePriceUnit2': wholePriceUnit2,
      'HalfWholePriceUnit2': halfWholePriceUnit2,
      'SalePriceUnit2': salePriceUnit2,
      'LastBuyPriceUnit2': lastBuyPriceUnit2,
      'ExportPriceUnit2': exportPriceUnit2,
      'RetailPriceUnit2': retailPriceUnit2,
      'PriceUnit3': priceUnit3,
      'WholePriceUnit3': wholePriceUnit3,
      'HalfWholePriceUnit3': halfWholePriceUnit3,
      'SalePriceUnit3': salePriceUnit3,
      'LastBuyPriceUnit3': lastBuyPriceUnit3,
      'ExportPriceUnit3': exportPriceUnit3,
      'RetailPriceUnit3': retailPriceUnit3,
      'DiscountPercent': discountPercent,
      'CommissionValue': commissionValue,
      'CommissionPercent': commissionPercent,
      'Specifications': specifications,
      'ModelNo': modelNo,
      'ModelArName': modelArName,
      'ModelEnName': modelEnName,
      'SupplierID': supplierID,
      'SupplierArName': supplierArName,
      'SupplierEnName': supplierEnName,
      'UnitID1': unitID1,
      'Unit1ArName': unit1ArName,
      'Unit1EnName': unit1EnName,
      'BarcodeUnit1': barcodeUnit1,
      'UnitID2': unitID2,
      'Unit2Factor': unit2Factor,
      'Unit2ArName': unit2ArName,
      'Unit2EnName': unit2EnName,
      'BarcodeUnit2': barcodeUnit2,
      'UnitID3': unitID3,
      'Unit3Factor': unit3Factor,
      'Unit3ArName': unit3ArName,
      'Unit3EnName': unit3EnName,
      'BarcodeUnit3': barcodeUnit3,
      'UnitID4': unitID4,
      'Unit4Factor': unit4Factor,
      'Unit4ArName': unit4ArName,
      'Unit4EnName': unit4EnName,
      'BarcodeUnit4': barcodeUnit4,
      'ProductWeight': productWeight,
      'Unit1points': unit1points,
      'Unit2points': unit2points,
      'Unit3points': unit3points,
      'Unit4points': unit4points,
      'MaxQtyLimt': maxQtyLimt,
      'MinQtyLimit': minQtyLimit,
      'PriceUnit4': priceUnit4,
      'WholePriceUnit4': wholePriceUnit4,
      'HalfWholePriceUnit4': halfWholePriceUnit4,
      'SalePriceUnit4': salePriceUnit4,
      'LastBuyPriceUnit4': lastBuyPriceUnit4,
      'ExportPriceUnit4': exportPriceUnit4,
      'RetailPriceUnit4': retailPriceUnit4,
      'producedProduct': producedProduct,
      'ProductPeiceNo': productPeiceNo,
      'IsWeighingProduct': isWeighingProduct,
      'ProductionDateProduct': productionDateProduct,
      'ExpiredDateProduct': expiredDateProduct,
      'DefaultUnitNumber': defaultUnitNumber,
      'BranchesProduct': branchesProduct,
      'AdditionalRate': additionalRate,
      'PriceAddRatio': priceAddRatio,
      'TaxesRate': taxesRate,
      'SerialInput': serialInput,
      'SerialOutput': serialOutput,
      'PriceEdit': priceEdit,
      'RegisterationDate': registerationDate,
      'StoppingProduct': stoppingProduct,
      'IsPureCostProduct': isPureCostProduct,
      'InvisibleProduct': invisibleProduct,
      'ProductType': productType,
      'ProductclassifyID': productclassifyID,
      'ProductclassifyName': productclassifyName,
      'ProductclassifyEnName': productclassifyEnName,
      'CreatedBy': createdBy,
      'ProductcImage': productcImage,
      'IsFavorite': isFavorite,
      'CustomerQuantity': customerQuantity,
      'TotalQuantity': totalQuantity,
      'FromDate': fromDate,
      'ToDate': toDate,
      'SoldQuantity': soldQuantity,
      'RemainQuantity': remainQuantity,
      'RequiredQTY': requiredQTY,
      'GiftQTY': giftQTY,
      'Y_Gift_Qty': yGiftQty,
      'Description1': description1,
      'Description2': description2,
      'Description3': description3,
      'Description4': description4,
      'Description5': description5,
      'Description6': description6,
      'Description7': description7,
      'Description8': description8,
      'Description9': description9,
      'Description10': description10,
      'NumOfPages': numOfPages,
      'DefaultUnitArName': defaultUnitArName,
      'DefaultUnitEnName': defaultUnitEnName,
      'ShowGroup': showGroup,
      'Description11': description11,
      'Description12': description12,
      'Description13': description13,
      'Description14': description14,
      'Description15': description15,
      'Description16': description16,
      'Description17': description17,
      'Description18': description18,
      'Description19': description19,
      'Description20': description20,
      'OrderUnitID': orderUnitID,
      'OrderUnitName': orderUnitName,
      'OrderUnitEName': orderUnitEName,
      'UnitEndUser': unitEndUser,
      'UnitDiscRate': unitDiscRate,
      'CustomerQtyFree': customerQtyFree,
      'TotalQtyFree': totalQtyFree,
      'UnitValue': unitValue,
      'Product_ColorsSizes': productColorsSizes,
      'Product_UnitsandPrices': productUnitsandPrices,
      'Product_Images': productImages,
    };
  }
}
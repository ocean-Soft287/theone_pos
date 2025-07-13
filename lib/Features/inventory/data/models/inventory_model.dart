class ProductFilterModel {
  final int unitNo;
  final String userName;
  final bool? showAllQty;
  final bool? showPosQtyOnly;
  final bool? showNegQtyOnly;
  final bool? showGroup;
  final bool? showStoredMat;
  final dynamic groupIds; // Could be int or List<int>
  final String? itemIds;  // Format: "2105Θ2162"

  ProductFilterModel({
    required this.unitNo,
    required this.userName,
    this.showAllQty,
    this.showPosQtyOnly,
    this.showNegQtyOnly,
    this.showGroup,
    this.showStoredMat,
    this.groupIds,
    this.itemIds,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = {
      'UnitNo': unitNo,
      'UserName': userName,
    };

    if (showAllQty != null) json['ShowAllQty'] = showAllQty.toString();
    if (showPosQtyOnly != null) json['ShowPosQtyOnly'] = showPosQtyOnly.toString();
    if (showNegQtyOnly != null) json['ShowNegQtyOnly'] = showNegQtyOnly.toString();
    if (showGroup != null) json['ShowGroup'] = showGroup.toString();
    if (showStoredMat != null) json['ShowStoredMat'] = showStoredMat.toString();

    if (groupIds != null) {
      if (groupIds is int) {
        json['GroupIds'] = groupIds;
      } else if (groupIds is List<int>) {
        json['GroupIds'] = groupIds;
      }
    }

    if (itemIds != null) {
      json['ItemIds'] = itemIds;
    }

    return json;
  }
}
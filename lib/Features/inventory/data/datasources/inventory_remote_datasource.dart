import 'dart:convert';
import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:theonepos/Corec/apis/api_consumer.dart';
import 'package:theonepos/Corec/apis/dio_consumer.dart';
import 'package:theonepos/Corec/apis/encrupt.dart';
import 'package:theonepos/Corec/apis/endpoint.dart';
import 'package:theonepos/Corec/apis/keys.dart';
import 'package:theonepos/Features/inventory/data/models/inventory_model.dart';
import 'package:theonepos/Features/inventory/data/models/search_product/search_product.dart';
import 'package:theonepos/Features/inventory/data/models/store_model/store_model.dart';
import 'package:theonepos/Features/inventory/data/models/unit_model/unit_model.dart';
abstract class InventoryRemoteDataSource {
  Future<Either<String, List<StoreModel>>> getStore();
  Future<Either<String, List<UnitModel>>> getUnits();
  Future<Either<String, List<SearchProductModel>>> searchProduct({
    required String key,
  });
  Future<Either<String, String>> producedInventory({required ProductFilterModel producedInventory });


}

class InventoryRemoteDatasourceImp extends InventoryRemoteDataSource {
  ApiConsumer apiConsumer = DioConsumer(dio: Dio());
 
  @override
  Future<Either<String, List<StoreModel>>> getStore() async {
    try {
      final res = await apiConsumer.get( Endpoint.store);
      final decryptedText = decrypt(res, Keys.private, Keys.publickkey);
      final List<dynamic> jsonArray = json.decode(decryptedText);
      final List<StoreModel> products = jsonArray
      .map((item) => StoreModel.fromJson(item as Map<String, dynamic>))
      .toList();
      return Right(products);
    } on DioException catch (e) {
      return Left(e.message.toString());
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, List<UnitModel>>> getUnits() async {
    try {
      final res = await apiConsumer.get( Endpoint.units);
      final decryptedText = decrypt(res, Keys.private, Keys.publickkey,);
      final json = jsonDecode(decryptedText) as List<dynamic>;
       final items = json.map((e) => UnitModel.fromJson(e)).toList();
      return Right(items);
    } on DioException catch (e) {
      return Left(e.message.toString());
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, List<SearchProductModel>>> searchProduct({
    required String key,
  }) async {
    try {
      final res = await apiConsumer.get(
        Endpoint.searchForProduct(key: key),
      );
      final decryptedText = decrypt(res, Keys.private, Keys.publickkey);
      final json = jsonDecode(decryptedText) as List<dynamic>;
      final items = json.map((e) => SearchProductModel.fromJson(e)).toList();
      return Right(items);
    } on DioException catch (e) {
      return Left(e.message.toString());
    } catch (e) {
      return Left(e.toString());
    }
  }
  
  @override
  Future<Either<String, String>> producedInventory({required ProductFilterModel producedInventory}) async{
  try{
     final res  = await apiConsumer.post(Endpoint.producedInventory,data: producedInventory.toJson()); 
    final decryptedText = decrypt(res, Keys.private, Keys.publickkey);
     // final json = jsonDecode(decryptedText) as List<dynamic>;
 log(decryptedText);
 return Right(decryptedText);
  } on DioException catch (e) {
      return Left(e.message.toString());
    } catch (e) {
      return Left(e.toString());
    }
  }
}

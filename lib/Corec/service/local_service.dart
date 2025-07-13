import 'package:hive_flutter/adapters.dart';
import 'package:theonepos/main.dart';

import '../apis/encrupt.dart';
import '../local/chacheHelper.dart';
import '../sharde/consts.dart';

class HiveService {
  static Future<void> init() async {
    await Hive.initFlutter();
    await Future.wait([
      Hive.openBox('operation'),
      Hive.openBox('mainBranches'),
      Hive.openBox('Currencies'),
      Hive.openBox('PayWays'),
      Hive.openBox('Bonds'),
      Hive.openBox('SearchCustomer'),
      Hive.openBox('SearchCustomerStatement'),
      Hive.openBox('SalesInvoices'),
      Hive.openBox('MainCategory'),
      Hive.openBox('SalesInvoicesCollection'),
      Hive.openBox('vouchersTypes'),
    ]);
  }
}

class CacheService {
  static Future<void> init() async {
    await CacheHelper.init();
    loadCacheData();
  }

  static dynamic getData(String key) {
    return CacheHelper.getData(key: key);
  }

  static Future<void> saveData(String key, dynamic value) async {
    await CacheHelper.saveData(key: key, value: value);
  }

  static void loadCacheData() {
    ipAddress = CacheService.getData('ipAddress');
    privateKey = CacheService.getData('privateKey');
    publicKey = CacheService.getData('publicKey');
    authorization = CacheService.getData('authorization');

    CacheService.getData('switchLocalAuth') ??
        CacheService.saveData('switchLocalAuth', false);

    currentLang = CacheService.getData('changeLang') ?? 'ar';
    SellerName = CacheService.getData('FullUserName');
    userId = CacheService.getData('UserID');
    databaseName = CacheService.getData('databaseName');
    activeCode = CacheService.getData('activeCode');
    userNameServer = CacheService.getData('userName');
    passwordServer = CacheService.getData('password');
  }
}

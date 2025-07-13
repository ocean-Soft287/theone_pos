class Endpoint {
  //hstore
  static const String authroization =
      "NGQxZjUxM2JhNjc2ZjdkMjpYenR1VkVRTHNHVEM4QUR3RktITHQ5RUFiNksweTQ4TENtZFBmWk9XSy9VPQ==";
  static const String authroizationtheone =
      "ZTBjOWRlMWIyZGUyNmZlMjpnOEV0eXg4VFU1Nzl2RHhKemFOMWxvM3I0NitXSkx2cWIvSU1ZZElVUkhNPQ==";
  ///baseUrl: 'http://78.89.159.126:9393/TheOneDolphenAPI/',
  /// baseUrl: 'http://15.235.51.177/TheOneAPI/',
  /// baseUrl: 'http://15.235.51.177/TheOneAPI/',
  // static String mainbase = "http://78.89.159.126:9393/TheOneProjAPI/";
  //  static String mainbase = "http://78.89.159.126:9393/TheOneProjAPI/";

  ///main
  static String mainbase =
      "http://78.89.159.126:9393/TheOneAPIOla/";
  //7A84-2DF2-87F9-4AFC     مدير
  // static String mainbase =
  //     "http://15.235.51.177/TheOneAPI/";

     // "http://192.168.1.108:82/TheoneApi/";
  // /static String mainbase= "http://37.34.238.190:9292/TheOneHStoreAPI/";
  /// static String mainbase="http://15.235.51.177/TheOneAPIAlKareen/";
  /// static String mainbase="http://15.235.51.177/TheOneAPIAlKareen/";

  ///static String mainbase= "http://37.34.238.190:9292/TheOneHStoreAPI/";    \\\
  /// baseUrl: "http://37.34.238.190:9292/TheOneHStoreAPI/",                    \\\
  ///baseUrl: 'http://15.235.51.177/TheOneAPI/',                                  \\\
  ///baseUrl: 'http://78.89.159.126:9393/TheOneProjAPI/',                           \\\
  ///baseUrl: 'http://15.235.51.177/TheOneAPI/',                                      \\\

  ///2000
  // static String searchForProduct = "http://15.235.51.177/TheOneAPI/api/v1/rest/products/paginate";
  static String searchForProduct({required String key}) =>
      "api/Product/SearchProducts?searchKey=$key";

  static String invoiceCollecting = 'api/Voucher/InvoiceCollecting';
  static String store = "api/Stores";
  static String units = "api/Units";
  static String producedInventory = "api/Inventory/ProductInventory";

  //

  /**
 *   static String mainbase = "http://15.235.51.177/TheOneAPI/";

 *   In Test Mode 
 *  sa TheOne
 * dynamic privateKey;
//= "df9d034fc11aac0f342beb7b129dad2e";

dynamic publicKey;
//= "849f29f1c07899fe";
dynamic authorization = Endpoint.authroizationtheone;

 */
}

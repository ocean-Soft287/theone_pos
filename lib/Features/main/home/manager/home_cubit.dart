import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:local_auth/local_auth.dart';
import 'package:theonepos/corec/sharde/consts.dart';

import '../../../../Corec/local/chacheHelper.dart';
import '../../../../corec/apis/dioHelper.dart';
import '../../../../corec/apis/encrupt.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeViewState> {
  HomeCubit() : super(InitializeHomeState());

  void changeLang(context) {
    if (currentLang == null) {
      CacheHelper.saveData(key: 'changeLang', value: 'en');
      context.setLocale('en');
    } else {
      if (currentLang == 'en') {
        CacheHelper.putData(key: 'changeLang', value: 'ar');
        context.setLocale('ar');
      } else {
        CacheHelper.putData(key: 'changeLang', value: 'en');
        context.setLocale('en');
      }
    }

    emit(ChangeLangState());
  }

  void addInvoiceCollecting({required BuildContext context}) {
    final operations = Hive.box('operation').values.toList();
    DioHelper.postData(
          url: 'api/Voucher/InvoiceCollecting',
          data:
              operations.firstWhere(
                (operation) => operation['NumberFunction'] == 0,
              )['jsonData'],
        )
        .then((value) {
          final decryptedText = decrypt(value.data, privateKey, publicKey);

          if (decryptedText.contains('1')) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('تم بنجاح'),
                backgroundColor: Colors.green,
              ),
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(decryptedText),
                backgroundColor: Colors.red,
              ),
            );
          }
          emit(AddInvoiceCollectingSuccess());
        })
        .catchError((error) {
          emit(AddInvoiceCollectingError());
        });
  }

  void addOrderInFa({required BuildContext context}) {
    final operations = Hive.box('operation').values.toList();
    emit(AddOrderLoading());
    var data =
        "CLvYHyRmoht+FabNH+8paL/f2x8vYDsI6jEl07NinAFXlgZinVX/lYkJlC4aHcN/IDBJqOVTAqGdcFaD2AU22RUN2txkXknRWWg8gIYSISlJXOQLJkyJQ7TI/6rnoTjUYW6LYJ4/0gpLJiMiCyOYyGrB1Jhman5GQAYwq9F2zHORFgCs1nrxEzP8qx7ABN3FmRkIRm4jf8DbpbiNYlgyslO9GwEscqbk41DrdVskBV6k9rWWU3eOMfAfWub9ClsuwKuW1JzUWhzZqi2Bx+0cx0e958gbQZKFkT6WYfkw/aQTfYtJr5oKnxvEZl8kFRY5Iwk7LwiUsc7AjHxqKFUu+hdPR8s3pTLPlYH97O+DLJegBnflsn941mIE+0G0cosB8PxQiYhR90m7hD5RaLpqCIhWkBJvNuRAWPc6O5Fqm4wBvq2r1rPmmT7A5rLSHZc2REwx81wTAOS/hvIDBsBIfRJXUEJxpMpbOLC0FCwT7hUtDgrl0y5BLpt/dbWi3wWaw3z7bj4Gwk4tg2SuE2EVCizjUVhTg9sS8NSBRsmrqHKdeEiAd/YlIPesCSCY0uaPWMx5NcClmEAxsXvByj36LQ==";
    DioHelper.postData(
          url: 'api/SalesInvoice/Create',
          data: json.encode(
            operations.firstWhere(
              (operation) => operation['NumberFunction'] == 1,
            )['jsonData'],
          ),
        )
        .then((value) {
          final decryptedText = decrypt(value.data, privateKey, publicKey);

          if (decryptedText.contains(
            'توجد أصناف ليس لها كمية في المخزن لم يتم إضافة الطلبية',
          )) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text(
                  'توجد أصناف ليس لها كمية في المخزن لم يتم إضافة الطلبية',
                ),
                backgroundColor: Colors.red,
              ),
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('تم تسجيل الطلبيه بنجاح'),
                backgroundColor: Colors.green,
              ),
            );
          }
          emit(AddOrderSuccess());
        })
        .catchError((error) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('لم يتم حفظ الطلبيه.. حاول مره اخرى   '),
              backgroundColor: Colors.red,
            ),
          );
          emit(AddOrderError());
        });
  }

  void editOrderInFa({required BuildContext context}) {
    final operations = Hive.box('operation').values.toList();

    DioHelper.updateData(
          url: 'api/SalesInvoice/Edit',
          data:
              operations.firstWhere(
                (operation) => operation['NumberFunction'] == 2,
              )['jsonData'],
        )
        .then((value) {
          final decryptedText = decrypt(value.data, privateKey, publicKey);

          if (decryptedText.contains(
            'This exception was thrown because the response has a status code of 405 and RequestOptions.validateStatus was configured to throw for this status code.',
          )) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Error Error '),
                backgroundColor: Colors.red,
              ),
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('تم تعديل الفاتوره  بنجاح'),
                backgroundColor: Colors.green,
              ),
            );
          }
          emit(EditeOrderSuccess());
        })
        .catchError((error) {
          emit(EditeOrderError());
        });
  }

  void editInvoiceCollecting({required BuildContext context}) {
    final operations = Hive.box('operation').values.toList();

    DioHelper.updateData(
          url: 'api/Voucher/UpdateInvoiceCollecting',
          data:
              operations.firstWhere(
                (operation) => operation['NumberFunction'] == 3,
              )['jsonData'],
        )
        .then((value) {
          final decryptedText = decrypt(value.data, privateKey, publicKey);

          if (decryptedText.contains(
            'This exception was thrown because the response has a status code of 405 and RequestOptions.validateStatus was configured to throw for this status code.',
          )) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Error Error '),
                backgroundColor: Colors.red,
              ),
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('تم تعديل سند التحصيل  بنجاح'),
                backgroundColor: Colors.green,
              ),
            );
          }
          emit(EditInvoiceCollectingSuccess());
        })
        .catchError((error) {
          emit(EditInvoiceCollectingError());
        });
  }

  bool check = true;
  void changeCheckConect({required bool checkCo}) {
    check = checkCo;
    emit(ChangeCheck());
  }

  void callFunctionsForAllItems(BuildContext context, List dataList) async {
    showDialog(
      context: context,
      barrierDismissible: false, // لا يمكن إغلاقه بالضغط على الخلفية
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.transparent, // جعل الخلفية شفافة
          child: Center(
            child: Container(
              width: 120, // عرض مخصص للمؤشر
              height: 120, // ارتفاع مخصص للمؤشر
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(
                  0.7,
                ), // خلفية مظللة بلون داكن مع شفافية
                borderRadius: BorderRadius.circular(15), // زوايا دائرية للنافذة
              ),
              child: const Padding(
                padding: EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                        Colors.white,
                      ), // تغيير لون المؤشر
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );

    final Map<int, Function(BuildContext)> functionMap = {
      0: (context) => addInvoiceCollecting(context: context),
      1: (context) => addOrderInFa(context: context),
      2: (context) => editOrderInFa(context: context),
      3: (context) => editInvoiceCollecting(context: context),
    };

    for (var data in dataList) {
      final numberFunction = data['NumberFunction'];

      if (numberFunction != null && functionMap.containsKey(numberFunction)) {
        final functionToCall = functionMap[numberFunction];

        await functionToCall!(
          context,
        ); // تأكد من استخدام await إذا كانت الوظيفة غير متزامنة

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.black,
            content: Text(
              'Operation $numberFunction completed successfully!',
              style: TextStyle(color: Colors.white),
            ),
            duration: const Duration(seconds: 2),
          ),
        );
      } else {}
    }

    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pop(context); // إغلاق الـ Dialog
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.green,
          content: Text(
            'All operations completed successfully!',
            style: TextStyle(color: Colors.white),
          ),
          duration: Duration(seconds: 2),
        ),
      );
    });
  }

  bool checkLocal = true;

  void changeCheckLocal() {
    checkLocal = !checkLocal;
    checkNotConect = !checkNotConect;
    emit(
      ChangeCheck(),
    ); // إبلاغ التغيير باستخدام emit لتحديث الحالة في الـ Cubit
  }

  void changeCustomerName() {
    emit(ChangeCustomerName());
  }

  final LocalAuthentication auth = LocalAuthentication();
  Future<void> authenticate() async {
    emit(AuthLoading());

    try {
      bool canCheckBiometrics = await auth.canCheckBiometrics;
      bool isAvailable = await auth.isDeviceSupported();

      if (!canCheckBiometrics || !isAvailable) {
        emit(AuthFailed("جهازك لا يدعم بصمة الإصبع أو Face ID"));
        return;
      }

      bool authenticated = await auth.authenticate(
        localizedReason: 'The One Pos',
        options: const AuthenticationOptions(
          biometricOnly: true,
          stickyAuth: true,
          useErrorDialogs: false,
          sensitiveTransaction: false,
        ),
      );

      if (authenticated) {
        emit(AuthSuccess());
      } else {
        SystemNavigator.pop();
        emit(AuthFailed("فشلت المصادقة! ❌"));
      }
    } catch (e) {
      emit(
        AuthFailed(
          ""
          "حدث خطأ أثناء المصادقة: $e",
        ),
      );
    }
  }
}

import 'package:device_preview/device_preview.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:theonepos/corec/apis/dioHelper.dart';
import 'package:theonepos/corec/service/local_service.dart';
import 'package:theonepos/corec/sharde/blocObserver.dart';
import 'Corec/local/chacheHelper.dart';
import 'Features/main/InvoiceCollection/manager/invoice_collection_cubit.dart';
import 'Features/main/home/manager/home_cubit.dart';
import 'Features/main/intial/splash_screen.dart';
import 'Features/main/newInvoice/manager/product_cubit.dart';
import 'Features/main/setting/register/manager/register_cubit.dart';

String? encodedCredentials;
var ipAddress;
int? accessHaveDiscount;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  HiveService.init();
  CacheService.init();
  DioHelper.init();
  await CacheHelper.init();
  //baseUrl=CacheHelper.getData(key: 'baseUrl');

  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('ar')],
      path: 'assets/translation',
      fallbackLocale: const Locale('en'),

      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ProductViewCubit()),
        BlocProvider(create: (context) => HomeCubit()..authenticate()),
        BlocProvider(create: (context) => RegisterCubit()),
        BlocProvider(
          create:
              (BuildContext context) =>
                  InvoiceCollectionCubit()
                    ..getAllCurrencies()
                    ..getAllBonds()
                    ..getPayWays()
                    ..getCompanyBranchesO()
                    ..getCompanyBranchesO(),
        ),
      ],
      child: ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        child: MaterialApp(
          builder: DevicePreview.appBuilder,
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          debugShowCheckedModeBanner: false,
          title: 'The One Pos',
          theme: ThemeData(primarySwatch: Colors.blue),
          home :StartApp() //StepperPageView() // InventoryPage() //InventoryPage(), // StartApp(), //InventoryPage() // const StartApp(),
        ),
      ),
    );
  }
}

class StartApp extends StatelessWidget {
  const StartApp({super.key});

  @override
  Widget build(BuildContext context) {
    return SplashScreen();
  }
}

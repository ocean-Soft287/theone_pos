import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../manager/web_view_cubit.dart';
import '../manager/web_view_state.dart';

class TheOneWebViewScreen extends StatelessWidget {
  const TheOneWebViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (context) =>
              WebViewCubit()
                ..initializeTheOneWebView(url: 'https://theonesystemco.com/'),

      child: BlocConsumer<WebViewCubit, WebViewState>(
        listener: (context, state) {},
        builder: (context, state) {
          WebViewCubit webViewCubit = BlocProvider.of(context);

          return Scaffold(
            body: SafeArea(
              child: WillPopScope(
                onWillPop: () async {
                  if (await webViewCubit.theOneController.canGoBack()) {
                    webViewCubit.theOneController.goBack();
                    return false;
                  }
                  return true;
                },
                child: Scaffold(
                  body: Stack(
                    children: [
                      if (state is TheOneWebViewSuccess)
                        WebViewWidget(
                          controller: webViewCubit.theOneController,
                        ),

                      if (state is TheOneWebViewLoading)
                        Center(
                          child: Container(
                            width: 100, // عرض العنصر
                            height: 100, // ارتفاع العنصر
                            decoration: const BoxDecoration(
                              color: Colors.white, // لون الخلفية
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black26,
                                  blurRadius: 10.0,
                                  spreadRadius: 2.0,
                                ),
                              ],
                            ),
                            child: const Padding(
                              padding: EdgeInsets.all(8.0), // مساحة داخلية
                              child: CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  Colors.blue,
                                ), // لون المؤشر
                              ),
                            ),
                          ),
                        ),

                      if (state is TheOneWebViewError)
                        Center(
                          child: Lottie.asset(
                            'assets/images/lotter.json', // تأكد من مسار ملف Lottie
                            fit: BoxFit.cover,
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

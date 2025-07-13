import 'dart:ui';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:theonepos/Features/dashboad/webView/manager/web_view_state.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewCubit extends Cubit<WebViewState> {
  WebViewCubit() : super(InitializeWebViewState());

  late final WebViewController theOneController;

  void initializeTheOneWebView({required String url}) {
    emit(TheOneWebViewLoading());

    theOneController =
        WebViewController()
          ..setJavaScriptMode(JavaScriptMode.unrestricted)
          ..setBackgroundColor(const Color(0x00000000))
          ..setNavigationDelegate(
            NavigationDelegate(
              onPageStarted: (String url) {
                emit(TheOneWebViewLoading());
              },
              onPageFinished: (String url) {
                emit(TheOneWebViewSuccess()); // Emit success state
              },
              onWebResourceError: (WebResourceError error) {
                emit(TheOneWebViewError());
              },
              onNavigationRequest: (NavigationRequest request) {
                if (request.url.startsWith('https://theonesystemco.com/')) {
                  return NavigationDecision.prevent;
                }
                return NavigationDecision.navigate;
              },
            ),
          )
          ..loadRequest(Uri.parse(url));
  }
}

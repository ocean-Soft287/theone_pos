import 'dart:async';

import 'package:internet_connection_checker/internet_connection_checker.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class ConnectionCubit extends Cubit<bool> {
  late StreamSubscription<InternetConnectionStatus> _listener;

  ConnectionCubit() : super(true) {
    _listener = InternetConnectionChecker().onStatusChange.listen((status) {
      final bool isConnected = status == InternetConnectionStatus.connected;
      emit(isConnected);
    });
  }

  @override
  Future<void> close() {
    _listener.cancel();
    return super.close();
  }
}

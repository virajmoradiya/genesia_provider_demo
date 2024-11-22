import 'dart:io';

import 'package:flutter/material.dart';
import 'package:genesia_demo/extensions/extensions.dart';
import 'package:genesia_demo/services/preferenceService/pref_manager.dart';
import 'package:network/network.dart';

abstract class BaseProvider<T extends Object?> extends ChangeNotifier {
  final BuildContext context;

  BaseProvider({required this.context}) {
    initState();
  }

  final PrefService prefService = PrefService.instance;

  void initState() {}

  Future<M> processApi<M>(
      {required Future<M> Function() process,
        required Function(bool isLoading) loadingHandler,
        Function(Object? error)? catchError,bool throwError = false,}) async {
    loadingHandler.call(true);
    dynamic result;
    if (throwError) {
      result = await process.call();
    } else {
      result = await process.call().onError((error, stackTrace) {
        if (catchError != null) {
          return catchError(error);
        } else {
          return _handleError(error: error);
        }
      });
    }
    loadingHandler.call(false);
    return result;
  }

  _handleError({Object? error}) {
    debugPrint("error===>${error.toString()}");
    switch (error) {
      case UnAuthenticated():
        // navigatorKey.currentState?.pushNamedAndRemoveUntil(SignInScreenUI.routeName, (route) => false);
        prefService.clear();
        context.showErrorSnackBar(message: error.message ?? "Something went wrong!");
        break;
      case TimeoutException():
        context.showErrorSnackBar(message: "Timeout");
        break;
      case SocketException():
        context.showErrorSnackBar(message: error.message);
        break;
      case DefaultException():
        context.showErrorSnackBar(message: error.message ??"Something went wrong!");
        break;
      default:
        context.showErrorSnackBar(message:  "Something went wrong!");
        break;
    }
  }
}
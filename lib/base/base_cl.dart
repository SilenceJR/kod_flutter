import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../api/api.dart';

export 'package:get/get.dart';

mixin ApiMixin {
  Api get api => Api.instance;
}

mixin BaseControllerMixin implements DisposableInterface {
  Api get api => Api.instance;

  final List<Worker> _workers = [];

  void registerWorker(Worker worker) {
    if (!_workers.contains(worker)) {
      _workers.add(worker);
    }
  }

  void unRegisterWorker(Worker worker) {
    if (_workers.contains(worker)) {
      _workers.remove(worker);
    }
    worker.dispose();
  }

  @override
  void onClose() {
    for (final worker in _workers) {
      worker.dispose();
    }
    _workers.clear();
  }
}

abstract class BaseController extends GetxController with BaseControllerMixin {}

abstract class BaseFullLifeCycleController extends FullLifeCycleController
    with BaseControllerMixin, FullLifeCycleMixin {}

abstract class BaseService extends GetxService with BaseControllerMixin {}

abstract class BaseFullService extends GetxService with WidgetsBindingObserver {
  void onResumed();

  void onInactive();

  void onPaused();

  void onDetached();

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        onResumed();
        break;
      case AppLifecycleState.inactive:
        onInactive();
        break;
      case AppLifecycleState.paused:
        onPaused();
        break;
      case AppLifecycleState.detached:
        onDetached();
        break;
    }
  }

  @override
  void onClose() {
    WidgetsBinding.instance.removeObserver(this);
    super.onClose();
  }

  @override
  void onInit() {
    WidgetsBinding.instance.addObserver(this);
    super.onInit();
  }
}

extension RefreshStateExt on RefreshController {
  void finishState(bool complete, [bool noData = false]) {
    if (isRefresh) {
      complete ? refreshCompleted() : refreshFailed();
    }
    if (isLoading) {
      complete ? loadComplete() : loadFailed();
    }
    noData ? loadNoData() : resetNoData();
  }
}

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

import 'base_error.dart';

abstract class BaseViewModel extends ChangeNotifier {
  bool _busy = false;
  CompositeSubscription compositeDisposable = CompositeSubscription();
  PublishSubject<BaseError> _errorMessage = PublishSubject<BaseError>();

  bool get busy => _busy;
  Function(String message) onError;

  BaseViewModel({busy = false}) {
    setBusy(busy);
    initState();
  }

  PublishSubject<BaseError> _getErrorManager() {
    return _errorMessage;
  }

  void postError(BaseError message) {
    _getErrorManager().add(message);
  }

  onErrorListener(Function(BaseError errorType) onError) {
    addCompositeDisposable(_errorMessage.listen((error) {
      onError(error);
    }));
  }

  onCleared() {
    compositeDisposable.dispose();
  }

  addCompositeDisposable(StreamSubscription subscription) {
    if (compositeDisposable.isDisposed) {
      compositeDisposable = CompositeSubscription();
    }
    compositeDisposable.add(subscription);
  }

  void setBusy(bool value) {
    _busy = value;
    notifyListeners();
  }

  @mustCallSuper
  void initState() {}

  @mustCallSuper
  void dispose() {
    super.dispose();
    onCleared();
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutterpresentation/fruits_route_path.dart';
import 'package:flutterpresentation/presentation/widgets/base_model_widget.dart';
import 'package:flutterpresentation/presentation/widgets/base_statefull_widget.dart';
import 'package:flutterpresentation/presentation/widgets/base_widget.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'base_error.dart';
import 'base_error_parser.dart';
import 'base_view_model.dart';

class FruitsBaseViewModel extends BaseViewModel {
  bool _dataChanged = false;

  bool get hasDataChanged => _dataChanged;

  set dataChanged(bool value) {
    _dataChanged = value;
  }

  FruitsBaseViewModel({busy = false}) : super(busy: busy);
}

abstract class FruitsView<VM extends FruitsBaseViewModel>
    extends BaseStatefulWidget<VM> {
  FruitsView({Key key}) : super(key: key);
}

abstract class FruitsViewBaseState<VM extends FruitsBaseViewModel,
T extends FruitsView<VM>>
    extends BaseStatefulScreen<VM, T, FruitsErrorParser> {
  ThemeData _theme;

  ThemeData get theme => _theme;

  @override
  Widget buildAppbar() {
    return PreferredSize(
      child: SizedBox.shrink(),
      preferredSize: Size(0, 0),
    );
  }

  void onModelReady(VM model) {
    model?.onErrorListener((error) {
      showToastMessage(getErrorMessage(error));
    });

  }

  @override
  Widget getLayout() {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: statusBarColor(),
      ),
      child: BaseWidget<VM>(
          viewModel: getViewModel(),
          onModelReady: onModelReady,
          builder: (BuildContext context, VM model, Widget child) {
            return SafeArea(
              child: Scaffold(
                  backgroundColor: scaffoldColor(),
                  key: scaffoldKey,
                  extendBodyBehindAppBar: extendBodyBehindAppBar(),
                  extendBody: extendBody(),
                  appBar: buildAppbar(),
                  body: buildBody(),
                  bottomNavigationBar: buildBottomNavigationBar(),
                  floatingActionButton: floatingActionButton(),
                  floatingActionButtonLocation: floatingActionButtonLocation(),
                  floatingActionButtonAnimator: floatingActionButtonAnimator(),
                  persistentFooterButtons: persistentFooterButtons(),
                  drawer: drawer(),
                  endDrawer: endDrawer(),
                  bottomSheet: bottomSheet(),
                  resizeToAvoidBottomInset: resizeToAvoidBottomInset(),
                  drawerDragStartBehavior: drawerDragStartBehavior(),
                  drawerScrimColor: drawerScrimColor(),
                  drawerEdgeDragWidth: drawerEdgeDragWidth()),
            );
          }),
    );
  }

  @override
  String onBoardingRoutePath() {
    return FruitsRoutePaths.OnBoarding;
  }

  @override
  String widgetErrorMessage() {
    return "There was an unexpected error";
  }

  @override
  String errorLogo() {
    return '';
  }

  @override
  Color scaffoldColor() {
    return _theme?.scaffoldBackgroundColor;
  }

  @override
  Color statusBarColor() {
    return _theme?.appBarTheme?.color;
  }

  Color appBarColor() {
    return _theme?.appBarTheme?.color;
  }

  bool extendBodyBehindAppBar() {
    return true;
  }

  bool extendBody() {
    return false;
  }
}

class FruitsError extends BaseError {
  FruitsError({
    message,
    type,
    error,
    stackTrace,
  }) : super(message: message, type: type, error: error);
}

class FruitsErrorType extends BaseErrorType {
  const FruitsErrorType(value) : super(value);
  static const FruitsErrorType OTHER = const FruitsErrorType(5);
  static const FruitsErrorType INVALID_RESPONSE =
  const FruitsErrorType(6);
  static const FruitsErrorType INTERNET_CONNECTIVITY =
  const FruitsErrorType(1);
  static const FruitsErrorType SERVER_MESSAGE =
  const FruitsErrorType(7);
}

class FruitsErrorParser extends BaseErrorParser {
  FruitsErrorParser() : super();

  @override
  String parseError(BuildContext context, BaseError error) {
    var errorMessage = super.parseError(context, error);
    if (errorMessage != null) {
      return errorMessage;
    }
    switch (error.type) {
      case FruitsErrorType.OTHER:
      case FruitsErrorType.SERVER_MESSAGE:
      return error.message;
      break;
      default: return "There was an unexpected error";
        break;
    }
  }
}

abstract class FruitsBaseModelWidget<VM>
    extends BaseModelWidget<VM, FruitsErrorParser> {
  ThemeData _theme;

  ThemeData get theme => _theme;

  @override
  @mustCallSuper
  Widget build(BuildContext context, VM model) {
    return buildContent(context, model);
  }

  Widget buildContent(BuildContext context, VM model);
}


showToastMessage(String message, {
  Color backgroundColor,
  Color textColor,
  ToastGravity gravity: ToastGravity.BOTTOM,
}) {
  Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_LONG,
    gravity: gravity,
    timeInSecForIosWeb: 3,
    backgroundColor: backgroundColor != null
        ? backgroundColor
        : Colors.black.withOpacity(0.5),
    textColor: textColor != null ? textColor : Colors.white,
    fontSize: 14,
  );
}

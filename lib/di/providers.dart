import 'package:flutterpresentation/presentation/base/base_error_handler.dart';
import 'package:flutterpresentation/presentation/base/fruits_app_base_view.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

List<SingleChildWidget> providers = [
  ...independentServices,
  ...dependentServices,
  ...uiConsumableProviders
];

List<SingleChildWidget> independentServices = [
  Provider.value(value: FruitsErrorParser()),
];

List<SingleChildWidget> uiConsumableProviders = [];

List<SingleChildWidget> dependentServices = [
  ProxyProvider<FruitsErrorParser, ErrorHandler<FruitsErrorParser>>(
    update: (context, errorParser, errorHandler) =>
        ErrorHandler<FruitsErrorParser>(errorParser),
  ),
];

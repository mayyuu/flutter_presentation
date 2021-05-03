import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';

import 'base_stateless_widget.dart';

class BaseErrorScreen extends BaseStatelessScreen {
  final String assetName;
  final String errorMessage;

  BaseErrorScreen(this.assetName, this.errorMessage);

  @override
  Widget buildAppbar(BuildContext context) {
    return AppBar(
      elevation: 0,
      leading: Padding(
        padding: EdgeInsets.all(8.0),
        child: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            SystemNavigator.pop();
          },
        ),
      ),
    );
  }

  @override
  Widget buildBody(BuildContext context) {
    return Center(
      child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SvgPicture.asset(
                assetName,
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  errorMessage,
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1),
                  textAlign: TextAlign.center,
                ),
              )
            ],
          )),
    );
  }
}

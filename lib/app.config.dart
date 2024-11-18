import 'package:flutter/material.dart';

enum Environment { dev, prod }

var devConstants = AppBaseConfig(
    url: "",
    bundleID: 'com.example.simplenote.dev',
    appID: 'com.example.simplenote.dev',
    appName: 'Simple Note',
    flavor: Environment.dev,
    debug: false,
);

var prodConstants = AppBaseConfig(
    url: "",
    bundleID: 'com.example.simplenote',
    appID: 'com.example.simplenote',
    appName: 'Simple Note',
    flavor: Environment.prod,
    debug: true,
);

dynamic setEnvironment(Environment env) {
  switch (env) {
    case Environment.dev:
      return devConstants;
      break;
    case Environment.prod:
      return prodConstants;
      break;
  }
}

class AppBaseConfig {
  final String url;
  final String bundleID;
  final String appID;
  final String appName;
  final Environment flavor;
  final bool debug;

  AppBaseConfig({
    required this.url,
    required this.bundleID,
    required this.appID,
    required this.appName,
    required this.flavor,
    required this.debug,
  });
}

class AppConfig extends InheritedWidget {
  final AppBaseConfig appBaseConfig;

  const AppConfig({
    Key? key,
    required Widget child,
    required this.appBaseConfig,
  }) : super(
      key: key,
      child: child
  );

  static AppConfig of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<AppConfig>()!;
  }

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => false;
}

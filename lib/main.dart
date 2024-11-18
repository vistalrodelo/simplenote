import 'package:flutter/material.dart';
import 'package:simplenote/service.locator.dart';
import 'package:simplenote/simplenote.dart';

import 'app.config.dart';

main() async {
  var config = setEnvironment(Environment.dev);
  WidgetsFlutterBinding.ensureInitialized();

  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );

  var configuredApp = AppConfig(
    appBaseConfig: AppBaseConfig(
        url: config.url,
        bundleID: config.bundleID,
        appID: config.appID,
        appName: config.appName,
        flavor: config.flavor,
        debug: config.debug,
    ),
    child: const SimpleNote(),
  );

  // Initialize database services and listeners
  await setupLocator();
  //await initializeConfig();
  runApp(configuredApp);

}


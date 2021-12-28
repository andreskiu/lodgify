import 'package:injectable/injectable.dart';

import 'environment_config.dart';

@Environment(EnvironmentConfig.dev)
@Injectable(as: EnvironmentConfig)
class EnvironmentDev extends EnvironmentConfig {
  @override
  String get baseUrl =>
      "https://gist.githubusercontent.com/huvber/ba0d534f68e34f1be86d7fe7eff92c96/raw/508f46dbf6535f830aa92cf97359853c5700bab1/";

  @override
  String get firebaseUrl => 'url_firebase';

  @override
  String get environmentName => EnvironmentConfig.dev;
}

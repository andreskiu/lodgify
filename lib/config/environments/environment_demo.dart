import 'package:injectable/injectable.dart';
import 'environment_config.dart';

@Environment(EnvironmentConfig.demo)
@Injectable(as: EnvironmentConfig)
class EnvironmentDemo extends EnvironmentConfig {
  @override
  String get baseUrl =>
      "https://gist.githubusercontent.com/huvber/ba0d534f68e34f1be86d7fe7eff92c96/raw/508f46dbf6535f830aa92cf97359853c5700bab1/";

  @override
  String get firebaseUrl => "use_with_local_data";

  @override
  String get environmentName => EnvironmentConfig.demo;
}

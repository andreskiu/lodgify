// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:dio/dio.dart' as _i3;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../../domain/tasks/services/tasks_service.dart' as _i10;
import '../../domain/tasks/use_cases/get_tasks_use_case.dart' as _i9;
import '../../infrastructure/tasks/repositories/task_server_repository.dart'
    as _i12;
import '../../infrastructure/tasks/services/interfaces/i_task_data_provider.dart'
    as _i11;
import '../../infrastructure/tasks/services/task_service.dart' as _i13;
import '../environments/environment_config.dart' as _i4;
import '../environments/environment_demo.dart' as _i5;
import '../environments/environment_dev.dart' as _i6;
import '../environments/environment_prod.dart' as _i7;
import '../environments/environment_qa.dart' as _i8;
import 'injectable.dart' as _i14;

const String _demo = 'demo';
const String _dev = 'dev';
const String _prod = 'prod';
const String _qa = 'qa';
// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  final registerModule = _$RegisterModule();
  gh.lazySingleton<_i3.Dio>(() => registerModule.dio());
  gh.factory<_i4.EnvironmentConfig>(() => _i5.EnvironmentDemo(),
      registerFor: {_demo});
  gh.factory<_i4.EnvironmentConfig>(() => _i6.EnvironmentDev(),
      registerFor: {_dev});
  gh.factory<_i4.EnvironmentConfig>(() => _i7.EnvironmentProd(),
      registerFor: {_prod});
  gh.factory<_i4.EnvironmentConfig>(() => _i8.EnvironmentTest(),
      registerFor: {_qa});
  gh.lazySingleton<_i9.GetTasksUseCase>(
      () => _i9.GetTasksUseCase(get<_i10.ITasksService>()));
  gh.lazySingleton<_i11.ITasksDataProvider>(
      () => _i12.TaskServerRepository(dio: get<_i3.Dio>()));
  gh.lazySingleton<_i13.TaskService>(
      () => _i13.TaskService(provider: get<_i11.ITasksDataProvider>()));
  return get;
}

class _$RegisterModule extends _i14.RegisterModule {}

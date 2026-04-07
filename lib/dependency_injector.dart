
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:idsr/api/api.dart';
import 'package:idsr/api/apiv2.dart';
import 'package:idsr/data/entity/repository/entity_repository.dart';
import 'package:idsr/data/entity/repository/entity_repository_impl.dart';
import 'package:idsr/data/idsr/repository/threshold_repository.dart';
import 'package:idsr/data/idsr/repository/threshold_repository_impl.dart';
import 'package:idsr/data/signals/repository/signals_repository.dart';
import 'package:idsr/data/signals/repository/signals_repository_impl.dart';


final injector = GetIt.instance;

void init() {
  injector.registerLazySingleton(() => Dio());
  injector.registerLazySingleton(() => Api());
  injector.registerLazySingleton(() => ApiV2());

  //Repositories
  injector.registerLazySingleton<EntityRepository>(() => EntityRepositoryImpl(injector()));
  injector.registerLazySingleton<SignalsRepository>(() => SignalsRepositoryImpl(injector<ApiV2>()));

  injector.registerLazySingleton<ThresholdRepository>(() => ThresholdRepositoryImpl(injector<ApiV2>()));

}

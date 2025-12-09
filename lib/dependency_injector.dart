
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:idsr/api/api.dart';
import 'package:idsr/data/entity/repository/entity_repository.dart';
import 'package:idsr/data/entity/repository/entity_repository_impl.dart';


final injector = GetIt.instance;

void init() {
  injector.registerLazySingleton(() => Dio());
  injector.registerLazySingleton(() => Api());

  //Repositories
  injector.registerLazySingleton<EntityRepository>(() => EntityRepositoryImpl(injector()));

}

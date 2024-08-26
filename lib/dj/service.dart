import 'package:firebaseapp/features/home/data/data_source/home_local_data_source.dart';
import 'package:firebaseapp/features/home/data/repository/home_repository_impl.dart';
import 'package:firebaseapp/features/home/domain/repository/home_repository.dart';
import 'package:firebaseapp/features/home/domain/use_case/home_use_case.dart';
import 'package:firebaseapp/features/home/presentation/controller/home_controller.dart';
import 'package:get_it/get_it.dart';

final service = GetIt.instance;

Future<void> initDJ() async {
  service.registerLazySingleton<HomeLocalDataSource>(() => HomeLocalDataSourceImpl());
  service.registerLazySingleton<HomeRepository>(() => HomeRepositoryImpl(dataSource: service()));
  service.registerLazySingleton<HomeUseCase>(() => HomeUseCase(service()));
  service.registerLazySingleton<HomeController>(() => HomeController(service()));
  await service.allReady();
}
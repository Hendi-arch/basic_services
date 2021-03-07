import 'package:get_it/get_it.dart';

// service locator instance
final serviceLocator = GetIt.I;

// Generic sets up the locator and assigns the instances required for this class
T dependenciesLocator<T>() {
  // First check if the classes are registered
  if (!serviceLocator.isRegistered<T>()) {
    serviceLocator.registerLazySingleton(() => T);
  }

  return serviceLocator<T>();
}

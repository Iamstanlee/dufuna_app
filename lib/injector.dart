import 'package:connectivity/connectivity.dart';
import 'package:dio/dio.dart';
import 'package:dufuna/core/service/api.dart';
import 'package:dufuna/core/service/network_notifier.dart';
import 'package:dufuna/data/remote/property_remote_datasource.dart';
import 'package:dufuna/presentation/provider/property_provider.dart';
import 'package:dufuna/repository/property_repository.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.I;

Future<void> initApp() async {
  // module
  getIt.registerSingleton<Connectivity>(Connectivity());
  getIt.registerSingleton<Dio>(Dio());

  // service
  getIt.registerSingleton<NetworkNotifier>(NetworkNotifier(getIt()));
  getIt.registerSingleton<Http>(Http(getIt()));

  /// datasource
  getIt.registerSingleton<IPropertyRemoteDataSource>(
      PropertyRemoteDataSource(getIt()));

  /// repository
  getIt.registerSingleton<PropertyRepository>(
    PropertyRepository(
      networkNotifier: getIt(),
      propertyRemoteDataSource: getIt(),
    ),
  );

  /// provider
  getIt.registerSingleton<PropertyProvider>(
    PropertyProvider(propertyRepository: getIt())..getProps(),
  );
}

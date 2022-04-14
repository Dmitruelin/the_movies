import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:the_movies/utils/data_service.dart';
import 'package:the_movies/utils/data_service_implementation.dart';

import 'navigation/my_app.dart';

GetIt getIt = GetIt.instance;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  getIt.registerSingleton<DataService>(DataServiceImplementation());
  runApp(const MyApp());
}

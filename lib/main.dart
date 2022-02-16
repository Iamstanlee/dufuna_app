import 'package:dufuna/config/constants.dart';
import 'package:dufuna/config/theme.dart';
import 'package:dufuna/injector.dart';
import 'package:dufuna/presentation/provider/property_provider.dart';
import 'package:dufuna/presentation/screen/home/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initApp();

  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<PropertyProvider>(create: (_) => getIt())
      ],
      child: MaterialApp(
        title: AppStrings.kTitle,
        theme: AppTheme.defaultTheme,
        home: const HomePage(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

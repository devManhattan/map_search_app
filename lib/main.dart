import 'package:flutter/material.dart';
import 'package:test_konsi/app_injector.dart';
import 'package:test_konsi/router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppInjector().inject();
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        inputDecorationTheme: InputDecorationTheme(
            errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Colors.red)),
            disabledBorder:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            focusedErrorBorder:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            focusedBorder:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            enabledBorder:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
        primaryColor: Colors.cyan[600],
        useMaterial3: true,
      ),
      routerConfig: appRouter,
    );
  }
}

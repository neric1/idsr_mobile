import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:idsr/application/entity/entity_bloc.dart';
import 'package:idsr/dependency_injector.dart';
import 'package:idsr/presentation/home_page.dart';
import 'package:idsr/routes/routes.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: ".env");

  init();
  await injector.allReady();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    final Routes routes = Routes();

    return  MultiBlocProvider(
        providers: [
    BlocProvider(create: (context) => EntityBloc(
    entityRepository: injector(),
    )),],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          appBarTheme: AppBarTheme(
            backgroundColor: Color(0xFFececec),//Color(0xFF4287f5), // Set global AppBar color
            foregroundColor: Colors.black, // Text & icon color
            elevation: 0, // optional
          ),
          splashFactory: NoSplash.splashFactory,
          highlightColor: Colors.transparent,
          splashColor: Colors.transparent,
          hoverColor: Colors.transparent,

          colorScheme: ColorScheme.fromSeed(seedColor: Color(0xFF1A237E)),
        ),
        routerConfig: routes.go,
      ),
    );
  }
}





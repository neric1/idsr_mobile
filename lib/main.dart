import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:idsr/api/apiv2.dart';
import 'package:idsr/application/entity/entity_bloc.dart';
import 'package:idsr/application/entity/events/comments_bloc.dart';
import 'package:idsr/application/user/user_bloc.dart';
import 'package:idsr/data/signals/repository/signals_repository.dart';
import 'package:idsr/dependency_injector.dart';
import 'package:idsr/presentation/home_page.dart';
import 'package:idsr/routes/routes.dart';
import 'package:jiffy/jiffy.dart';

import 'application/idsr/threshold_bloc.dart';
import 'application/signals/signal_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: ".env");
  await Jiffy.setLocale('en_GB');
  try {
    // final dir = await getApplicationDocumentsDirectory();
    await Hive.initFlutter();
    await Hive.openBox('semsBox');
  } catch (e) {}
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
          BlocProvider(create: (context) => UserBloc(signalsRepository: injector<SignalsRepository>(),
            appHttpClient: injector(),)),
        BlocProvider(create: (context) => SignalBloc(
            signalsRepository: injector<SignalsRepository>(), userBloc: context.read<UserBloc>()),

        ),
    BlocProvider(create: (context) => EntityBloc(
    entityRepository: injector(),
    )),
          BlocProvider(create: (context) => CommentBloc(
             injector(),
          )),
          BlocProvider(
    create: (context) => ThresholdBloc(repository:injector(),userBloc: context.read<UserBloc>()))

          ,],
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





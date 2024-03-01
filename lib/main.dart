import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_task/Screen/mobile/index.dart';
import 'package:project_task/cubit/cubit.dart';
import 'package:project_task/cubit/states.dart';
import 'package:project_task/firebase_options.dart';

import 'Screen/desktop/index.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Task Management App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(0, 202, 93, 1)),
        useMaterial3: true,
      ),
      home: BlocProvider(
        create: (context) => TaskBloc(),
        child: BlocConsumer<TaskBloc, TaskStates>(
          listener: (context, state) {},
          builder: (context, state) {
            return Scaffold(
              body: FutureBuilder(
                /// Initialize Firebase
                future: Firebase.initializeApp(
                  options: DefaultFirebaseOptions.currentPlatform,
                ),
                builder: (context, snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.done:
                      return const Router();
                    default:
                      return const Text("Loading ...");
                  }
                },
              ),
            );
          },
        ),
      ),
    );
  }
}

class Router extends StatefulWidget {
  const Router({super.key});

  @override
  State<Router> createState() => _RouterState();
}

class _RouterState extends State<Router> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    signInAnon();
  }

  /// Initialize Firebase Auth
  Future signInAnon() async {
    try {
      final userCredential = await FirebaseAuth.instance.signInAnonymously();
      print(userCredential);
      print("Signed in with temporary account.");
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "operation-not-allowed":
          print("Anonymous auth hasn't been enabled for this project.");
          break;
        default:
          print("Unknown error.");
          return null;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    /// Router between Desktop or mobile
    return kIsWeb ? const IndexScreenDesktop() : const IndexScreenMob();
  }
}

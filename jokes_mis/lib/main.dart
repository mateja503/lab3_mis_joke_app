
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:jokes_mis/providers/joke_provider.dart';
import 'package:jokes_mis/screens/favorite_page.dart';
import 'package:jokes_mis/screens/home.dart';
import 'package:jokes_mis/screens/jokes_type_list.dart';
import 'package:jokes_mis/screens/random_joke.dart';
import 'package:jokes_mis/widgets/type_card.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:provider/provider.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<JokeProvider>(
          create: (_) => JokeProvider(),
        )
      ],
      child: const MyApp(),
    ),
  );
}

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // Initialize Firebase in the isolate if necessary.
  await Firebase.initializeApp();

  print("Handling a background message: ${message.messageId}");

  // Add logic here, e.g., HTTP requests, local database updates, etc.

  // Access the notification data
  if (message.notification != null) {
    print("Notification Title: ${message.notification?.title}");
    print("Notification Body: ${message.notification?.body}");
  }

  // Access the data payload
  print("Data Payload: ${message.data}");
}



class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Jokes', // Change to the appropriate app title if needed
      initialRoute: '/',
      routes: {
        '/': (context) => const Home(),
        '/details': (context) => JokeTypeList(),
        '/random':(context) => const RandomJoke(),
        '/favorites':(context) => FavoriteJokes(),
      },
    );
  }
}


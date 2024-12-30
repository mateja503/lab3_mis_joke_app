import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:jokes_mis/model/type.dart';
import '../widgets/type_card.dart';
import '../services/api_service.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  //List<String> types = [];
  List<String> types = [];
  String? _fcmToken;

  @override
  void initState() {
    super.initState();
    _requestPermission();
    _enableFCMAutoInit();
    _getToken();
    _listenToTokenRefresh();
    getJokeTypesFromAPI();
  }

  Future<void> _requestPermission() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    try {
      NotificationSettings settings = await messaging.requestPermission(
        alert: true,
        announcement: false,
        badge: true,
        carPlay: false,
        criticalAlert: false,
        provisional: false,
        sound: true,
      );
      print('User granted permission: ${settings.authorizationStatus}');
    } catch (e) {
      print("Error requesting permission: $e");
    }
  }

  Future<void> _enableFCMAutoInit() async {
    try {
      await FirebaseMessaging.instance.setAutoInitEnabled(true);
      print("FCM auto-init re-enabled.");
    } catch (e) {
      print("Error enabling FCM auto-init: $e");
    }
  }

  // Get the FCM token
  Future<void> _getToken() async {
    try {

      String? token = await FirebaseMessaging.instance.getToken();
      setState(() {
        _fcmToken = token;
      });
      print("FCM Token: $_fcmToken");

      // You can store the token in your server or use it as needed.
    } catch (e) {
      print("Error getting token: $e");
    }
  }



  void _listenToTokenRefresh() {
    FirebaseMessaging.instance.onTokenRefresh.listen((newToken) {
      setState(() {
        _fcmToken = newToken; // Update the token when it changes
      });
      print("FCM Token refreshed: $_fcmToken");

      // You can send the new token to your server or handle it as needed.
    }).onError((err) {
      print("Error on token refresh: $err");
    });
  }

  void getJokeTypesFromAPI() async {
    try {
      final response = await ApiService.getAllJokeTypes();

      if (response.statusCode == 200) {
        var data = json.decode(response.body);

        if (data is List) {
          List<String> stringList = List<String>.from(data);
          print("String list: $stringList");
          setState(() {
            types = stringList;
          });
        } else {
          print("Expected a List of strings, but got something else");
        }
      } else {
        print("Failed to fetch data. Status code: ${response.statusCode}");
      }
    } catch (e) {
      print("An error occurred: $e");
    }
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent[100],
        title: const Text("Joke App"),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.shuffle),
          tooltip: "Random Joke",
          onPressed: () {
            Navigator.pushNamed(context, '/random');
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite),
            tooltip: "Favorites",
            onPressed: () {
              Navigator.pushNamed(context, '/favorites');  // Navigate to favorites page
            },
          ),
        ],
      ),
      body: TypeCard(types: types),
    );
  }


}

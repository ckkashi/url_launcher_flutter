import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:url_launcher_app/strings.dart';

import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: appTitle,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.blue.shade800, brightness: Brightness.dark),
        useMaterial3: true,
      ),
      home: const Home(),
    );
  }
}

class Home extends StatelessWidget {
  const Home({super.key});

  void open(String url, bool inApp) async {
    try {
      Uri current_uri = Uri.parse(url);
      if (await canLaunchUrl(current_uri)) {
        if (inApp) {
          launchUrl(current_uri, mode: LaunchMode.inAppWebView);
        } else {
          launchUrl(current_uri, mode: LaunchMode.externalApplication);
        }
      }
    } catch (e) {
      log(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(appTitle),
        centerTitle: true,
        elevation: 0,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            styledButton('Open URL in Browser', Colors.blue, () {
              open('https://www.google.com', false);
            }),
            styledButton('Open URL in App', Colors.deepPurple, () {
              open('https://www.google.com', true);
            }),
            styledButton('Dial Number', Colors.green, () {
              open('tel:03233521729', false);
            }),
            styledButton('Message on Whatsapp', Colors.lightGreen.shade800, () {
              open("whatsapp://send?phone=+923233521729&text=Hi", false);
            }),
            styledButton('Send SMS', Colors.amber, () {
              open('sms:03233521729', false);
            }),
            styledButton('Open Youtube', Colors.red, () {
              open('https://www.youtube.com', false);
            }),
            styledButton('Send E-Mail', Colors.orange, () {
              open('mailto:ckkashi007@gmail.com', false);
            }),
          ],
        ),
      ),
    );
  }

  Padding styledButton(String btnTitle, Color btnColor, dynamic onPressed) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
            fixedSize: const MaterialStatePropertyAll(Size(200, 40)),
            padding: const MaterialStatePropertyAll(
                EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0)),
            backgroundColor: MaterialStatePropertyAll(btnColor),
            foregroundColor: const MaterialStatePropertyAll(Colors.white),
            elevation: const MaterialStatePropertyAll(0),
            shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0)))),
        child: Text(btnTitle),
      ),
    );
  }
}

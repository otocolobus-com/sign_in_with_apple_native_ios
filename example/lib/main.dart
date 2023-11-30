import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:sign_in_with_apple_native/sign_in_with_apple_native.dart';
import 'package:sign_in_with_apple_native/sign_in_with_apple_native_button.dart';
import 'package:sign_in_with_apple_native/types/credential_state.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isAvailable = false;
  final _signInWithAppleNativePlugin = SignInWithAppleNative();

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    bool isAvailable;
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.
    try {
      isAvailable = await _signInWithAppleNativePlugin.isAvailable();
    } on PlatformException {
      isAvailable = false;
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _isAvailable = isAvailable;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Column(children: [
            Text('Is "Sign In with Apple" available: $_isAvailable\n'),
            FutureBuilder(
                future: _signInWithAppleNativePlugin.credentialState,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data != CredentialState.authorized) {
                      return SizedBox(
                        width: MediaQuery.of(context).size.width * 0.8,
                        height: 60,
                        child: SignInWithAppleNativeButton(
                          onPressed: _authorize,
                        ),
                      );
                    }
                    return Text('Credential state: ${snapshot.data}');
                  } else if (snapshot.hasError) {
                    return Text('Credential state: ${snapshot.error}');
                  } else {
                    return const Text('Credential state: loading...');
                  }
                }),
          ]),
        ),
      ),
    );
  }

  Future<void> _authorize() async {
    try {
      final authorizationResult =
          await _signInWithAppleNativePlugin.authorize();
      print('authorizationResult: ${authorizationResult.idToken}');
    } catch (e) {
      print('authorizationResult: empty');
    }
  }
}

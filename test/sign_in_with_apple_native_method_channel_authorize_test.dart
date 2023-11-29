import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sign_in_with_apple_native/sign_in_with_apple_native_method_channel.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  MethodChannelSignInWithAppleNative platform =
      MethodChannelSignInWithAppleNative();
  const MethodChannel channel = MethodChannel('SignInWithAppleNative');

  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, null);
  });

  test('authorize should throw if result is null', () async {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(
      channel,
      (MethodCall methodCall) async {
        return null;
      },
    );

    expect(() => platform.authorize(), throwsException);
  });

  test('authorize should throw if result doesn\'t contains isSuccess',
      () async {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(
      channel,
      (MethodCall methodCall) async {
        return {
          "error": "error",
        };
      },
    );

    expect(() => platform.authorize(), throwsException);
  });

  test('authorize should throw exception if result does not contain credential',
      () async {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(
      channel,
      (MethodCall methodCall) async {
        return {
          "isSuccess": true,
          "credentials":
              "credentials" // "credentials" but "credential" is expected
        };
      },
    );

    expect(() => platform.authorize(), throwsException);
  });

  test('authorize should return credential if result contains credential',
      () async {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(
      channel,
      (MethodCall methodCall) async {
        return {
          "isSuccess": true,
          "credential": {
            "id": "user",
          },
        };
      },
    );

    expect(await platform.authorize(), {
      "id": "user",
    });
  });

  test('should throw exception if isSuccess is false', () {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(
      channel,
      (MethodCall methodCall) async {
        return {
          "isSuccess": false,
          "error": "error",
        };
      },
    );

    expect(() => platform.authorize(), throwsException);
  });
}

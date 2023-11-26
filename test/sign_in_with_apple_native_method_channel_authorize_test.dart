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

  test('authorize should throw if result contains error', () async {
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

  test(
      'authorize should return empty map if result does not contain credential',
      () async {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(
      channel,
      (MethodCall methodCall) async {
        return {
          "credentials":
              "credentials" // "credentials" but "credential" is expected
        };
      },
    );

    expect(await platform.authorize(), {});
  });

  test('authorize should return credential if result contains credential',
      () async {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(
      channel,
      (MethodCall methodCall) async {
        return {
          "credential": {
            "user": "user",
          },
        };
      },
    );

    expect(await platform.authorize(), {
      "user": "user",
    });
  });
}

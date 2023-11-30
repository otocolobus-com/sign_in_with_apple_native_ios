import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sign_in_with_apple_native/sign_in_with_apple_native_method_channel.dart';
import 'package:sign_in_with_apple_native/types/credential_state.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  MethodChannelSignInWithAppleNative platform =
      MethodChannelSignInWithAppleNative();
  const MethodChannel channel = MethodChannel('SignInWithAppleNative');

  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, null);
  });

  test('should return notFound if platform returns null', () async {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(
      channel,
      (MethodCall methodCall) async {
        return null;
      },
    );
    expect(await platform.credentialState, CredentialState.notFound);
  });

  test('should return platfrom value', () async {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(
      channel,
      (MethodCall methodCall) async {
        return CredentialState.authorized.value;
      },
    );
    expect(await platform.credentialState, CredentialState.authorized);
  });

  test('should throw exception if platform returns invalid value', () async {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(
      channel,
      (MethodCall methodCall) async {
        return 9999;
      },
    );
    expect(() => platform.credentialState, throwsException);
  });
}

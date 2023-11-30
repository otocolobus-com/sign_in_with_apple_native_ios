import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sign_in_with_apple_native/sign_in_with_apple_native_method_channel.dart';
import 'package:sign_in_with_apple_native/types/credential_state.dart';

class MockEventChannelHandler extends MockStreamHandler {
  final int? value;
  MockEventChannelHandler(this.value);

  @override
  void onCancel(Object? arguments) {}

  @override
  void onListen(Object? arguments, MockStreamHandlerEventSink events) {
    events.success(value);
  }
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  MethodChannelSignInWithAppleNative platform =
      MethodChannelSignInWithAppleNative();
  const EventChannel channel =
      EventChannel('SignInWithAppleNativeRevokedAuthentication');

  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockStreamHandler(channel, null);
  });

  test('correctly maps the credential state', () async {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockStreamHandler(
      channel,
      MockEventChannelHandler(CredentialState.revoked.value),
    );

    expect(
        await platform.onAuthenticationRevoked.first, CredentialState.revoked);
  });

  test('throws an exception if the credential state is null', () async {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockStreamHandler(
      channel,
      MockEventChannelHandler(null),
    );

    expect(
      () async => await platform.onAuthenticationRevoked.first,
      throwsException,
    );
  });

  test('throws an exception if the credential state is unknown', () async {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockStreamHandler(
      channel,
      MockEventChannelHandler(9999),
    );

    expect(
      () async => await platform.onAuthenticationRevoked.first,
      throwsException,
    );
  });
}

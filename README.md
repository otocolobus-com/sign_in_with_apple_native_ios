# sign_in_with_apple_native

A Flutter plugin for iOS 13+ that enables you to use native "Sign in with Apple" functionality.

## Getting Started

### 1. Add dependency

```yaml
dependencies:
  sign_in_with_apple_native: ^0.0.1
```

### 2. Import the plugin

```dart
import 'package:sign_in_with_apple_native/sign_in_with_apple_native.dart';
```

### 3. Use the plugin

#### 3.1 Prerequisites

In order to use Sign in with Apple, you need to add "Sign in with Apple" capability to your app. To do so, open your project in Xcode, select your project in the Project Navigator, select your target, and open the "Signing & Capabilities" tab. Click the "+ Capability" button, and select "Sign in with Apple" from the list.

#### 3.2 Check if Sign in with Apple is available

Always returns `true` as the plugin is only available on iOS 13+.

```dart
final isAvailable = await SignInWithAppleNative.isAvailable();
```

#### 3.3 Check credentials state

Uses `ASAuthorizationAppleIDProvider.getCredentialState` to check the state of the credentials. This is a local, inexpensive, nonnetwork call enabled by the Apple ID system that keeps the Apple ID state on a device in sync with Apple servers.

```dart
final state = await SignInWithAppleNative.credentialState;
```

#### 3.4 Request credentials

Uses `ASAuthorizationController.performRequests` to request credentials from the user.

```dart
SignInWithAppleButton(
  onPressed: () async {
    final credential = await SignInWithAppleNative.authorize();
    print(credential);
  },
)
```

#### 3.5 Verify credentials on your server

Use the `identityToken` and `authorizationCode` to verify the credentials on your server. See [Verifying a User](https://developer.apple.com/documentation/sign_in_with_apple/sign_in_with_apple_rest_api/verifying_a_user) for more information.

## Example

See the [example application](./example/lib/main.dart) source for a complete sample app using the Sign in with Apple button.

## License

MIT

## Author

[Władysław Czyżewski](https://github.com/wladyslawczyzewski) (https://otocolobus.com)

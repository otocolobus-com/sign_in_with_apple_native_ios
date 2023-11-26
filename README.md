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

```dart
SignInWithAppleButton(
  onPressed: () async {
    final credential = await SignInWithAppleNative.signIn();
    print(credential);
  },
)
```

## Example

See the [example application](./example/lib/main.dart) source for a complete sample app using the Sign in with Apple button.

## License

MIT

## Author

[IONE Software Sp. z o.o.](https://ione.software)

[Władysław Czyżewski](https://github.com/wladyslawczyzewski)

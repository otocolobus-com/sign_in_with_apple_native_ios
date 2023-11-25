import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

class SignInWithAppleNativeButton extends StatelessWidget {
  final VoidCallback onPressed;

  const SignInWithAppleNativeButton({
    Key? key,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return UiKitView(
      viewType: "SignInWithAppleNativeButton",
      onPlatformViewCreated: _onPlatformViewCreated,
    );
  }

  void _onPlatformViewCreated(int id) {
    MethodChannel('SignInWithAppleNativeButton_$id')
        .setMethodCallHandler(_handleMethodCall);
  }

  Future<void> _handleMethodCall(MethodCall call) async {
    switch (call.method) {
      case 'onPressed':
        onPressed();
        break;
      default:
        throw UnimplementedError("Unimplemented ${call.method} method");
    }
  }
}

Pod::Spec.new do |s|
  s.name             = 'sign_in_with_apple_native'
  s.version          = '0.0.1'
  s.summary          = 'The Flutter plugin for iOS to use the native implementation of "Sign In with Apple" authorization.'
  s.description      = <<-DESC
  The Flutter plugin for iOS to use the native implementation of "Sign In with Apple" authorization.
  
  The plugin provides the native "Sign In with Apple" button and API to handle the authorization.
                       DESC
  s.homepage         = 'https://ione.software'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Władysław Czyżewski' => 'wladyslaw.czyzewski@ione.software' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.dependency 'Flutter'
  s.platform = :ios, '13.0'

  # Flutter.framework does not contain a i386 slice.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386' }
  s.swift_version = '5.0'
end

# Uncomment the next line to define a global platform for your project
 platform :ios, '10.0'

target 'MeuNegocio' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!
  pod 'FirebaseAuth', '9.4.0'
  pod 'FirebaseFirestore', '9.4.0'
  pod 'GoogleSignIn', '5.0.2'

  target 'MeuNegocioTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'MeuNegocioUITests' do
    # Pods for testing
  end

end

post_install do |installer|
  installer.pods_project.build_configurations.each do |config|
    config.build_settings.delete 'IPHONEOS_DEPLOYMENT_TARGET'
    config.build_settings["EXCLUDED_ARCHS[sdk=iphonesimulator*]"] = "arm64"
  end
end

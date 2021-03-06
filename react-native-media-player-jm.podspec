Pod::Spec.new do |s|
  s.name         = "react-native-media-player-jm"
  s.version      = "1.0.2"
  s.summary      = "Jimi Media Video Player SDK for React Native"
  s.description  = "Jimi Media Video Player SDK for React Native"
  s.homepage     = "https://github.com/JimiPlatform/react-native-media-player-jm"

  s.license      = "Apache License 2.0"
  s.author       = { "Jason" => "lizhijian@jimilab.com" }
  s.platform     = :ios, "9.0"
  s.requires_arc = true
  s.static_framework = true

  s.source       = { :git => "https://github.com/JimiPlatform/react-native-media-player-jm.git", :tag => "v#{s.version}" }

  s.source_files  = "ios/RNJMMediaPlayer/**/*.{h,m}"
  s.libraries = "c++"

  s.dependency 'React'
  s.dependency 'JMSmartMediaPlayer', '1.1.7-beta1'
  
end

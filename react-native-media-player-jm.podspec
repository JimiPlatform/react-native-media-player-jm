Pod::Spec.new do |s|
  s.name         = "react-native-media-player-jm"
  s.version      = "1.0.0"
  s.summary      = "Jimi Media Video Player SDK for React Native"

  s.description  = <<-DESC
  Jimi Media Video Player SDK for React Native
                   DESC

  s.homepage     = "https://github.com/JimiPlatform/react-native-media-player-jm"

  s.license      = "MIT"
  s.author       = { "Jason" => "lizhijian@jimilab.com" }
  s.platform     = :ios, "9.0"
  s.requires_arc = true

  s.source       = { :git => "https://github.com/JimiPlatform/react-native-media-player-jm.git", :tag => "#{s.version}" }

  s.source_files  = "ios/**/*.{h,m}"
  #s.ios.vendored_frameworks = "ios/**/*.{framework}"
  s.libraries = "c++"

  s.dependency 'React'
  s.dependency 'JMSmartMediaPlayer'
end

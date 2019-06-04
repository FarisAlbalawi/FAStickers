#
# Be sure to run `pod lib lint FAStickers.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'FAStickers'
  s.version          = '0.1.0'
s.swift_version          = '5'
  s.summary          = 'FAStickers allows you to create easily Stickers, Emojis, and Gifs'

  s.description      = <<-DESC
'FAStickers allows you to create easily Stickers, Emojis, and Gif that you can use it for Photo Editor like the SnapChat app when you add a Stickers on images, etc, or you can use it in chat to send a Stickers, Emojis or even a Gif message, etc. '.
                       DESC

  s.homepage         = 'https://github.com/FarisAlbalawi/FAStickers'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Faris Albalawi' => 'developer.faris@gmail.com' }
  s.source           = { :git => 'https://github.com/FarisAlbalawi/FAStickers.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '11.0'

  s.source_files = 'FAStickers/Classes/*.swift'
  
  # s.resource_bundles = {
  #   'FAStickers' => ['FAStickers/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
   s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end

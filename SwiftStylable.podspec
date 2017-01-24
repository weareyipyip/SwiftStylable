#
# Be sure to run `pod lib lint SwiftStylable.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'SwiftStylable'
  s.version          = '0.0.27'
  s.summary          = 'Swift framework to enable project wide styles that can be used in storyboards.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
Swift framework to enable project wide styles that can be used in storyboards. You can predefine styles in a property list and use them in your project as well as in the interface builder.
                       DESC

  s.homepage         = 'https://gitlab.com/weareyipyip/SwiftStylable'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Marcel Bloemendaal' => 'm.bloemendaal@yipyip.nl' }
  s.source           = { :git => 'https://github.com/weareyipyip/SwiftStylable.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '9.0'

  s.source_files = 'SwiftStylable/Classes/**/*'
  
  # s.resource_bundles = {
  #   'SwiftStylable' => ['SwiftStylable/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end

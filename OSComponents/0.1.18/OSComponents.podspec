#
# Be sure to run `pod lib lint OSComponents.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'OSComponents'
  s.version          = '0.1.18'
  s.summary          = 'OSComponents is a collections os components designed to help the apps development'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
OSComponents is a collections os components designed to help the apps development!
                       DESC

  s.homepage         = 'https://github.com/appsimples/os-components-ios'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'MatheusFV' => 'matheus.venosa@usp.br' }
  s.source           = { :git => 'https://github.com/appsimples/os-components-ios.git', :tag => s.version.to_s }
  s.social_media_url = 'https://www.appsimples.com.br'

  s.ios.deployment_target = '9.2'

  s.source_files = 'Source/**/*'

  s.swift_version = '4.1'

  s.resource_bundles = {
      'OSComponents' => ['Source/**/*.xib', 'Media.xcassets/**/*.{png,jpg,json}']
  }
  s.resources = 'Media.xcassets'

  # s.public_header_files = 'Pod/Classes/**/*.h'
  s.frameworks = 'UIKit', 'MapKit'
  s.dependency 'AlamofireImage', '~> 3.3'
  s.dependency 'Moya/RxSwift', '~> 10.0.1'
  s.dependency 'ObjectMapper', '~> 3.3.0'
  s.dependency 'Reusable', '~> 4.0.0'
end

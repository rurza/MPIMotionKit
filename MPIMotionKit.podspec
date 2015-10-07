#
# Be sure to run `pod lib lint MPIMotionKit.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "MPIMotionKit"
  s.version          = "0.1.0.1"
  s.summary          = "Super simple to use wrapper for CoreMotion."

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!  
  s.description      = <<-DESC
Super simple to use wrapper for CoreMotion written in Objective-C. Idea based on MotionKit in Swift written by MHaroonBaig => https://github.com/MHaroonBaig
                       DESC

  s.homepage         = "https://github.com/rurza/MPIMotionKit"
  # s.screenshots     = "www.example.com/screenshots_1", "www.example.com/screenshots_2"
  s.license          = 'MIT'
  s.author           = { "Adam Różyński" => "adam@micropixels.pl" }
  s.source           = { :git => "https://github.com/rurza/MPIMotionKit.git", :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/rurza'

  s.platform     = :ios, '8.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes/**/*'
  s.resource_bundles = {
    'MPIMotionKit' => ['Pod/Assets/*.png']
  }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  s.frameworks = 'Foundation', 'CoreMotion'
  # s.dependency 'AFNetworking', '~> 2.3'
end

#
# Be sure to run `pod lib lint UtilitiesInSwift.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'UtilitiesInSwift'
  s.version          = '1.0.2'
  s.summary          = 'Utility functions for swift'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
Utility functions for swift that have been created through the years.  Some converted from other languages.  
The utilities are broken down by type categories (I did what I thought was ok).
  
  * Queues        --> I mainly created these so as Swift morphs, I can easily adjust the function bodies and not all over the code base, plus, I may want to add later functionality.
  * NumberToWords --> Convert decimal values to words for use in writing a check.  Cause we all write checks these days....
               
                     

                       DESC

  s.homepage         = 'http://www.axee.com'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'steveaxelrod007' => 'steve@axelrod.net' }
  s.source           = { :git => 'https://github.com/steveaxelrod007/UtilitiesInSwift.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '10.0'

  s.source_files = 'UtilitiesInSwift/Classes/**/*'
  
  # s.resource_bundles = {
  #   'UtilitiesInSwift' => ['UtilitiesInSwift/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end

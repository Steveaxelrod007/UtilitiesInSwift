#
# Be sure to run `pod lib lint UtilitiesInSwift.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'UtilitiesInSwift'
  s.version          = '1.4.2'
  s.summary          = 'Utility functions for swift'


  s.description      = <<-DESC
Utility functions for swift that have been created through the years.  Some converted from other languages.  
The utilities are broken down by type categories (I did what I thought was ok).
  
  * Queues            --> I mainly created these so as Swift morphs, I can easily adjust the function bodies and not all over the code base, plus, I may want to add later functionality.
  * NumberToWords     --> Convert decimal values to words for use in writing a check.  Cause we all write checks these days....
  * FileSystem        --> clear out temp files, determine available space on device             
  * CancelableClosure --> I use it for waiting for 0.5 seconds to elapse on key strokes, then call some lookup function 
  * UIColor Extension --> great way to save a color value as an Int then pull from database and easily convert back to UIColor
  * Int Extension     --> convert Int to String distance display in feet/miles, 123456 to 123,456,  123456 to 123.5k (thousands), 123456789 to 123.46m (million)
  * AutoFillTextField --> if trigger char is matched while typing in textfield a popup selection list is displayed                   

                       DESC

  s.homepage         = 'http://www.axee.com'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'steveaxelrod007' => 'steve@axelrod.net' }
  s.source           = { :git => 'https://github.com/steveaxelrod007/UtilitiesInSwift.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '12.0'

  s.source_files = 'UtilitiesInSwift/Classes/**/*'
  
  # s.resource_bundles = {
  #   'UtilitiesInSwift' => ['UtilitiesInSwift/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end

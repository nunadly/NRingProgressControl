#
# Be sure to run `pod lib lint NRingProgressControl.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'NRingProgressControl'
  s.version          = '0.1.0'
  s.summary          = 'simple circle progress control'

  s.description      = 'simple animated ring progress control'

  s.homepage         = 'https://github.com/nunadly/NRingProgressControl'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'nunadly' => 'nunadly@gmail.com' }
  s.source           = { :git => 'https://github.com/nunadly/NRingProgressControl.git', :tag => s.version.to_s }

  s.ios.deployment_target = '8.0'
  s.ios.frameworks = 'UIKit', 'Foundation'

  s.source_files = 'NRingProgressControl/Classes/*.{h,m}'
  
end

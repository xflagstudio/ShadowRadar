#
# Be sure to run `pod lib lint ShadowRadar.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'ShadowRadar'
  s.version          = '0.3.1'
  s.summary          = 'A radar chart view with shadow.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
ShadowRadar is a radar chart view with shadow.
                       DESC

  s.homepage         = 'https://github.com/xflagstudio/ShadowRadar'
  s.screenshots     = 'https://raw.githubusercontent.com/xflagstudio/ShadowRadar/master/screenshoots/demo.png'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'lm2343635' => 'lm2343635@126.com' }
  s.source           = { :git => 'https://github.com/xflagstudio/ShadowRadar.git', :tag => s.version.to_s }

  s.ios.deployment_target = '9.0'

  s.dependency 'ShapeView', '~> 0.3'
  s.default_subspec = 'Core'
  
    s.subspec 'Core' do |core|
      core.source_files = 'ShadowRadar/Classes/Core/**/*'
    end
    
    s.subspec 'Rx' do |title|
      title.dependency 'ShadowRadar/Core', '~> 0'
      title.dependency 'RxCocoa', '~> 4.2'
      title.source_files = 'ShadowRadar/Classes/Rx/**/*'
    end
  
end

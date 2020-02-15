Pod::Spec.new do |s|

  s.name = 'Sakura'
  s.version = '0.0.10'
  s.summary = 'A beautiful and powerful frameworks like cherry blossom.'
  s.homepage = 'https://github.com/949886'
  s.license = { :type => 'Copyright', :text => 'Copyright (c) 2017 Yae Sakura. All rights reserved.' }
  s.authors = { 'Lunar Eclipse' => '949886@qq.com' }
  s.source = { :git => 'https://github.com/949886/Sakura.git', :branch => "master"}
  s.platform = :ios, '9.0'
  s.requires_arc = true
  s.xcconfig    = { 'SWIFT_VERSION' => '5.0' }
  s.default_subspec = 'Core', 'UI'

  s.subspec "Core" do |ss|
    ss.source_files = "Sakura/Core/**/*.{h,swift}"
    ss.preserve_path = 'Modules/*'
    ss.pod_target_xcconfig = { 'SWIFT_INCLUDE_PATHS' => '$(PODS_ROOT)/Sakura/Modules' }
    ss.frameworks = 'UIKit'
    ss.library = 'z'
  end

  s.subspec "UI" do |ss|
    ss.source_files = "Sakura/UI/**/*.{h,swift}"
    ss.dependency 'Sakura/Core'
  end

  s.subspec "OC" do |ss|
    ss.dependency 'SakuraOC'
  end

end

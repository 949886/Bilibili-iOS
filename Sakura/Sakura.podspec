Pod::Spec.new do |s|
  s.name = 'Sakura'
  s.version = '0.0.1'
  s.summary = 'A beautiful and powerful frameworks like cherry blossom.'
  s.homepage = 'http://eclipse.moe'
  s.license = { :type => 'Copyright', :text => 'Copyright (c) 2017 Yae Sakura. All rights reserved.' }
  s.authors = { 'Buka' => '949886@qq.com' }
  s.source = { :git => './' }
  s.platform = :ios, '8.0'
  s.requires_arc = true
  s.source_files = '**/*.swift'
  s.exclude_files = 'SakuraTests/**/*.swift'
  s.vendored_libraries = '**/*.a'
  s.frameworks = 'Foundation'
end

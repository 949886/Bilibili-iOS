platform :ios, "10.0"
use_frameworks!
workspace 'Bilibili.xcworkspace'

def pods
   
   #Frameworks
   pod 'RxSwift', '~> 5'
   pod 'R.swift', '~>5.1'
   pod 'SnapKit', '~>5.0.0'
   pod 'Kingfisher', '~> 5.13'
   pod 'CryptoSwift', '~>1.3'
   pod 'IBAnimatable', '~>6.0'
   pod 'Zip', '~> 1.1'
   pod 'Hero', '~> 1.5'
   pod 'SwiftyUserDefaults', '~>5.0'
   pod 'HandyJSON', '~> 5.0.1'
   pod 'GPUImage3', :podspec => './Bilibili/Podspec/GPUImage3.podspec'
   #pod 'Spring', :git => 'https://github.com/MengTo/Spring.git', :branch => 'swift5'
   
   #Frameworks
   pod 'MJRefresh', '~>3.3'
   pod 'WebViewJavascriptBridge', '~> 6.0'
   
   #Debug
   pod 'Reveal-SDK', '~> 4', :configurations => ['Debug']
   
   #Local
   pod 'Sakura', :path => './Sakura'

end

target :Bilibili do
    project 'Bilibili/Bilibili.xcodeproj'
    pods

    target 'BilibiliTests' do
        inherit! :search_paths
    end
    
    target 'BilibiliUITests' do
        inherit! :search_paths
    end
end

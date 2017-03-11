platform :ios, "8.0"
use_frameworks!
workspace 'Bilibili.xcworkspace'

def pods
   
   #Frameworks
   pod 'RxSwift', '~>3.2'
   pod 'R.swift', '~>3.1'
   pod 'SnapKit', '~>3.1'
   pod 'Kingfisher', '~> 3.3'
   pod 'CryptoSwift', '~>0.6'
   pod 'IBAnimatable', '~>3.0'
   pod 'Zip', '~> 0.6'
   pod 'Hero', '~> 0.3'
   pod 'SwiftyUserDefaults', '~>3.0'
   pod 'GPUImage2', :podspec => './Bilibili/Podspec/GPUImage2.podspec'
   pod 'HandyJSON', :git => 'https://github.com/alibaba/HandyJSON.git'
   pod 'Spring', :git => 'https://github.com/MengTo/Spring.git', :branch => 'swift3'
   
   #Frameworks
   pod 'MJRefresh', '~>3.1'
   pod 'WebViewJavascriptBridge', '~> 5.0'
   
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

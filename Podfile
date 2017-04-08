platform :ios, '9.3'

use_frameworks!

def pods 
  pod 'Alamofire'
  pod 'Reqres', :configurations => ['Debug']
  pod 'ObjectMapper'
  pod 'Kingfisher'
  pod 'Reveal-SDK', :configurations => ['Debug']
end

target 'PremierSwift' do
  pods
end

target 'PremierSwiftTests' do
  pods
  pod 'OHHTTPStubs', :configurations => ['Debug']
  pod 'OHHTTPStubs/Swift', :configurations => ['Debug']
end

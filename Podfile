platform :ios, '9.3'

use_frameworks!

def pods 
  pod 'Alamofire'
  pod 'Reqres', :configurations => ['Debug']
  pod 'ObjectMapper'
  pod 'Kingfisher'
end

target 'Premier' do
  pods
  pod 'OHHTTPStubs', :configurations => ['Debug']
  pod 'OHHTTPStubs/Swift', :configurations => ['Debug']
end

target 'PremierTests' do
  pods
  pod 'OHHTTPStubs', :configurations => ['Debug']
  pod 'OHHTTPStubs/Swift', :configurations => ['Debug']
end

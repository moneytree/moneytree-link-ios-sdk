
Pod::Spec.new do |s|  
  s.name              = 'MoneytreeLinkSDK'
  s.version           = '6.0.1'
  s.summary           = 'Official Moneytree Link SDK for iOS apps to access the features provided by the Moneytree Link Platform'
  s.homepage          = 'https://getmoneytree.com'

  s.author            = { 'Moneytree Financial Technology Pty Ltd' => 'info@getmoneytree.com' }
  s.license           = { :type => 'MIT', :file => 'LICENSE.md' }

  s.platform          = :ios
  
  s.source            = { :git => 'https://github.com/moneytree/moneytree-link-ios-sdk.git', :tag => 'v6.0.1-1536' }
  s.ios.deployment_target = '9.0'
  s.ios.vendored_frameworks = 'Lib/MoneytreeIntelligence.xcframework', 'Lib/MoneytreeLINKKit.xcframework', 'Lib/MoneytreeKeychainUtils.xcframework', 'Lib/MoneytreeLinkCoreKit.xcframework'
end
    

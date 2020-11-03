# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'podtest2' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

	pod 'localpodtest', :path => '../podtest/libs/lib/localpodtest-0.0.1'
  
  pod 'localpod2', :path => 'libs/lib'
  
  pod 'AFNetworking', '~>3.0'
  pod 'ReactiveObjC', '~> 3.0'

  # Pods for podtest2

  target 'podtest2Tests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'podtest2UITests' do
    # Pods for testing
  end

end

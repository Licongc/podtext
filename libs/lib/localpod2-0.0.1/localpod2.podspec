Pod::Spec.new do |s|
  s.name = "localpod2"
  s.version = "0.0.1"
  s.summary = "localpod2."
  s.license = "MIT"
  s.authors = {"licc"=>"congcong.li@lvyuetravel.com"}
  s.homepage = "http://EXAMPLE/localpod2"
  s.description = "A short description of localpad2"
  s.source = { :path => '.' }

  s.ios.deployment_target    = '9.0'
  s.ios.vendored_framework   = 'ios/localpod2.embeddedframework/localpod2.framework'
  
end

Pod::Spec.new do |s|

	s.name		   = "STWTabBarController"
	s.version	   = "0.0.3"
	s.summary      = "A swift slidable UITabBarController"
    s.description  = <<-DESC
                   STWTabBarController is an UITabBarController subclass in order to have a sliding TabBarController with item indicator.
                   DESC
    
 	s.homepage 	   = "https://github.com/SteeweGriffin/STWTabBarController"
	s.license 	   = { :type => "MIT", :file => 'LICENSE'}
	
  	s.author 	   = { "Raffaele Cerullo" => "me@steewe.com" }
    s.social_media_url = "https://twitter.com/Steewitter"
    
    s.source 	   = { :git => "https://github.com/SteeweGriffin/STWTabBarController.git", :tag => s.version.to_s }
    
    s.source_files = "STWTabBarController/*.swift"
    s.requires_arc = true
    s.ios.deployment_target = '9.0'
end
Pod::Spec.new do |s|

  s.platform = :ios
  s.ios.deployment_target = '10.0'
  s.name = "DeepNavigator"
  s.description = "A smooth deeplinks handler that can be used with observers"
  s.requires_arc = true
  s.summary = "Handling deeplinks in a more civilized way"
  s.version = "0.1.3"
  
  s.license = { :type => "MIT", :file => "../LICENSE" }
  s.author = { "HungerStation iOS Team" => "qutaibah.essa@hungerstation.com, ammar.tahhan@hungerstation.com" }
  s.homepage = "https://github.com/HungerStation/DeepNavigator"
  s.source = { :git => "https://github.com/HungerStation/DeepNavigator.git",
  :tag => "#{s.version}" }
  s.source_files = "DeepNavigator/**/*.{swift}"
  s.swift_version = "4.0"
  
  end
  
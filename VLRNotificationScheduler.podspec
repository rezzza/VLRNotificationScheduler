Pod::Spec.new do |s|
  s.name         = 'VLRNotificationScheduler'
  s.version      = '0.9'
  s.summary      = 'Simple notification scheduler using thresholds'
  s.homepage     = 'https://github.com/rezzza/VLRNotificationScheduler'

  s.description  = 'Simple notification scheduler using thresholds'

  s.license      = { :type => 'MIT', :file => 'LICENSE' }
  s.author       = { "Lucas Ortis" => "lucas.ortis@verylastroom.com" }

  s.source       = { :git => "https://github.com/rezzza/VLRNotificationScheduler.git", 
                     :tag => "v0.9" }

  s.platform = :ios, '6.0'
  s.requires_arc = true

  s.source_files = 'VLRNotificationScheduler'
end
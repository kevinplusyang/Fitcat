# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'FitCat2' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

  # Pods for FitCat2
pod 'Alamofire', '~> 4.0'
 pod 'SwiftyJSON'
platform :ios, '10.1'
pod 'JBChartView'
pod 'Google/SignIn'
pod 'RealmSwift', '~> 2.1.2'

post_install do |installer|
    installer.pods_project.targets.each do |target|
      target.build_configurations.each do |config|
        config.build_settings['SWIFT_VERSION'] = '3.0'
      end
    end
  end


  target 'FitCat2Tests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'FitCat2UITests' do
    inherit! :search_paths
    # Pods for testing
  end


end

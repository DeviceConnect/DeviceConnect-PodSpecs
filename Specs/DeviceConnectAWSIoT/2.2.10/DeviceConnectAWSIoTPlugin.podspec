# TODO: plistの変数展開はどうすれば良いだろうか。
Pod::Spec.new do |s|
    
    s.name         = "DeviceConnectAWSIoTPlugin"
    s.version      = "2.2.10"
    s.summary      = "Device Connect Plugin for AWSIoT"
    
    s.description  = <<-DESC
    A Device Connect plugin for AWSIoT.
    Device Connect is an IoT solution for interconnecting various modern devices.
    Also available in Android: https://github.com/DeviceConnect/DeviceConnect-Android .
    DESC
    
    s.homepage     = "https://github.com/DeviceConnect/DeviceConnect-iOS"
    # s.screenshots  = "www.example.com/screenshots_1.gif", "www.example.com/screenshots_2.gif"
    
    s.license      = {:type => "MIT", :file => "LICENSE.TXT"}
    
    s.author       = "NTT DOCOMO, INC."
    # s.authors            = { "NTT DOCOMO, INC." => "*****@*****" }
    # s.social_media_url   = "https://www.facebook.com/docomo.official"
    
    # プロパティのweak属性と、automatic property synthesisをサポートするために6.0以降が必要。
    s.platform     = :ios, "9.0"
    
    s.source       = {
        :git => "https://github.com/DeviceConnect/DeviceConnect-iOS", :tag => "v2.2.10-release-20171228"
    }
    
    # エンドターゲット（アプリとか）のDebugビルドの際、対応するアーキテクチャが含まれていない
    # という旨で提供するライブラリがビルドされない問題への対処。
    s.pod_target_xcconfig = { 'ONLY_ACTIVE_ARCH' => 'NO' }
    
    common_resource_exts = "plist,lproj,storyboard,strings,xcdatamodeld,png"
    base_path = "dConnectDevicePlugin/dConnectDeviceAWSIoT"
    
    s.private_header_files = base_path + "/dConnectDeviceAWSIoT/Classes/**/*.h"
    s.source_files = base_path + "/dConnectDeviceAWSIoT/Classes/**/*.{h,m}"
    s.resource_bundles = {"dConnectDeviceAWSIoT_resources" => [base_path + "/dConnectDeviceAWSIoT/Resources/**/*.{#{common_resource_exts}}"]}
    
    s.dependency "DeviceConnectSDK"
    s.dependency "AWSIoT"
    
end

Pod::Spec.new do |s|
    
    s.name         = "DeviceConnectHitoePlugin"
    s.version      = "2.2.10"
    s.summary      = "Device Connect Plugin for Hitoe"
    
    s.description  = <<-DESC
    A Device Connect plugin for Hitoe.
    
    iOS simulator is not supported (Hitoe SDK does not have required architecture slices for building iOS simulator executable).
    
    Device Connect is an IoT solution for interconnecting various modern devices.
    Also available in Android: https://github.com/DeviceConnect/DeviceConnect-Android .
    DESC
    
    s.homepage     = "https://github.com/DeviceConnect/DeviceConnect-iOS"
    
    s.license      = {:type => "MIT", :file => "LICENSE.TXT"}
    
    s.author       = "NTT DOCOMO, INC."
    # s.authors            = { "NTT DOCOMO, INC." => "*****@*****" }
    # s.social_media_url   = "https://www.facebook.com/docomo.official"
    
    # プロパティのweak属性と、automatic property synthesisをサポートするために6.0以降が必要。
    s.platform     = :ios, "9.0"
    
    s.source       = {
        :git => "https://github.com/DeviceConnect/DeviceConnect-iOS", :tag => "v2.2.10-release-20171228"

    }
    
    s.pod_target_xcconfig = {
    # エンドターゲット（アプリとか）のDebugビルドの際、対応するアーキテクチャが含まれていない
    # という旨で提供するライブラリがビルドされない問題への対処。
        'ONLY_ACTIVE_ARCH' => 'NO',
        'ENABLE_BITCODE' => 'NO'
    }
    
    common_resource_exts = "plist,lproj,storyboard,strings,xcdatamodeld,png"
            base_path = "dConnectDevicePlugin/dConnectDeviceHitoe"
    
    # エンドターゲット（アプリとか）のプリコンパイルドヘッダー汚染の恐れあり。
    s.public_header_files = base_path + "/dConnectDeviceHitoe/Headers/*.h"
    s.source_files = base_path + "/dConnectDeviceHitoe/Headers/*.h", base_path + "/dConnectDeviceHitoe/Classes/**/*.{h,m}"
    s.resource_bundles = {"dConnectDeviceHitoe_resources" => [base_path + "/dConnectDeviceHitoe/Resources/**/*.{#{common_resource_exts}}", base_path + "/RobotoUIKit.bundle"]}
    
    s.frameworks = "CoreGraphics", "CoreBluetooth", "CoreData"
    s.dependency "DeviceConnectSDK"
    s.dependency "DeviceConnectPluginSDK"
    s.vendored_frameworks = base_path + "/hitoeAPI.framework"
    
end

# TODO: RobotKitをCocoaPodsで導入できるようにできないか検討。使用SDKの入手元とバージョン要チェック。
# TODO: plistの変数展開はどうすれば良いだろうか。
Pod::Spec.new do |s|
    
    s.name         = "DeviceConnectSpheroPlugin"
    s.version      = "2.0.0"
    s.summary      = "Device Connect Plugin for Sphero"
    
    s.description  = <<-DESC
    A Device Connect plugin for Sphero.
    
    iOS simulator is not supported (Sphero SDK does not have required architecture slices for building iOS simulator executable).
    
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
        :git => "https://github.com/DeviceConnect/DeviceConnect-iOS", :tag => "2.0.0"
    }
    
    s.pod_target_xcconfig = {
        # エンドターゲット（アプリとか）のDebugビルドの際、対応するアーキテクチャが含まれていない
        # という旨で提供するライブラリがビルドされない問題への対処。
        'ONLY_ACTIVE_ARCH' => 'NO'
        'ENABLE_BITCODE' => 'NO'
    }
    
    common_resource_exts = "plist,lproj,storyboard,strings,xcdatamodeld,png"
            base_path = "dConnectDevicePlugin/dConnectDeviceSphero"
    
    # エンドターゲット（アプリとか）のプリコンパイルドヘッダー汚染の恐れあり。
    s.prefix_header_file = base_path + "/dConnectDeviceSphero/dConnectDeviceSphero-Prefix.pch"
    s.public_header_files = base_path + "/dConnectDeviceSphero/Headers/*.h"
    s.source_files = base_path + "/dConnectDeviceSphero/Headers/*.h", base_path + "/dConnectDeviceSphero/Classes/**/*.{h,m}"
    s.resource_bundles = {"dConnectDeviceSphero_resources" => [base_path + "/dConnectDeviceSphero/Resources/**/*.{#{common_resource_exts}}", base_path + "/RobotoUIKit.bundle"]}
    
    # libstdc++.dylibだけでOKなはずなのだが、stdc++.6.dylibやstdc++.6.0.9.dylib
    # などでないとGNU C++関連のシンボル解決に失敗するので、その対処。
    s.libraries = "stdc++", "stdc++.6"
    s.frameworks = "ExternalAccessory", "CoreMotion"
    s.dependency "DeviceConnectSDK"
    s.dependency "DeviceConnectPluginSDK"
    s.vendored_frameworks = base_path + "/RobotKit.framework", base_path + "/RobotUIKit.framework"
    
end

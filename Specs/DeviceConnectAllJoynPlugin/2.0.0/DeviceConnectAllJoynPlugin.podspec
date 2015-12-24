# TODO: plistの変数展開はどうすれば良いだろうか。
Pod::Spec.new do |s|
    
    s.name         = "DeviceConnectAllJoynPlugin"
    s.version      = "2.0.0"
    s.summary      = "Device Connect Plugin for AllJoyn"
    
    s.description  = <<-DESC
    A Device Connect plugin for AllJoyn.
    
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
    s.platform     = :ios, "8.0"
    
    s.source       = {
        :git => "https://github.com/Shigerelloooo/DeviceConnect-iOS", :branch => "modify_cocoapods_support"
    }
    
    s.pod_target_xcconfig = {
        # エンドターゲット（アプリとか）のDebugビルドの際、対応するアーキテクチャが含まれていない
        # という旨で提供するライブラリがビルドされない問題への対処。
        'ONLY_ACTIVE_ARCH' => 'NO',
        'GCC_ENABLE_CPP_RTTI' => 'NO',
        'GCC_PREPROCESSOR_DEFINITIONS' => "NS_BLOCK_ASSERTIONS=1 QCC_OS_GROUP_POSIX=1 QCC_OS_DARWIN=1"
    }
    
    common_resource_exts = "plist,lproj,storyboard,strings,xcdatamodeld,png"
    base_path = "dConnectDevicePlugin/dConnectDeviceAllJoyn"
    
    s.preserve_path = base_path + "/dConnectDeviceAllJoyn/Resources/AllJoynIntrospectionXML/*"
    
    # エンドターゲット（アプリとか）のプリコンパイルドヘッダー汚染の恐れあり。
    s.prefix_header_file = base_path + "/dConnectDeviceAllJoyn/Supporting Files/dConnectDeviceAllJoyn-Prefix.pch"
    s.private_header_files = base_path + "/dConnectDeviceAllJoyn/Sources/**/*.h", base_path + "/deps/AllJoynFramework/AllJoynFramework_iOS.h"
    s.source_files = base_path + "/dConnectDeviceAllJoyn/Sources/**/*.{h,m,mm}", base_path + "/deps/AllJoynFramework/AllJoynFramework_iOS.h"
    s.resource_bundles = {"dConnectDeviceAllJoyn_resources" => [base_path + "/dConnectDeviceAllJoyn/Resources/**/*.{#{common_resource_exts},jpg}"]}
    
    s.dependency "DeviceConnectSDK"
    s.dependency "AllJoynCoreSDK", "15.04.00.b" # ./AllJoynCoreSDK.podspec を要公開
    
end

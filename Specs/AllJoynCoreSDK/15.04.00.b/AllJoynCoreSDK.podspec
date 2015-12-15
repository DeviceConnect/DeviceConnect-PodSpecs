Pod::Spec.new do |s|
    
    s.name         = "AllJoynCoreSDK"
    s.version      = "15.04.00.b"
    s.summary      = "AllJoyn Core SDK"
    
    s.description  = <<-DESC
    AllJoyn Core SDK for iOS.
    DESC
    
    s.homepage     = "https://github.com/DeviceConnect/DeviceConnect-iOS"
    
    s.license      = {:type => "ISCL", :text => <<-LICENSE
        See https://allseenalliance.org/license .
        LICENSE
    }
    
    s.author       = "AllSeen Alliance, Inc."
    
    # プロパティのweak属性と、automatic property synthesisをサポートするために6.0以降が必要。
    s.platform     = :ios, "8.0"
    
    s.source = {
        :http => "https://allseenalliance.org/releases/alljoyn/15.04/alljoyn-15.04.00b-osx_ios-sdk.zip",
        :sha1 => "3c34a0215eac22eadd2a7c8521bade8a88400913" # SHA1 calculated on 2015 Dec. 15.
    }
    
    s.xcconfig = {
        # エンドターゲット（アプリとか）のDebugビルドの際、対応するアーキテクチャが含まれていない
        # という旨で提供するライブラリがビルドされない問題への対処。
        'ONLY_ACTIVE_ARCH' => 'NO',
        'GCC_ENABLE_CPP_RTTI' => 'NO',
        'GCC_PREPROCESSOR_DEFINITIONS' => "NS_BLOCK_ASSERTIONS=1 QCC_OS_GROUP_POSIX=1 QCC_OS_DARWIN=1"
    }
    
    zip_root = "alljoyn-15.04.00b-osx_ios-sdk"
    lib_base_path = zip_root + "/build/darwin"
    header_root = zip_root + "/header_root"
    # CocoaPodsではヘッダーのディレクトリ構造の保持を1つのディレクトリ以下に適用するのみで
    # 複数には適用できない。これにより、alljoyn_objc以下の「about/inc/**/*.h」や
    # 「cpp/inc/**/*.h」の複数ディレクトリ構造を保持できないので、これらヘッダーの必要なデ
    # ィレクトリ構造をルートとなるディレクトリ以下に集め、そのルートディレクトリ以下のディレ
    # クトリ構造をCocoaPodsに保持させる。
    s.prepare_command = <<-CMD
    mkdir #{header_root}
    cp -R \
    #{zip_root}/alljoyn_objc/AllJoynFramework/AllJoynFramework/*.h \
    #{lib_base_path}/arm/iphoneos/release/dist/about/inc/* \
    #{lib_base_path}/arm/iphoneos/release/dist/cpp/inc/* \
    #{header_root}
    CMD
    
    s.preserve_paths = zip_root + "/README.md", zip_root + "/README.txt", zip_root + "/ReleaseNotes.txt", zip_root + "/manifest.txt"
    
    s.header_mappings_dir = header_root
    s.source_files = header_root + "/**/*.h"
    
    s.vendored_libraries = lib_base_path + "/arm/{iphoneos,iphonesimulator}/release/dist/about/lib/*.a", # about: armv7 arm64 i386 x86_64
    lib_base_path + "/arm/iphoneos/release/dist/cpp/lib/lib{ajrouter,alljoyn}.a", # cpp: armv7
    lib_base_path + "/arm64/iphoneos/release/dist/cpp/lib/lib{ajrouter,alljoyn}.a", # cpp: arm64
    lib_base_path + "/x86/release/dist/cpp/lib/lib{ajrouter,alljoyn}.a" # cpp: i386 x86_64
    
    # TODO: libAllJoynFramework_iOS.aがGNU C++実装を使っているせいでClang C++実装に統一できないので、フレームワークはソースからビルドするようにする。
    s.library = "c++", "stdc++.6"
    s.dependency "OpenSSL-Static", "1.0.2.c1"
    
end

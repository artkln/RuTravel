platform :ios, '11.0'

use_frameworks!
inhibit_all_warnings!

def utils
    pod 'SwiftGen', '~> 6.1.0'
    pod 'SwiftLint', '~> 0.30.1'

    pod 'FirebaseAnalytics'
    pod 'FirebaseAuth'
    pod 'FirebaseFirestore'
end

def surf_utils
	# Put needed utils from SurfUtils here
end

def surf_lib
    pod 'PluggableApplicationDelegate'
    # And other Surf pods, like NodeKit
end

def common_pods
    utils
    surf_utils
    surf_lib

    # Put your pods here
end

target 'RuTravel' do
    common_pods
end

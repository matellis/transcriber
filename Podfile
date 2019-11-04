# https://github.com/CocoaPods/CocoaPods
#
# Secrets management: https://github.com/orta/cocoapods-keys

platform :macos, '10.15'

target 'Transcriber' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for Transcriber
  pod 'SwiftFormat/CLI'
  pod 'SwiftLint' # TODO: This isn't set up properly -- messages don't show, and builds don't fail!
  pod 'PathKit'

  target 'TranscriberTests' do
    inherit! :search_paths
    # Pods for testing
  end

  # TODO: Abandon the UI stuff entirely.
  target 'TranscriberUITests' do
    # Pods for testing
  end
end

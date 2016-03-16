#
# Be sure to run `pod lib lint Tryouts.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
    s.name             = "Tryouts"
    s.version          = "0.1.5"
    s.summary          = "Tryouts SDK for beta distribution, version updates and tester feedback"
    s.description      = <<-DESC
    Tryouts SDK allows you to easily gather feedback from your testers
    about your beta releases and notifies them when new versions of your
    app are available. Requires you to use tryouts.io for release
    distribution.
    DESC

    s.homepage         = "https://tryouts.io"
    s.license          = 'MIT'
    s.author           = { "Taylan Pince" => "taylan@hipolabs.com" }
    s.source           = { :git => "https://github.com/Hipo/Tryouts-iOS-SDK.git", :tag => s.version.to_s }
    s.social_media_url = 'https://twitter.com/tryoutsio'

    s.platform     = :ios, '7.0'
    s.requires_arc = true

    s.source_files = 'Pod/Classes/**/*'
    s.public_header_files = 'Pod/Classes/**/*.h'
end

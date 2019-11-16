#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#
Pod::Spec.new do |s|
  s.name             = 'epub_kitty'
  s.version          = '0.0.1'
  s.summary          = 'A epub reader flutter plugin project.'
  s.description      = <<-DESC
A new flutter plugin project.
                       DESC
  s.homepage         = 'https://github.com/451518849/epub_kitty.git'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'xiaofwang' => '451518849@qq.com' }
  s.source           = { :path => '.' }
  
  s.swift_version = '4.2'
  s.requires_arc  = true
  
  s.source_files = [
  'Classes/**/*',
  'Source/*.{h,swift}',
  'Source/**/*.swift',
  'Vendor/**/*.swift',
  ]
  
  s.resources = [
    'Source/**/*.{js,css}',
    'Source/Resources/*.xcassets',
    'Source/Resources/Fonts/**/*.{otf,ttf}'
  ]
  s.public_header_files = [
  'Classes/**/*.h',
  'Source/*.h',
  ]
  
  s.dependency 'Flutter'
  
  s.libraries  = "z"
  s.dependency 'SSZipArchive', '2.1.1'
  s.dependency 'MenuItemKit', '3.1.3'
  s.dependency 'ZFDragableModalTransition', '0.6'
  s.dependency 'AEXML', '4.3.3'
  s.dependency 'FontBlaster', '4.1.0'
  s.dependency 'RealmSwift', '3.17.3'
  
  s.ios.deployment_target = '9.0'
end

#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#
Pod::Spec.new do |s|
  s.name             = 'epub_kitty_lib'
  s.version          = '0.1.8'
  s.summary          = 'A epub reader flutter plugin project.'
  s.description      = <<-DESC
A new flutter plugin project.
                       DESC
  s.homepage         = 'https://github.com/zfinix/epub_kitty.git'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Chiziaruhoma' => 'chiziaruhoma@gmail.com' }
  s.source           = { :path => '.' }
  
  
  s.source_files = [
  'Classes/**/*',
  ]

  s.dependency 'Flutter'
  
  s.dependency 'epub_kitty_ios_lib', '0.1.2'
  s.dependency "Realm"
  s.ios.deployment_target = '9.0'

  
end

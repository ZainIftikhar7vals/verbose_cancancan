
Gem::Specification.new do |spec|
  spec.name    = 'verbose_cancancan'
  spec.authors = ['Zain Iftikhar']
  spec.email   = ['zainiftikhar22322@gmail.com']
  spec.version = '0.0.6'
  spec.summary = 'A verbose extension for CanCanCan that prints the location of matching rule definitions and authorization hooks.'

  spec.description = <<~EOF
    This CanCanCan extension displays the location where selected rule for authorization was defined and also prints the locations where load_and_authorize_resource and authorize! hooks are defined.
  EOF

  spec.license = 'MIT'

  spec.files   = Dir['lib/**/*.rb']
  spec.required_ruby_version = '>= 2.7.0'

  spec.add_dependency 'cancancan'
  spec.add_dependency "activesupport", ">= 6.0"
  spec.add_dependency "railties", ">= 6.0"

  spec.post_install_message = 'Thanks for installing!'

  spec.metadata = {
  "bug_tracker_uri"   => "https://github.com/ZainIftikhar7vals/verbose_cancancan/issues",
  "documentation_uri" => "https://github.com/ZainIftikhar7vals/verbose_cancancan",
  "homepage_uri"      => "https://github.com/ZainIftikhar7vals/verbose_cancancan"
}
end

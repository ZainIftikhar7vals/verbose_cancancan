
Gem::Specification.new do |spec|
  spec.name    = 'verbose_cancancan'
  spec.authors = ['Zain Iftikhar']
  spec.email   = ['zainiftikhar22322@gmail.com']
  spec.version = '0.0.1'
  spec.summary = 'A verbose extension for CanCanCan that prints the location of matching rule definitions and authorization hooks.'
  spec.homepage    = 'https://github.com/ZainIftikhar7vals/verbose_cancancan'

  spec.description = <<~EOF
    This gem displays the location where a rule was defined and prints the locations where load_and_authorize_resource and authorize! hooks are defined.
  EOF

  spec.license = 'MIT'

  spec.files   = Dir['lib/**/*.rb']
  spec.required_ruby_version = '>= 2.7.0'

  spec.add_dependency 'cancancan'

  spec.post_install_message = 'Thanks for installing!'
end

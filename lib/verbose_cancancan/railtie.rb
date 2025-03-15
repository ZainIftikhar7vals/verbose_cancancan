require 'verbose_cancancan/ability'
require 'verbose_cancancan/rule'
require 'verbose_cancancan/controller_resource'

module VerboseCancancan
  class Railtie < Rails::Railtie

    initializer 'verbose_cancancan.patch_cancancan' do
      CanCan::Rule.prepend(Rule)
      CanCan::Ability.prepend(Ability)

      CanCan::ControllerResource.singleton_class.prepend(ControllerResource)
    end

  end
end

module VerboseCancancan
  module ControllerResource

    extend ActiveSupport::Concern

    prepended do
      delegate :cleaner_backtrace, :logger, :colourize, to: VerboseCancancan, prefix: :verb
    end

    def add_before_action(controller_class, method, *args)
      options = args.extract_options!
      resource_name = args.first
      before_action_method = before_callback_name(options)
      bk_trace = verb_cleaner_backtrace(caller).first

      controller_class.send(before_action_method, options.slice(:only, :except, :if, :unless)) do |controller|

        controller.class
                  .cancan_resource_class
                  .log_hook_added(method, controller_class, resource_name, bk_trace)


        controller.class.cancan_resource_class
                  .new(controller, resource_name, options.except(:only, :except, :if, :unless)).send(method)
      end
    end

    def log_hook_added(method, controller_class, resource_name, bk_trace)
      return if method.to_s.exclude? 'authorize_resource'

      log_msg = [verb_colourize('[⏳ CanCan Hook Added]', :orange), "(#{method})"]
      log_msg << "for #{resource_name}" if resource_name
      log_msg += ["on #{controller_class}", "\n  ↳  #{bk_trace}"]

      verb_logger.info log_msg.join(' ')
    end

  end
end

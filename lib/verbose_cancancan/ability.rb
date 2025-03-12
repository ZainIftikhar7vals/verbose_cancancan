module VerboseCancancan
  module Ability

    extend ActiveSupport::Concern

    prepended do
      delegate :colourize, :logger, to: VerboseCancancan, prefix: :verb
    end

    def can?(action, subject, attribute = nil, *extra_args)
      match = extract_subjects(subject).lazy.map do |a_subject|
        relevant_rules_for_match(action, a_subject).detect do |rule|
          rule.matches_conditions?(action, a_subject, attribute, *extra_args) && rule.matches_attributes?(attribute)
        end
      end.reject(&:nil?).first

      log_rule(match, action, subject) if log_rule?

      match ? match.base_behavior : false
    end

    # Only logged the rule if authorize! or load_and_authorize! is called, to avoid cluttering the terminal due to can? checks. 
    def log_rule? = caller.find { |path| path.include?('authorize!') }

    def log_rule(matched_rule, action, subject)
      subject = pretty_subject(subject)

      if matched_rule
        verb_logger.info matched_rule_info(matched_rule, subject, action)
      else
        verb_logger.info no_rule_matched(subject, action)
      end
    end

    def matched_rule_info(rule, subject, action) 
      auth_status = rule.base_behavior ? auth_success : auth_failed
      rule_type   = rule.base_behavior ? 'Can' : 'Cannot'

      "#{auth_status} Rule of #{rule_type} type applied for #{verb_colourize(subject, :magenta)} (Action: #{verb_colourize(action, :green)})\n  ↳  #{rule.path}"
    end

    def no_rule_matched(subject, action)
      "#{auth_failed} No matching rule for #{verb_colourize(subject, :magenta)} (Action: #{verb_colourize(action, :green)})"
    end

    def pretty_subject(subject)
      if subject.is_a?(ActiveRecord::Base)
        # In case of member actions subject is `ActiveRecord::Base`

        "#{subject.class.name} (ID: #{subject.id})"
      else
        # In case of Collection actions subject can be
        #  1. Hash if resources are being loaded through parent. => { parent_resource => resource_class }
        #  2. ActiveRecord::Model if if resources are not loaded through parent.

        orignal_subject = subject.is_a?(Hash) ? subject.values.first : subject

        orignal_subject.respond_to?(:name) ? orignal_subject.name : orignal_subject
      end
    end

    def auth_failed  = verb_colourize('[❌ AUTHORIZATION FAILED]', :red)

    def auth_success = verb_colourize('[✅ AUTHORIZATION SUCCESS]', :green)

  end
end

module VerboseCancancan
  module Rule
    extend ActiveSupport::Concern

    prepended do
      attr_reader :path

      delegate :cleaner_backtrace, to: VerboseCancancan, prefix: :verb
    end

    def initialize(...)
      @path = verb_cleaner_backtrace(caller).first
      super
    end
  end
end

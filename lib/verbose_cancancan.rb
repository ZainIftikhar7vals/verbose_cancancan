require 'verbose_cancancan/railtie'

module VerboseCancancan

  class << self

    def logger = Rails.logger

    def cleaner_backtrace(locations)
      bk_trace = ActiveSupport::BacktraceCleaner.new
      root     = "#{Rails.root}/"
      bk_trace.add_filter { |line| line.delete_prefix(root) }

      bk_trace.clean(locations)
    end

    # TODO: Refactor Coloring approch.
    def colourize(msg, color)
      colors = {
        clear:   "\e[0m",
        red:     "\e[1;31m",
        green:   "\e[1;92m",
        magenta: "\e[1;95m",
        yellow:  "\e[1;93m",
        orange:  "\e[1;38;5;214m",
        cyan:    "\e[1;96m"
      }

      "#{colors[color]}#{msg}#{colors[:clear]}"
    end

  end
end

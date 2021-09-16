# frozen_string_literal: true

module ActiveSupport
  module NumberHelper
    class RoundingHelper # :nodoc:
      class << self
        def round(number, options)
          precision = absolute_precision(number, options)
          return number unless precision

          rounded_number = convert_to_decimal(number, options).round(precision, options.fetch(:round_mode, :default).to_sym)
          rounded_number.zero? ? rounded_number.abs : rounded_number # prevent showing negative zeros
        end

        def digit_count(number, options)
          return 1 if number.zero?
          (Math.log10(number.abs) + 1).floor
        end

        private
          def convert_to_decimal(number, options)
            case number
            when Float, String
              BigDecimal(number.to_s)
            when Rational
              BigDecimal(number, digit_count(number.to_i, options) + options[:precision])
            else
              number.to_d
            end
          end

          def absolute_precision(number, options)
            if options[:significant] && options[:precision] > 0
              options[:precision] - digit_count(convert_to_decimal(number, options), options)
            else
              options[:precision]
            end
          end
      end
    end
  end
end

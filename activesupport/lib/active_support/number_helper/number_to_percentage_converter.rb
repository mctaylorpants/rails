# frozen_string_literal: true

require "active_support/number_helper/number_converter"

module ActiveSupport
  module NumberHelper
    class NumberToPercentageConverter < NumberConverter # :nodoc:
      self.namespace = :percentage

      def self.convert_plz
        rounded_number = NumberToRoundedConverter.convert(number, options)
        options[:format].gsub("%n", rounded_number)
      end
    end
  end
end

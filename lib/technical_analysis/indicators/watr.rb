module TechnicalAnalysis
  # Weighted Average True Range
  class Watr < Indicator

    # Returns the symbol of the technical indicator
    #
    # @return [String] A string of the symbol of the technical indicator
    def self.indicator_symbol
      "watr"
    end

    # Returns the name of the technical indicator
    #
    # @return [String] A string of the name of the technical indicator
    def self.indicator_name
      "Weighted Average True Range"
    end

    # Returns an array of valid keys for options for this technical indicator
    #
    # @return [Array] An array of keys as symbols for valid options for this technical indicator
    def self.valid_options
      %i(period)
    end

    # Validates the provided options for this technical indicator
    #
    # @param options [Hash] The options for the technical indicator to be validated
    #
    # @return [Boolean] Returns true if options are valid or raises a ValidationError if they're not
    def self.validate_options(options)
      Validation.validate_options(options, valid_options)
    end

    # Calculates the minimum number of observations needed to calculate the technical indicator
    #
    # @param options [Hash] The options for the technical indicator
    #
    # @return [Integer] Returns the minimum number of observations needed to calculate the technical
    #    indicator based on the options provided
    def self.min_data_size(period: 16)
      period.to_i + 1
    end

    # Calculates the average true range (ATR) for the data over the given period
    # https://en.wikipedia.org/wiki/Average_true_range
    #
    # @param data [Array] Array of hashes with keys (:date_time, :high, :low, :close)
    # @param period [Integer] The given period to calculate the ATR
    #
    # @return [Array<AtrValue>] An array of AtrValue instances
    def self.calculate(data, period: 14)
      period = period.to_i
      Validation.validate_numeric_data(data, :high, :low, :close)
      Validation.validate_length(data, min_data_size(period: period))
      Validation.validate_date_time_key(data)

      data = data.sort_by { |row| row[:date_time] }

      output = []
      period_values = []
      prev_price = data.shift
      prev_atr_value = nil

      data.each do |v|
        tr = StockCalculation.true_range(v[:high], v[:low], prev_price[:close])

        period_values << tr

        weighting = 1/(period - 2.0)
        remainder = 1.0 - weighting

        if period_values.size == period
          if output.empty?
            atr = ArrayHelper.average(period_values)
          else
            atr = (output.last.atr * (period - 1.0) + tr) / period.to_f
            watr = (weighting * atr) + (remainder * prev_atr_value.atr)
          end

          val = AtrValue.new( date_time: v[:date_time], atr: atr, watr: watr )
          prev_atr_value = val
          output << val

          period_values.shift
        end

        prev_price = v
      end

      output.sort_by(&:date_time).reverse
    end

  end

  # The value class to be returned by calculations
  class AtrValue

    # @return [String] the date_time of the observation as it was provided
    attr_accessor :date_time

    # @return [Float] the atr calculation value
    attr_accessor :atr

    # @return [Float] the weighted atr calculation value
    attr_accessor :watr

    def initialize(date_time: nil, atr: nil, watr: nil)
      @date_time = date_time
      @atr = atr
      @watr = watr
    end

    # @return [Hash] the attributes as a hash
    def to_hash
      { date_time: @date_time, atr: @atr, watr: @watr }
    end
  end
end

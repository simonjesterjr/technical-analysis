module TechnicalAnalysis
  # Bollinger Bands
  class Bb < Indicator

    # Returns the symbol of the technical indicator
    #
    # @return [String] A string of the symbol of the technical indicator
    def self.indicator_symbol
      "bb"
    end

    # Returns the name of the technical indicator
    #
    # @return [String] A string of the name of the technical indicator
    def self.indicator_name
      "Bollinger Bands"
    end

    # Returns an array of valid keys for options for this technical indicator
    #
    # @return [Array] An array of keys as symbols for valid options for this technical indicator
    def self.valid_options
      %i(period standard_deviations price_key)
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
    def self.min_data_size(period: 20, **params)
      period.to_i
    end

    # Calculates the bollinger bands (BB) for the data over the given period
    # https://en.wikipedia.org/wiki/Bollinger_Bands
    #
    # @param data [Array] Array of hashes with keys (:date_time, :value)
    # @param period [Integer] The given period to calculate the BB
    # @param standard_deviations [Float] The given standard deviations to calculate the upper and
    #   lower bands of the BB
    # @param price_key [Symbol] The hash key for the price data. Default :value
    #
    # @return [Array<BbValue>] An array of BbValue instances
    def self.calculate(data, period: 20, standard_deviations: 2, price_key: :value, &block)
      period = period.to_i
      standard_deviations = standard_deviations.to_f
      price_key = price_key.to_sym
      Validation.validate_numeric_data(data, price_key)
      Validation.validate_length(data, min_data_size(period: period))
      Validation.validate_date_time_key(data)

      data = data.sort_by { |row| row[:date_time] }

      output = []
      period_values = []

      data.each_with_index do |v, i|
        period_values << v[price_key]

        if period_values.size == period
          mb = ArrayHelper.average(period_values)
          sd = ArrayHelper.standard_deviation(period_values)
          ub = mb + standard_deviations * sd
          lb = mb - standard_deviations * sd

          current = BbValue.new(
            date_time: v[:date_time],
            lower_band: lb,
            middle_band: mb,
            upper_band: ub
          )

          if output.size > 0
            last = data[i-1]
            direction = nil
            if v[:close] > current.upper_band  && last[:close] < output.last.upper_band
              direction = :long
            elsif v[:close] < current.lower_band  && last[:close] > output.last.lower_band
              direction = :short
            end

            if block_given?
              yield SignalHelper.generate( SignalHelper::BOLLINGER_BREAKOUT, direction, v[:id] ) if direction
            end
          end
          output << current
          period_values.shift
        end
      end

      output.sort_by(&:date_time).reverse
    end

  end

  # The value class to be returned by calculations
  class BbValue

    # @return [String] the date_time of the obversation as it was provided
    attr_accessor :date_time

    # @return [Float] the lower_band calculation value
    attr_accessor :lower_band

    # @return [Float] the middle_band calculation value
    attr_accessor :middle_band

    # @return [Float] the upper_band calculation value
    attr_accessor :upper_band

    def initialize(date_time: nil, lower_band: nil, middle_band: nil, upper_band: nil)
      @date_time = date_time
      @lower_band = lower_band
      @middle_band = middle_band
      @upper_band = upper_band
    end

    # @return [Hash] the attributes as a hash
    def to_hash
      {
        date_time: @date_time,
        lower_band: @lower_band,
        middle_band: @middle_band,
        upper_band: @upper_band
      }
    end

  end
end

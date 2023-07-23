require 'technical-analysis'
require 'spec_helper'

describe 'Indicators' do
  describe "WATR" do
    input_data = SpecHelper.get_test_data(:high, :low, :close)
    indicator = TechnicalAnalysis::Watr

    describe 'Weighted Average True Range' do
      it 'Calculates WATR (14 day)' do
        output = indicator.calculate(input_data, period: 14)
        normalized_output = output.map(&:to_hash)

        expected_output = [
          {:date_time=>"2019-01-09T00:00:00.000Z", :atr=>6.103013600253306, :watr=>6.187841482322449},
          {:date_time=>"2019-01-08T00:00:00.000Z", :atr=>6.195553107965099, :watr=>6.358124160449819},
          {:atr=>6.3729033470393395, :date_time=>"2019-01-07T00:00:00.000Z", :watr=>6.615672172792113},
          {:atr=>6.637742066042365, :date_time=>"2019-01-04T00:00:00.000Z", :watr=>6.65733349377612},
          {:atr=>6.6591145326610075, :date_time=>"2019-01-03T00:00:00.000Z", :watr=>6.006103377912746},
          {:atr=>5.946738727481086, :date_time=>"2019-01-02T00:00:00.000Z", :watr=>6.0402908172393674},
          {:atr=>6.048795552671939, :date_time=>"2018-12-31T00:00:00.000Z", :watr=>6.254608059591112},
          {:atr=>6.273318287492855, :date_time=>"2018-12-28T00:00:00.000Z", :watr=>6.435731756482736},
          {:atr=>6.450496617299998, :date_time=>"2018-12-27T00:00:00.000Z", :watr=>6.404698301853203},
          {:atr=>6.400534818630767, :date_time=>"2018-12-26T00:00:00.000Z", :watr=>6.110764837893193},
          {:atr=>6.084422112371596, :date_time=>"2018-12-24T00:00:00.000Z", :watr=>6.163708286961899},
          {:atr=>6.170916121015564, :date_time=>"2018-12-21T00:00:00.000Z", :watr=>6.004570462882046},
          {:atr=>5.989448130324453, :date_time=>"2018-12-20T00:00:00.000Z", :watr=>5.931588703616561},
          {:atr=>5.926328755734025, :date_time=>"2018-12-19T00:00:00.000Z", :watr=>5.754723732099887},
          {:atr=>5.739123275405874, :date_time=>"2018-12-18T00:00:00.000Z", :watr=>5.890664019184493},
          {:atr=>5.904440450437095, :date_time=>"2018-12-17T00:00:00.000Z", :watr=>5.924497148865352},
          {:atr=>5.926320485086102, :date_time=>"2018-12-14T00:00:00.000Z", :watr=>5.944394365444739},
          {:atr=>5.946037445477343, :date_time=>"2018-12-13T00:00:00.000Z", :watr=>6.120629829453308},
          {:atr=>6.1365018643602145, :date_time=>"2018-12-12T00:00:00.000Z", :watr=>6.3372167394112555},
          {:atr=>6.355463546234078, :date_time=>"2018-12-11T00:00:00.000Z", :watr=>6.465848796289045},
          {:atr=>6.475883819021315, :date_time=>"2018-12-10T00:00:00.000Z", :watr=>6.455849985747178},
          {:atr=>6.4540287281768025, :date_time=>"2018-12-07T00:00:00.000Z", :watr=>6.456428189779014},
          {:atr=>6.456646322651943, :date_time=>"2018-12-06T00:00:00.000Z", :watr=>6.469807281300476},
          {:atr=>6.471003732086706, :date_time=>"2018-12-04T00:00:00.000Z", :watr=>6.324407841400514},
          {:atr=>6.311080942247224, :date_time=>"2018-12-03T00:00:00.000Z", :watr=>6.307631521508248},
          {:atr=>6.307317937804704, :date_time=>"2018-11-30T00:00:00.000Z", :watr=>6.519372407778112},
          {:atr=>6.538650086866604, :date_time=>"2018-11-29T00:00:00.000Z", :watr=>6.640093362222582},
          {:atr=>6.649315478164034, :date_time=>"2018-11-28T00:00:00.000Z", :watr=>6.62106208239355},
          {:atr=>6.618493591868961, :date_time=>"2018-11-27T00:00:00.000Z", :watr=>6.810887370782796},
          {:atr=>6.828377714320418, :date_time=>"2018-11-26T00:00:00.000Z", :watr=>6.979160758278908},
          {:atr=>6.9928683077296805, :date_time=>"2018-11-23T00:00:00.000Z", :watr=>7.155955175582414},
          {:atr=>7.1707812544781175, :date_time=>"2018-11-21T00:00:00.000Z", :watr=>7.414105573704139},
          {:atr=>7.43622596636105, :date_time=>"2018-11-20T00:00:00.000Z", :watr=>7.230767540912148},
          {:atr=>7.212089502234975, :date_time=>"2018-11-19T00:00:00.000Z", :watr=>7.1184547876489805},
          {:atr=>7.109942540868436, :date_time=>"2018-11-16T00:00:00.000Z", :watr=>7.2227942584937725},
          {:atr=>7.233053505550622, :date_time=>"2018-11-15T00:00:00.000Z", :watr=>7.378525227095858},
          {:atr=>7.391749929054517, :date_time=>"2018-11-14T00:00:00.000Z", :watr=>7.310078449692977},
          {:atr=>7.302653769751019, :date_time=>"2018-11-13T00:00:00.000Z", :watr=>7.413553074028333},
          {:atr=>7.423634828962634, :date_time=>"2018-11-12T00:00:00.000Z", :watr=>7.194019336133076},
          {:atr=>7.173145200421298, :date_time=>"2018-11-09T00:00:00.000Z", :watr=>7.238943900451003},
          {:atr=>7.244925600453705, :date_time=>"2018-11-08T00:00:00.000Z", :watr=>7.518157533819029},
          {:atr=>7.542996800488605, :date_time=>"2018-11-07T00:00:00.000Z", :watr=>7.631349138984596},
          {:atr=>7.63938116975696, :date_time=>"2018-11-06T00:00:00.000Z", :watr=>7.957350354803926},
          {:atr=>7.98625664435365, :date_time=>"2018-11-05T00:00:00.000Z", :watr=>7.892915766711918},
          {:atr=>7.884430232380852, :date_time=>"2018-11-02T00:00:00.000Z", :watr=>7.256473389792323},
          {:date_time=>"2018-11-01T00:00:00.000Z", :atr=>7.199386404102457, :watr=>7.3156892915712195},
          {:date_time=>"2018-10-31T00:00:00.000Z", :atr=>7.326262281341107, :watr=>7.3386910319484935},
          {:date_time=>"2018-10-30T00:00:00.000Z", :atr=>7.339820918367347, :watr=>7.44064162414966},
          {:date_time=>"2018-10-29T00:00:00.000Z", :atr=>7.449807142857144, :watr=>nil}
        ]

        expect(normalized_output).to eq(expected_output)
      end

      it "Throws exception if not enough data" do
        expect {indicator.calculate(input_data, period: input_data.size+1)}.to raise_exception(TechnicalAnalysis::Validation::ValidationError)
      end

      it 'Returns the symbol' do
        indicator_symbol = indicator.indicator_symbol
        expect(indicator_symbol).to eq('watr')
      end

      it 'Returns the name' do
        indicator_name = indicator.indicator_name
        expect(indicator_name).to eq('Weighted Average True Range')
      end

      it 'Returns the valid options' do
        valid_options = indicator.valid_options
        expect(valid_options).to eq(%i(period))
      end

      it 'Validates options' do
        valid_options = { period: 22 }
        options_validated = indicator.validate_options(valid_options)
        expect(options_validated).to eq(true)
      end

      it 'Throws exception for invalid options' do
        invalid_options = { test: 10 }
        expect { indicator.validate_options(**invalid_options) }.to raise_exception(TechnicalAnalysis::Validation::ValidationError)
      end

      it 'Calculates minimum data size' do
        options = { period: 4 }
        expect(indicator.min_data_size(**options)).to eq(5)
      end
    end
  end
end

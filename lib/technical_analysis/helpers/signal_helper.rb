class SignalHelper

  BOLLINGER_BREAKOUT = :bollinger_breakout
  MA_CROSSOVER = :ma_crossover
  MA_PRICE_CROSSOVER = :ma_price_crossover
  MA_BREAKOUT = :ma_breakout

  def self.generate( signal, direction, id, notes: nil )
    {
      calling_id: id,
      signal: signal,
      direction: direction.to_s,
      notes: notes.blank? ? "" : notes
    }
  end
end

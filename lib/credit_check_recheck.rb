class CreditCheckRecheck

  attr_reader :card_number, :valid

  def initialize(card_number)
    @card_number = card_number
    @valid = false
  end

  def validate
    string_to_array
    double_every_other_even || double_every_other_odd
    sum_double_digits
    sum_all_digits
    valid?
  end

  def string_to_array
    @card_number = @card_number.split("")
    @card_number.to_a
    @card_number.map! { |num| num.to_i}
  end

  def reverse
    @card_number.reverse! unless @card_number.length.odd?
  end

  def double_every_other_odd
    if card_number.length.odd?
      @card_number = @card_number.map.with_index do |num, index|
        if index.odd?
          num*2
        else
          num
        end
      end
    end
  end

  def double_every_other_even
    if card_number.length.even?
      @card_number = @card_number.map.with_index do |num, index|
        if index.even?
          num*2
        else
          num
        end
      end
    end
  end


  def sum_double_digits
    @card_number = @card_number.map do |num|
      if num.digits.length > 1
        num.digits.sum
      else
        num
      end
    end
  end

  def sum_all_digits
    @card_number = @card_number.sum
  end

  def valid?
    if @card_number % 10 == 0
      @valid = true
    end
    @valid
  end

end

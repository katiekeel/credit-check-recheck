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
    @card_number = card_number.split("")
    card_number.map! {|num| num.to_i}
  end

  def reverse
    @card_number.reverse! unless card_number.length.odd?
  end

  def double_every_other_odd
    if card_number.length.odd?
      nums = []
      card_number.each_with_index do |num, index|
        nums << num if index.even?
        nums << num * 2 if index.odd?
      end
      @card_number = nums
    end
  end

  def double_every_other_even
    if card_number.length.even?
      nums = []
      card_number.each_with_index do |num, index|
        nums << num if index.odd?
        nums << num * 2 if index.even?
      end
      @card_number = nums
    end
  end


  def sum_double_digits
    @card_number = card_number.map {|num| num.digits.sum}

  end

  def sum_all_digits
    @card_number = card_number.sum
  end

  def valid?
    @valid = true if card_number % 10 == 0
    valid
  end

end

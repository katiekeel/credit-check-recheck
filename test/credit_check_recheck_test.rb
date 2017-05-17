require 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/credit_check_recheck'
require 'pry'

class CreditCheckRecheckTest < Minitest::Test

  def test_card_exists
    card = CreditCheckRecheck.new("4832890564887362")
    assert_instance_of CreditCheckRecheck, card
  end

  def test_card_has_a_number
    card = CreditCheckRecheck.new("4832890564887362")
    assert_equal card.card_number, "4832890564887362"
  end

  def test_card_is_invalid_by_default
    card = CreditCheckRecheck.new("4832890564887362")
    refute card.valid
  end

  def test_card_string_turns_to_array_of_numbers
    card = CreditCheckRecheck.new("4832890564887362")
    card.string_to_array
    assert_equal card.card_number, [4, 8, 3, 2, 8, 9, 0, 5, 6, 4, 8, 8, 7, 3, 6, 2]
  end

  def test_card_array_reverses
    card = CreditCheckRecheck.new("4832890564887362")
    card.string_to_array
    card.reverse
    assert_equal card.card_number, [2, 6, 3, 7, 8, 8, 4, 6, 5, 0, 9, 8, 2, 3, 8, 4]
  end

  def test_card_numbers_array_doubles_every_other_number
    card = CreditCheckRecheck.new("4832890564887362")
    card.string_to_array
    card.reverse
    card.double_every_other_even
    assert_equal card.card_number, [4, 6, 6, 7, 16, 8, 8, 6, 10, 0, 18, 8, 4, 3, 16, 4]
  end

  def test_sum_double_digit_numbers
    card = CreditCheckRecheck.new("4832890564887362")
    card.string_to_array
    card.reverse
    card.double_every_other_even
    card.sum_double_digits
    assert_equal card.card_number, [4, 6, 6, 7, 7, 8, 8, 6, 1, 0, 9, 8, 4, 3, 7, 4]
  end

  def test_sum_all_digits
    card = CreditCheckRecheck.new("4832890564887362")
    card.string_to_array
    card.reverse
    card.double_every_other_even
    card.sum_double_digits
    card.sum_all_digits
    assert_equal card.card_number, 88
  end

  def test_card_is_valid
    card = CreditCheckRecheck.new("4832890564887362")
    card.string_to_array
    card.double_every_other_even
    card.sum_double_digits
    card.sum_all_digits
    assert card.valid?
  end

  def test_validate_wrapper_method_works
    card = CreditCheckRecheck.new("4832890564887362")
    card.validate
    assert card.valid?
  end

  def test_invalid_card_is_invalid
    card = CreditCheckRecheck.new("5541801923795240")
    card.validate
    refute card.valid?
  end

  def test_amex_valid_card_is_valid
    card = CreditCheckRecheck.new("342804633855673")
    card.validate
    assert card.valid
  end

  def test_invalid_amex_card_is_invalid
    card = CreditCheckRecheck.new("342801633855673")
    card.validate
    refute card.valid
  end
end

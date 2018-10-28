# frozen_string_literal: true
require "test_helper"

class LeavetimeTest < ActiveSupport::TestCase
  def test_leavetime_with_fulltime_salary
    salary = build(:salary, monthly_wage: 33000, supervisor_allowance: 3000, cycle: :normal)
    payroll = build(:payroll, salary: salary, leavetime_hours: 1)
    assert_equal CalculationService::Leavetime.call(payroll), 150
  end

  def test_leavetime_with_parttime_salary
    salary = build(:salary, monthly_wage: 24000, equipment_subsidy: 800, monthly_wage_adjustment: 0.6, cycle: :normal)
    payroll = build(:payroll, salary: salary, leavetime_hours: 1)
    assert_equal CalculationService::Leavetime.call(payroll), 170
  end

  # 15 business days in 2018-02
  def test_leavetime_with_business_cycle
    salary = build(:salary, monthly_wage: 36000, cycle: :business)
    payroll = build(:payroll, salary: salary, leavetime_hours: 1, year: 2018, month: 2)
    assert_equal CalculationService::Leavetime.call(payroll), 300
  end
end

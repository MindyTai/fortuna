# frozen_string_literal: true
class FixedAmountIncomeService
  attr_reader :payroll, :salary

  def initialize(payroll)
    @payroll = payroll
    @salary = payroll.employee.recent_salary
  end

  def run
    {
      overtime_meals: overtime_meal_subsidy,
      buisness_trip: business_trip_subsidy,
      overtime: overtime,
      vacation_refund: vacation_refund,
    }
  end

  private

  def overtime
    # TODO: 加班費需要能處理多筆和假日
    OvertimeService.new(payroll.overtime_hours, salary).workday
  end

  def vacation_refund
    OvertimeService.new(payroll.vacation_refund_hours, salary).basic
  end

  def overtime_meal_subsidy
    payroll.overtime_meals * overtime_meal_rate
  end

  def business_trip_subsidy
    payroll.business_trip_days * business_trip_rate
  end

  def overtime_meal_rate
    120
  end

  def business_trip_rate
    1000
  end
end

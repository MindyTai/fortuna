# frozen_string_literal: true
class MonthlyBasedIncomeService
  attr_reader :salary, :working_days

  def initialize(salary, working_days)
    @salary = salary
    @working_days = working_days
  end

  def run
    {
      base: base_salary,
      taxfree_lunch: taxfree_lunch,
      equipment_subsidy: salary.equipment_subsidy,
      commuting_subsidy: salary.commuting_subsidy,
      supervisor_allowance: salary.supervisor_allowance,
    }.transform_values { |v| adjust_for_incomplete_month(v) }
  end

  private

  def adjust_for_incomplete_month(amount)
    (amount * working_days / 30)
  end

  def base_salary
    salary.base - taxfree_lunch
  end

  def taxfree_lunch
    1800
  end
end

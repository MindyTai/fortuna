# frozen_string_literal: true
class IncomeService
  include PayrollPeriodCountable

  attr_reader :payroll, :salary

  def initialize(payroll)
    @payroll = payroll
    @salary = payroll.salary
  end

  def boss
    {
      本薪: scale_for_cycle(base_salary),
      伙食費: scale_for_cycle(taxfree_lunch),
    }.merge(extra_gain)
  end

  def regular
    {
      本薪: scale_for_cycle(base_salary),
      伙食費: scale_for_cycle(taxfree_lunch),
      設備津貼: scale_for_cycle(salary.equipment_subsidy),
      主管加給: scale_for_cycle(salary.supervisor_allowance),
      加班費: overtime,
      特休折現: vacation_refund,
    }.merge(extra_gain)
  end

  def contractor
    { "#{salary_label}": scale_for_cycle(actual_salary) }.merge(extra_gain)
  end

  def parttime
    {
      薪資: total_wage,
      交通津貼: salary.commuting_subsidy,
    }.merge(extra_gain)
  end

  def advisor
    { 服務費用: total_wage }.merge(extra_gain)
  end

  def total
    send(salary.role).values.reduce(:+) || 0
  end

  def irregular
    overtime + vacation_refund + payroll.taxfree_irregular_income
  end

  private

  def salary_label
    salary.professional_service? ? "開發費" : "薪資"
  end

  def actual_salary
    salary.monthly_wage
  end

  def base_salary
    salary.monthly_wage - taxfree_lunch
  end

  def taxfree_lunch
    payroll.year >= 2015 ? 2400 : 1800
  end

  def total_wage
    (payroll.parttime_hours * salary.hourly_wage).round
  end

  def overtime
    payroll.overtimes.reduce(0) do |sum, overtime|
      sum + OvertimeService.call(overtime)
    end
  end

  def vacation_refund
    VacationRefundService.call(payroll)
  end

  def extra_gain
    ExtraIncomeService.call(payroll)
  end
end

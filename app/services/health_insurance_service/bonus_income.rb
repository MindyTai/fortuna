# frozen_string_literal: true
# 二代健保：同一年內獎金超過投保薪資四倍
module HealthInsuranceService
  class BonusIncome < SupplementPremium
    attr_reader :payroll, :salary

    def initialize(payroll)
      @payroll = payroll
      @salary = payroll.salary
    end

    private

    def eligible?
      bonus_over_exemption.positive?
    end

    def premium_base
      [payroll.excess_income, bonus_over_exemption].min
    end

    def exemption
      salary.insured_for_health * 4
    end

    def grand_total
      PayrollDetail.yearly_bonus_total_until(
        year: payroll.year,
        month: payroll.month,
        employee_id: payroll.employee_id
      )
    end

    def bonus_over_exemption
      grand_total - exemption
    end
  end
end

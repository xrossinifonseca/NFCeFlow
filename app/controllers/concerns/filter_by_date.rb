module FilterByDate

  extend ActiveSupport::Concern

  included do
    before_action :set_dates_params, only: [:index]
  end

  # private

  def set_dates_params
    if params[:start_date].present? && params[:end_date].present?
      @start_date = parse_date_param(params[:start_date])
      @end_date = parse_date_param(params[:end_date]).end_of_day
    else
      set_default_dates
    end
  end

  def filter_by_date(model,column)
    date_fild = model.arel_table[column]
    record = model.where(date_fild.between(@start_date..@end_date))
  end

  def parse_date_param(date_param)
    DateTime.parse(date_param)
  rescue Date::Error, ArgumentError

    set_default_dates
    @start_date
    @end_date
  end


  def set_default_dates
    @start_date = Date.today.beginning_of_month
    @end_date = Date.today.end_of_month.end_of_day
  end



end

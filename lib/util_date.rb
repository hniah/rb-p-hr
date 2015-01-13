class UtilDate

  def self.business_days_between(date1, date2)
    business_days = 0
    date = date2
    while date > date1
      business_days = business_days + 1 unless date.saturday? or date.sunday?
      date = date - 1.day
    end
    business_days
  end

end

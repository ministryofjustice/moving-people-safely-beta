# Provide named date formats that hook into Rails DATE_FORMATS hash

Date::DATE_FORMATS[:day_month_year] = '%d %m %Y'
Date::DATE_FORMATS[:slashed_day_month_year] = '%d/%m/%Y'
Time::DATE_FORMATS[:time_with_slashed_day_month_year] = '%H:%M %d/%m/%Y'

with nyse_monthly(year,month,total_monthly_dollar_volume) as (
    select year,month,SUM(dollar_volume) as total_monthly_dollar_volume
    from nyse
    group by year,month
) 
select year,month,total_monthly_dollar_volume, 
    AVG(total_monthly_dollar_volume) over (order by (year,month) asc rows 2 preceding)
from nyse_monthly;
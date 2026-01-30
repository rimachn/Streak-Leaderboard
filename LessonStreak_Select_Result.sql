
with RECURSIVE  Calendar as 
(
/*
creating calendar that will include all the dates.
*/
	select min(date) as Calendar_date
	from lessonstreaks
	union all
	select DATE_ADD(Calendar_date, INTERVAL 1 DAY)
    from Calendar
    where Calendar_date <= (
					Select max(date)
                    from lessonstreaks
				  )
), 
User_detail as (
select distinct 
		user_id, 
		date, 
        user_name
 from lessonstreaks 
 order by date asc), 
DatesWithNoLessonLearn as
(
/*
First I goroup the users by ud.user_id, ud.Calendar_date  
then include only the calendar dates where no lessons were learned or streak breaks dates using case statement.

*/
select 
        case when date is null then c.Calendar_date end   as dates
from calendar c
left join User_detail ud on ud.date = c.calendar_date
where ud.user_id is null 
and ud.date is null
group by ud.user_id, c.Calendar_date 
), 
NearestDates as 
(
select ud.user_id, 
       ud.calendar_date,
       ud.date, 

       (select /* case when max(dates) is null 
					then   date_sub( ud.calendar_date, INTERVAL ROW_NUMBER() OVER (PARTITION BY user_id ORDER BY date)  DAY   )     
                    else max(dates) 
			   end  */
               max(dates) 
        from DatesWithNoLessonLearn 
        where dates <=  ud.calendar_date ) as NearestStreakBreakdate
from User_detail ud
group by ud.user_id, 
       ud.calendar_date,
       ud.date
order by ud.calendar_date
)

select  c.calendar_date, 
		user_id, 
		ud.user_name, ud.date
from calendar c
left join User_detail ud on ud.date = c.calendar_date
left join DatesWithNoLessonLearn as nl on nl.dates = c.calendar_date
order by  c.calendar_date






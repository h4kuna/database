day_in_week.sql
-----------
```sql
SELECT `monday`('2013-04-25'); -- 2013-04-22
SELECT `sunday`('2013-04-25'); -- 2013-04-28
```

days_years.sql
-----------
```sql
SELECT `days_year`('2012-01-01'); -- 366
SELECT `days_year`('2013-01-01'); -- 365
```

empty.sql
-----------
This function return 0 or 1 but this is alias for null_default

error_raise.sql
-----------
exception helper
```sql
CALL error_raise(404, 'Row not found'); -- Chyba v dotazu (1048): Column 'call_error_get_last' cannot be null
CALL error_get_last(); -- read exception
```

is_date.sql
-----------
accept string YYYY-MM-DD and valid date
```sql
SELECT `is_date`('2012-01-01'); -- 1
SELECT `is_date`('2013-00-01'); -- 0
SELECT `is_date`('2013-0101'); -- 0
```

is_numeric.sql
-----------
Is variable numeric? More in file.

location.sql
-----------
distance between two points for coordinate
Praha: 50.097679,14.438782
Mladá Boleslav: 50.402172,14.892054
```sql
SELECT location_km(50.097679, 14.438782, 50.402172, 14.892054); -- 46.744469
```

null_default.sql
-----------
Set variable to NULL if is empty.
```sql
SET @x := 0;
CALL null_default(@x);
SELECT @x; -- NULL
```

rc2date.sql
-----------
czech social security number to a date

set_if_null.sql
-----------
If you want setup default value when value is NULL.
For example language cs and en
```sql
CALL set_if_null(cs, en);
```

ucfirst.sql
-----------
```sql
SELECT `ucfirst`('miLAN'); -- Milan
```

year_week.sql
-----------
```sql
SELECT `year_week`('2012-12-31');
```
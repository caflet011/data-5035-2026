SELECT CATEGORY
FROM DONATIONS
WHERE CATEGORY IS NULL;
/**This is to count the null values - 31 values out of 200**/

SELECT COUNT(DISTINCT NAME) AS unique_NAME
FROM DONATIONS;
/**This is to make sure that everyone has a unique name - if I break the data up this could cause issues. We have all unique data now, but matching last names could lead to issues for figuring out where duplicates exist at. **/

SELECT DATE_OF_BIRTH
FROM DONATIONS;
/**The data of births looked incorrectly formatted when I reviewed the data, and from the results they indeed are.**/

SELECT *
FROM DONATIONS 
WHERE DATE_OF_BIRTH < '1900-01-01';
/**This was done to confirm the date formating issue I noticed earlier.**/

SELECT COUNT(*) AS bad_format_results
FROM DONATIONS
WHERE NOT REGEXP_LIKE(PHONE, '^\\([0-9]{3}\\)-[0-9]{3}-[0-9]{4}$');

/**This isnt working properly so I will have to fix this before I promote the changes.**/
/**From the results this data I realized that we have an issue when we ingest our data. For the date of birth, we only collect the last two digits of the year instead of all four years. This means if we were to lose the age data, or not use it we would be unable to properly calcualte how old soneone is. Along with that, we also have missing categorical data for a few people and their organizations. It seems that, that was also the only category with null values when I compare it to my query for null values in the dataset. Another thing that I found is that the phone numbers looked incorrectly formated but I will need to do some work to create a query to investigate this, and maybe change it.**/ 
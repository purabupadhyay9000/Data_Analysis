select * from zam

--Unique Location
select count(distinct location ) as total_location
from zam

--Average rate
select round(avg(rate),1)as avg_rate from zam


--Average Cost
select round(avg("Approx_cost"),1) as avg_cost from zam 

--Total Votes
select sum(votes) as total_votes from zam


--Top 10 Locations
select "location",count(*)as total_restro from zam
group by "location"
order by total_restro desc
limit 10


--Top 10 Cuisines
select "cuisines",count(*)as total_restro from zam
group by "cuisines"
order by total_restro desc
limit 10


--Restaurant Type Distribution
select "rest_type",count(*)as total_restro from zam
group by "rest_type"
order by total_restro desc
limit 10


--Top 10 Restaurants by Votes
select "name","location","votes" from zam
order by "votes" desc
limit 10;


--Average Rating by Restaurant Type
select "rest_type", round(avg("rate"),2) as avg_rating
from zam
group by "rest_type"
order by avg_rating desc
limit 10


--Average Cost by Restaurant Type
select "rest_type", round(avg("Approx_cost"),2) as avg_cost
from zam
group by "rest_type"
order by avg_cost desc
limit 10


--Online Order Distribution
select "online_order", count(*) as restaurants
from zam
group by "online_order"


--Table Booking Distribution
SELECT
    "book_table",
    COUNT(*) AS restaurants
FROM zam
GROUP BY "book_table";


--Top 10 Most Expensive Locations
SELECT
    "location",
    ROUND(AVG("Approx_cost"),2) AS avg_cost
FROM zam
GROUP BY "location"
ORDER BY avg_cost DESC
LIMIT 10;

--Locations with Average Rating Above 4
select "location", round(avg("rate"),2) as avg_rating
from zam
group by "location"
having avg("rate")>4
order by avg_rating desc



--Restaurant Types Having More Than 500 Restaurants
SELECT
    "rest_type",
    COUNT(*) AS total_restaurants
FROM zam
GROUP BY "rest_type"
HAVING COUNT(*) > 500
ORDER BY total_restaurants DESC;



--Restaurants Costing More Than Average Cost
SELECT
    "name",
    "location",
    "Approx_cost"
FROM zam
WHERE "Approx_cost" >
(
    SELECT AVG("Approx_cost")
    FROM zam
)
ORDER BY "Approx_cost" DESC
limit 10


--Restaurants Rated Above Average Rating
SELECT
    "name",
    "location",
    "rate"
FROM zam
WHERE "rate" >
(
    SELECT AVG("rate")
    FROM zam
)
ORDER BY "rate" DESC
limit 10


--Top 3 Highest Rated Restaurants in Each Location
SELECT *
FROM
(
    SELECT
        "location",
        "name",
        "rate",
        ROW_NUMBER() OVER
        (
            PARTITION BY "location"
            ORDER BY "rate" DESC
        ) AS rn
    FROM zam
) t
WHERE rn <= 3;


--Rank Restaurant Types by Average Votes
SELECT
    "rest_type",
    ROUND(AVG("votes"),2) AS avg_votes,
    RANK() OVER
    (
        ORDER BY AVG("votes") DESC
    ) AS ranking
FROM zam
GROUP BY "rest_type";



--Categorize Restaurants by Rating
SELECT
    "name",
    "rate",
    CASE
        WHEN "rate" >= 4.5 THEN 'Excellent'
        WHEN "rate" >= 4 THEN 'Very Good'
        WHEN "rate" >= 3 THEN 'Good'
        ELSE 'Average'
    END AS rating_category
FROM zam;


--Top 5 Restaurant Types by Total Vote
SELECT
    "rest_type",
    SUM("votes") AS total_votes
FROM zam
GROUP BY "rest_type"
ORDER BY total_votes DESC
LIMIT 5;

--Locations Having More Than Average Number of Restaurants
WITH location_count AS
(
    SELECT
        "location",
        COUNT(*) AS total_restaurants
    FROM zam
    GROUP BY "location"
)

SELECT *
FROM location_count
WHERE total_restaurants >
(
    SELECT AVG(total_restaurants)
    FROM location_count
)
ORDER BY total_restaurants DESC;



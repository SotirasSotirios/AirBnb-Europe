-- 1.Analyze the data to identify trends in pricing and occupancy rates across different cities. Provide insights into which cities are most profitable for the company and which room types are in high demand.

SELECT 
    city,
    SUM(bedrooms) AS 'Total_Bedrooms',
    room_type,
    CONCAT(ROUND(AVG(price), 2), ' €') AS 'Average_Price'
FROM
    airbnb
GROUP BY city , room_type
ORDER BY Average_Price DESC

-- 2. Correalation between Cleanliness_Rating, Guest Satisfaction and Price.

SELECT 
    city,
    ROUND(AVG(`Guest Satisfaction`), 2) AS Satisfaction,
    ROUND(AVG(Cleanliness_Rating), 2) AS Clean_rate,
   Concat(ROUND(AVG(price), 2), ' €') AS 'Average_Price'
FROM
    airbnb
GROUP BY city
ORDER BY Average_Price DESC;

-- 3. Price correlated with metro range.

SELECT 
    CASE
        WHEN Metro_Distance_km < 1 THEN 'Less than 1km from Metro'
        WHEN
            Metro_Distance_km >= 1
                AND Metro_Distance_km < 5
        THEN
            '1-5km from Metro'
        WHEN
            Metro_Distance_km >= 5
                AND Metro_Distance_km < 10
        THEN
            '5-10km from Metro'
        ELSE '10+ km from Metro'
    END AS Metro_range,
    CONCAT(ROUND(AVG(price), 2), ' €') AS 'Average_Price'
FROM
    airbnb
GROUP BY Metro_range
ORDER BY Average_Price DESC;

-- 4.Price correlated with Centre range.

SELECT
    CASE
        WHEN City_Center_km < 1 THEN 'Less than 1 km'
        WHEN City_Center_km >= 1 AND City_Center_km < 5 THEN '1-5 km'
        WHEN City_Center_km >= 5 AND City_Center_km < 10 THEN '5-10 km'
        ELSE '10+ km'
    END AS Center_Range,
    Concat(ROUND(AVG(price), 2), ' €') AS 'Average_Price'
FROM
    airbnb
GROUP BY
    Center_Range
ORDER BY
    Center_Range;
    
-- 5.  Evaluate the impact of being a superhost on listing performance.
SELECT 
    Superhost,
    COUNT(*) AS Total_Listings,
    CONCAT(ROUND(AVG(price), 2), ' €') AS 'Average_Price',
    ROUND(AVG(`Guest Satisfaction`), 2) AS Satisfaction
FROM
    airbnb
GROUP BY Superhost;

-- 6.  Understand the preferences of business travelers.

SELECT 
    CASE
        WHEN Business = 1 THEN 'Business_traveller'
        ELSE 'General_traveler'
    END AS Traveller_type,
    ROUND(AVG(`Guest Satisfaction`), 2) AS Satisfaction,
    ROUND(AVG(Cleanliness_Rating), 2) AS Clean_rate,
    CONCAT(ROUND(AVG(price), 1), ' €') AS 'Average_Price'
FROM
    airbnb
GROUP BY Traveller_type;

-- 7.  Explore factors that contribute to guest satisfaction. Identify which factors (e.g., cleanliness, location, room type) have the most significant impact on guest reviews, exclude Total<50.

SELECT 
    room_type,
    Count(*)AS total,
    CASE
        WHEN Metro_Distance_km < 1 THEN '<1km from Metro'
        WHEN
            Metro_Distance_km >= 1
                AND Metro_Distance_km < 5
        THEN
            '1-5km from Metro'
        WHEN
            Metro_Distance_km >= 5
                AND Metro_Distance_km < 10
        THEN
            '5-10km from Metro'
        ELSE '10+ km from Metro'
    END AS Metro_range,
    CASE
        WHEN City_Center_km < 1 THEN '<1 km'
        WHEN City_Center_km >= 1 AND City_Center_km < 5 THEN '1-5 km'
        WHEN City_Center_km >= 5 AND City_Center_km < 10 THEN '5-10 km'
        ELSE '10+ km'
    END AS Center_Range,
	ROUND(AVG(Cleanliness_Rating), 2) AS Clean_rate,
    ROUND(AVG(`Guest Satisfaction`), 2) AS Satisfaction
FROM
    airbnb
GROUP BY room_type, Metro_range,Center_Range
having total>50
order by satisfaction DESC;

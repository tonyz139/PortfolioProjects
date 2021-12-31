Select *
FROM Project1.dbo.USvideos$;

SELECT *
FROM Project1.dbo.CAvideos$;

-- Looking at the trendiest videos in the US
SELECT title, channel_title, views
FROM Project1.dbo.USvideos$
ORDER BY views DESC;

--Looking at trendiest videos in Canada
SELECT title, channel_title, views
FROM Project1.dbo.CAvideos$
ORDER BY views DESC;

-- Looking at the most viewed video based on trending date
SELECT title, trending_date, channel_title, views
FROM Project1.dbo.USvideos$
WHERE trending_date = '17.19.11'
ORDER BY views desc;

--Looking at each categories least viewed trending videos
SELECT category_id, title, trending_date, channel_title, views
FROM Project1.dbo.USvideos$
ORDER BY category_id asc , views asc;

--Seeing which video got the most disliked in the US
SELECT category_id, title, channel_title, publish_time, dislikes
FROM Project1.dbo.USvideos$
ORDER by dislikes desc;

--Seeing which video got the most disliked in Canada
SELECT category_id, title, channel_title, publish_time, dislikes
FROM Project1.dbo.CAvideos$
ORDER by dislikes desc;

-- What video had the longest trend life in the US
SELECT title, COUNT(trending_date) AS 'longest trend life'
FROM Project1.dbo.USvideos$
GROUP BY title
ORDER BY Count(trending_date) DESC;

-- What video had the longest trend life in Canada
SELECT title, COUNT(trending_date) AS 'longest trend life'
FROM Project1.dbo.CAvideos$
GROUP BY title
ORDER BY Count(trending_date) DESC;

--Looking at the different videos that went trending on the same day between US and Canada
SELECT USvideos$.title, CAvideos$.title
FROM Project1.dbo.USvideos$ 
JOIN Project1.dbo.CAvideos$
ON USvideos$.trending_date = CAvideos$.trending_date;

-- Comparing the viewcount of each video with the same title
SELECT DISTINCT (USvideos$.title), USvideos$.views AS US_Views,CAvideos$.title, CAvideos$.views AS CA_views
FROM Project1.dbo.USvideos$
JOIN Project1.dbo.CAvideos$
ON USvideos$.title = CAvideos$.title;

-- Seeing if any video got its comments disabled, usually means it has a lot of negative feedback
SELECT USvideos$.title, USvideos$.comments_disabled, CAvideos$.title, CAvideos$.comments_disabled
FROM Project1.dbo.USvideos$
JOIN Project1.dbo.CAvideos$
ON USvideos$.comments_disabled > 0 AND CAvideos$.comments_disabled > 0;

-- The average amount of likes each trending video / USING CTE  
WITH avg_US_like_count AS
(SELECT USvideos$.title, AVG(USvideos$.likes) AS Average_like_count_of_US 
FROM Project1.dbo.USvideos$
GROUP BY title),
avg_CA_like_count AS
(SELECT CAvideos$.title, AVG(CAvideos$.likes) AS Average_like_count_of_CA
FROM Project1.dbo.CAvideos$
GROUP by title)
SELECT avg_CA_like_count.title, Average_like_count_of_CA, Average_like_count_of_US 
FROM avg_CA_like_count
JOIN avg_US_like_count
ON avg_CA_like_count.title = avg_US_like_count.title;

-- Using View function to create a virtual table
CREATE VIEW trendingdate AS
SELECT title, trending_date
FROM Project1.dbo.USvideos$
WHERE trending_date = '17.19.11';

--Check the top viewing  US video based on category
SELECT USvideos$.category_id, USvideos$.views
FROM Project1.dbo.USvideos$ 
ORDER BY USvideos$.category_id  


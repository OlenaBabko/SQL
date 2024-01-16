# Queries to Select and Modify Data



# 1 Show unique Id of subscribers, who visited the library at least once
SELECT DISTINCT sb_subscriber
FROM subscriptions;

# 2 Show the list of all subscribers, with counting their names
SELECT s_name,
 COUNT(*) AS people_count
FROM subscribers
GROUP BY s_name;




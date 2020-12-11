CREATE VIEW user_subscription AS
SELECT "name", "surname", "subscriptionID", "subscriptionExpiration"
FROM "Users"
WHERE "subscriptionExpiration" > now();

SELECT * FROM user_subscription;

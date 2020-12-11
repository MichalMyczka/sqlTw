INSERT INTO "Users" (name, surname, email, password) VALUES ('jan', 'kowalski', 'jankowalski@gmail.com', 'monkey');


Create or replace function get_trial() returns trigger as
$$
declare
    subscriptionExpiration date := now() + '7 days';
    subscriptionID int := 3;
begin

UPDATE "Users"
    SET "subscriptionID" = subscriptionID, "subscriptionExpiration" = subscriptionExpiration
    WHERE id = NEW.id;
RETURN NEW;
end

$$ language plpgsql;

-- DROP FUNCTION get_trial() CASCADE;

CREATE  TRIGGER trial_subscription AFTER INSERT
    ON "Users" FOR EACH ROW
    EXECUTE PROCEDURE get_trial();

insert into "UserFavSongs"("songID","userID")
select
    ceil(random() * (select count(*) from "Songs")) as songID,
    ceil(random() * (select count(*) from "Users")) as userID
from "Songs"




insert into "Rankings"(position,"artistID")
select
     "Artists".id as artistID,
    row_number() over () as position
from "Artists"



insert into "ArtistSongs"("artistID", "songID")
select
    -- create email by joining first letter of first name, dot and last name
    L.id as artistID,
    F.id  as songID
from (
    select
        id,
        -- select random number from 1 to count_of_first_names
        ceil(random() * (select count(*) from "Artists")) as artistID_index
    from "Artists"
) L
inner join (
    select
        id,
        -- number first names from 1 to count_of_first_names
        row_number() over () as index
    from "Songs"
) F on F.index = L.artistID_index
-- we join on first_name_index, so each last_name will get random first_name

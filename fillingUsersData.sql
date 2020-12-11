Create or replace function random_string(length integer) returns text as
$$
declare
  chars text[] := '{0,1,2,3,4,5,6,7,8,9,A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z,a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z}';
  result text := '';
  i integer := 0;
begin
  if length < 0 then
    raise exception 'Given length cannot be less than 0';
  end if;
  for i in 1..length loop
    result := result || chars[1+random()*(array_length(chars, 1)-1)];
  end loop;
  return result;
end;
$$ language plpgsql;

insert into "Users" (email, name, surname, password, "subscriptionID", "subscriptionExpiration")
select 
    lower(substring(first_name from 1 for 1)||'.'||last_name||'@example.com') as email,
    first_name as name,
    last_name  as surname,
    random_string(8) as password,
    FLOOR(random()*(3)+1) as subsctiprionID,
    NOW() + (random() * (NOW()+'90 days' - NOW())) + '30 days' as subscriptionExpiration
from (
    select 
        last_name,
        -- select random number from 1 to count_of_first_names
        ceil(random() * (select count(*) from first_name)) as first_name_index
    from last_name
) L
inner join (
    select 
        first_name, 
        row_number() over () as index
    from first_name
) F on F.index = L.first_name_index

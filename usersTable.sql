create table if not exists "Users"
(
	id serial not null
		constraint users_pk
			primary key,
	name text not null,
	surname text not null,
	email text not null,
	password text not null,
	"subscriptionID" integer
		constraint users_subscriptions_id_fk
			references "Subscriptions",
	"subscriptionExpiration" date
);

alter table "Users" owner to morgoth;

create unique index if not exists users_email_uindex
	on "Users" (email);

create unique index if not exists users_id_uindex
	on "Users" (id);

create unique index if not exists udx_email
	on "Users" (email);

create trigger trial_subscription
	after insert
	on "Users"
	for each row
	execute procedure get_trial();

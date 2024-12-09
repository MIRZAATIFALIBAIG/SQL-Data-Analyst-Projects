
use Netflix_db;
drop table if exists netflix
create table netflix(
show_id varchar(50),	
type varchar(50),
title varchar(500),
director varchar(800),
casts varchar(2000),
country	varchar(100),
date_added date,
release_year int,
rating	varchar(200),
duration varchar(50),
listed_in	varchar(100),
description varchar(3000)
);
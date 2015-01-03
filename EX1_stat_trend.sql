/* For each stat_id, We find the ratio percentage where the original 151 pokemons have the highest of a specific  stat per type. 

For example the original 151 had the highest HP stat in ~36% of the 17 pokemon types. 

We do double count when two pokemons draw on the greatest of a particular stat. We return

name        percent   
----------  ----------
HP          36        
Defense     31        
Attack      28        
Special De  20        
Special At  13        
Speed       9         

The overall trent seems to show that the original 151 were stronger, but the newer generations were quicker and have a higher emphasis on special abilities. 
*/

select stat_names.name, (og*100/(og+ko)) as percent from


(select stat_id,

-- Query 1
(select count(pokemon_id) from

-- start table 1
(select * from
(select px.*, 
case 
when pokemon_id<=151 then "original"
else "knockoff"
end as gen, py.*
from pokemon_types px natural join pokemon_stats py
) p1

where 

	not exists
	(select * from
		(select px.*, 
			case 
				when pokemon_id<=151 then "original"
				else "knockoff"
			end as gen, py.*
		from pokemon_types px natural join pokemon_stats py
		) p2


		where p1.type_id=p2.type_id
and p1.stat_id=p2.stat_id
and p1.base_stat>p2.base_stat

)) pq
-- end table 1

where gen='original'
and pzz.stat_id=pq.stat_id
group by stat_id

) as og,
-- end query 1
-- Query 2
(select count(pokemon_id) from

-- start table 1
(select * from
(select px.*, 
case 
when pokemon_id<=151 then "original"
else "knockoff"
end as gen, py.*
from pokemon_types px natural join pokemon_stats py
) p1

where 

	not exists
	(select * from
		(select px.*, 
			case 
				when pokemon_id<=151 then "original"
				else "knockoff"
			end as gen, py.*
		from pokemon_types px natural join pokemon_stats py
		) p2


		where p1.type_id=p2.type_id
and p1.stat_id=p2.stat_id
and p1.base_stat>p2.base_stat

)) pq
-- end table 1

where gen='knockoff'
and pzz.stat_id=pq.stat_id
group by stat_id) as ko
-- end query 2


from 

-- start table 1
(select * from
(select px.*, 
case 
when pokemon_id<=151 then "original"
else "knockoff"
end as gen, py.*
from pokemon_types px natural join pokemon_stats py
) p1

where 

	not exists
	(select * from
		(select px.*, 
			case 
				when pokemon_id<=151 then "original"
				else "knockoff"
			end as gen, py.*
		from pokemon_types px natural join pokemon_stats py
		) p2


		where p1.type_id=p2.type_id
and p1.stat_id=p2.stat_id
and p1.base_stat>p2.base_stat

)) pzz
-- end table 1

group by stat_id) natural join stat_names
where local_language_id=9

order by percent desc
;
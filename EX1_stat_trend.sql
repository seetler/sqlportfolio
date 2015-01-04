/* For each stat, we find the percentage of pokemons in the original 151 who have the highest indicated stat relative to its type.

For example, the original 151 pokemons had the highest HP stat in ~36% of the 17 pokemon types. 

If there are two pokemon with the highest stat type, we double count the figure. This could occur when a certain pokemon have two different types, but the highest of a particular stat. 

The baseline percent is the count of the original 151 pokemons divided by the total pokemon count. This is to indicate a baseline of what the percentage would be if stats were evenly distributed. 

After running the analysis, we return the following table.

stat        percent     baseline  
----------  ----------  ----------
HP          36          22        
Defense     31          22        
Attack      28          22        
Special De  20          22        
Special At  13          22        
Speed       9           22        

My analysis indicates that that pokemons have been growing quicker with a higher emphasis on special abilities. It seems that the original 151 pokemon had higher HP and defense. 

*/

select stat_names.name as stat, (og*100/(og+ko)) as percent, 151*100/673 as baseline  from


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
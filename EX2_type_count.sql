/*
This code selects the number of pokemons with a certain type in the first generation.

We used an algorithmic count, because if a Pokemon has two types such as Charizard, should it be counted once as fire and once as flying? In the end, I settled on including an algorithmic count which counts split pokemons as half per type.

Types       Algorithm Count  Natural Count  Pures       Mudbloods 
----------  ---------------  -------------  ----------  ----------
Normal      20.0             24             16          8         
Fighting    7.5              8              7           1         
Flying      9.5              19             0           19        
Poison      21.5             33             10          23        
Ground      10.0             14             6           8         
Rock        5.5              11             0           11        
Bug         7.5              12             3           9         
Ghost       1.5              3              0           3         
Steel       1.0              2              0           2         
Fire        11.0             12             10          2         
Water       25.0             32             18          14        
Grass       7.5              14             1           13        
Electric    7.5              9              6           3         
Psychic     11.0             14             8           6         
Ice         2.5              5              0           5         
Dragon      2.5              3              2           1 

*/



select name as "Types", sum(typecount) as "Algorithm Count", count(type_id) as "Natural Count", 
-- Since we are doing a left join we need to coalesce the two
coalesce(countnatural,0) as "Pures", count(type_id)-coalesce(countnatural,0) as "Mudbloods"

from
-- starts t2
	-- Table with id, types, and count
	(select pokemon_id, type_id, 
			-- SQLITE CANNOT PERFORM DIVISION UNDER 1
			-- Because 1/2=0 in SQlite,  we have to use a manual case statement in Sqlite
		case 
	when typecount=1 then 1
	when typecount=2 then 0.5
	end typecount from pokemon_types 

	natural join

	-- Start t1 
		-- Selects pokemon and the number of types
	(select pokemon_id, count(pokemon_id) as typecount from (select *from pokemon_types where pokemon_id<=151)
	group by pokemon_id) t1) 
	-- End t1
	t2
-- Ends t2

natural join type_names


left natural join
-- Table 4 nat count
(select type_id, count(pokemon_id) as countnatural from
	-- Table 3 same as table 1
	(select pokemon_id, type_id, count(pokemon_id) as typecount from (select *from pokemon_types where pokemon_id<=151)
	group by pokemon_id) p3
	-- Table 3 same as table 1
	where p3.typecount=1
	group by type_id)
-- Table  4 nat count

where type_names.local_language_id=9

group by type_id

;

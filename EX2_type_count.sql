/*
This code finds the number of pokemons with a certain type in the first generation only. We chose to only analyze the first generation, mainly because I'm unfamiliar with the remaining generations of pokemons.

We included an Algorithmic Count, because if a Pokemon has two types such as Charizard, it would be counted once as fire and once as flying. Thus, we half the count of any pokemon with two types.

The Natural Count counts pokemons with two or more types in both of its type categories.

The percentages of homogeneity and heterogeneity are based on the Natural Count.


Types       Algorithm Count  Natural Count  Homogeneous Percentage  Heterogeneous Percentage
----------  ---------------  -------------  ----------------------  ------------------------
Water       25.0             32             56                      43                      
Poison      21.5             33             30                      69                      
Normal      20.0             24             66                      33                      
Fire        11.0             12             83                      16                      
Psychic     11.0             14             57                      42                      
Ground      10.0             14             42                      57                      
Flying      9.5              19             0                       100                     
Fighting    7.5              8              87                      12                      
Bug         7.5              12             25                      75                      
Grass       7.5              14             7                       92                      
Electric    7.5              9              66                      33                      
Rock        5.5              11             0                       100                     
Ice         2.5              5              0                       100                     
Dragon      2.5              3              66                      33                      
Ghost       1.5              3              0                       100                     
Steel       1.0              2              0                       100   

*/



select name as "Types", sum(typecount) as "Algorithm Count", count(type_id) as "Natural Count", 
-- Since we are doing a left join we need to coalesce the two
(coalesce(countnatural,0))*100/count(type_id) as "Homogeneous Percentage", (count(type_id)-coalesce(countnatural,0))*100/count(type_id) as "Heterogeneous Percentage"

from
-- starts t2
	-- Table with id, types, and count
	(select pokemon_id, type_id, 
	
		1.0/typecount as typecount from pokemon_types 

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

order by sum(typecount) desc
;

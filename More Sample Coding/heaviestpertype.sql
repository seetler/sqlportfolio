/* Returns the heaviest pokemon per type 

SELECT (pokemon)

CONDITION 1 (heaviest)

CONDITION 2 (per type)

*/


select p1.id, p2.type_id, p1.weight
from pokemon p1, pokemon_types p2
where p2.pokemon_id=p1.id
and

-- CONDITION 1 selects the heaviest
not exists 
(select * 
from pokemon px, pokemon_types py
where p1.weight<px.weight

-- SUBCONDITION connects weight to type within local subquery
and px.id=py.pokemon_id

-- CONDITION 2 connects type of subquery to global query
and py.type_id=p2.type_id
)

order by type_id



;

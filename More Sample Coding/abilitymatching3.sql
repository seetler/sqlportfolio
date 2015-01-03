/* 

Selects all the 4th generation abilities that are not in the original 151.

SELECT (ability_id)

CONDITION 1 (abilitiy generation = 4th) and  
CONDITION 2 (pokemons id NOT under 151)

*/

/* We are trying to reach a list of abilities */

-- SELECTS ABILITY
select distinct ability_id from pokemon_abilities p1

-- CONDITION 1
where p1.ability_id in 
(select distinct p3.ability_id from pokemon_abilities p3, abilities p4 where generation_id=4 and p4.id=p3.ability_id)

-- CONDITION 2
and p1.ability_id not in
(select ability_id from pokemon_abilities where pokemon_id<=151)

order by p1.ability_id
;

/* 
Selects all the pokemon have wegiht more than 100 but are less than 15 tall, and are in the original 151.

SELECTS (pokemons) 

CONDITION 1 (weight > 100) and 
CONDITION 2 (height < 15) and
CONDITION 3 (pokemon in the original 151)
*/

-- SELECTS ID
select id from pokemon
where

-- CONDITION 1
id in (select id from pokemon where weight>100)

-- CONDITION 2
and id in (select id from pokemon where height<15)

-- CONDITION 3
and id in (select id from pokemon where id<=151)

order by id
;
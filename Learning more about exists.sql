/*

Selects all pokemon that have only one type.

SELECT (Pokemon)

CONDITION 1 (one type

OR

Remove all pokemon that have more than one type.
)

*/


select * from pokemon_types p1

-- Selects what has been removed
where not exists
(select * from pokemon_types p2
where p1.pokemon_id=p2.pokemon_id


/* Removes all pokemon that have one type, it also removes the rows where pokemon have more than one type, but because there are rows where the type id are different, there's still a record of them

 1A
 2A
 2B

 X - 1A-1A
 X - 2A-2A
 O - 2A-2B
 O - 2B-2A
 X - 2B-2B

Therefore, pokemon Id 2 still exists

*/


and p1.type_id<>p2.type_id)

and pokemon_id<=151

;

select * from pokemon_types p1
where  exists
(select * from pokemon_types p2
where p1.pokemon_id=p2.pokemon_id


-- All pokemon Id's have to be different; Because it exists, then we will select all the pokemon Id's that are in existence. 
and p1.type_id<>p2.type_id)

and pokemon_id<=151

;

/* If we set Use = instead of <>,

In this statement the equation does not eliminate any pokemon Id fully. */

select * from pokemon_types p1
where not exists
(select * from pokemon_types 
	p2
where p1.pokemon_id=p2.pokemon_id

/*

This doesn't work, because we only removed some of the rows, but we still hav eone of each id

 1A
 2A
 2B

 O - 1A-1A
 O - 2A-2A
 X - 2A-2B
 X - 2B-2A
 O - 2B-2B

 */

and p1.type_id=p2.type_id)

and pokemon_id<=151

;
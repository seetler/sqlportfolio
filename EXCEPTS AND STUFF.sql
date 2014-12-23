/* Selects all items which do not have another item that has teh same cost. 

The way to solve this issue is with an EXISTS function, more specifically NOT EXIST.

*/

/* The following code ERRORS */
select distinct p1.id from items p1, items p2 
-- This doesn't work because every items would still be in the database. 

-- We line all the items up
where p1.cost=p2.cost

-- We remove all that have the same name, but what remains is all the ones that have different names
and p1.id<>p2.id
;

/* 
The correct coding

SELECT (cost)

CONDITION 1 (only one item with that cost)

*/

select distinct  p1.id from items p1

where not exists 

(select * from items p2
	-- SELECT
where p1.cost=p2.cost

	-- CONDITION
and p1.id<>p2.id)
;

/* Here we select all unique pokemon moves relative to power 

SELECT (power)

CONDITION (only one move that has that power)
*/

select * from moves p1

where
not exists

(select * from moves p2
	-- SELECT
where p2.power=p1.power
	-- CONDITION
and p2.id<>p1.id)

;

/* selects all pokemon who have ONLY one type 

SELECT (pokemon)

CONDITION (only one type for that pokemon)
*/

select * from pokemon_types p1

where not exists

(select * from pokemon_types p2
	-- CONDITION
where p1.type_id<>p2.type_id
	-- SELECT
and p1.pokemon_id=p2.pokemon_id)

;

/* selects all pokemon who have more than one type 

SELECT (pokemon)

CONDITION (only one type for that pokemon)
*/

select * from pokemon_types p1

where  exists

(select * from pokemon_types p2
	-- CONDITION
where p1.type_id<>p2.type_id
	-- SELECT
and p1.pokemon_id=p2.pokemon_id)

;


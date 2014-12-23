/* Selects only abilities that appear in generation 1 pokemons

CONDITION 1 (appear in generation 1)

*/

select distinct p1.ability_id from pokemon_abilities p1 

-- Joins all g1 pokemons
left join (select * from pokemon_abilities where pokemon_id<=151) p2

-- on abilities id
on p1.ability_id=p2.ability_id

-- Where exists
where p2.pokemon_id is not null

;

select count(distinct p1.ability_id) from pokemon_abilities p1 
left join (select * from pokemon_abilities where pokemon_id<=151) p2
on p1.ability_id=p2.ability_id
where p2.pokemon_id is not null

; 

/* Selects abilities that does not appear in generation 1 pokemons

CONDITION 1 (does not appear in generation 1)

*/

select distinct p1.ability_id from pokemon_abilities p1 

-- Joins all g1 pokemons
left join (select * from pokemon_abilities where pokemon_id<=151) p2

-- on abilities id
on p1.ability_id=p2.ability_id

-- Where does not exist
where p2.pokemon_id is null

;
select count(distinct p1.ability_id) from pokemon_abilities p1 left join (select * from pokemon_abilities where pokemon_id<=151) p2
on p1.ability_id=p2.ability_id
where p2.pokemon_id is null

;



/* Selects abilities that only appear in generation 1 pokemons

CONDITION 1 (appear only in generation 1)

*/

-- Start with g1
select distinct p1.ability_id from (select * from pokemon_abilities where pokemon_id<=151) p1 

-- Joins all the other pokemans
left join pokemon_abilities p2

-- on abilities id
on p1.ability_id=p2.ability_id

-- Where the id>151 does not exist
where p2.pokemon_id is null

;

select count(distinct p1.ability_id) from (select * from pokemon_abilities where pokemon_id<=151) p1 left join pokemon_abilities p2
on p1.ability_id=p2.ability_id
where p2.pokemon_id is null

;



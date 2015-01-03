/* Selects all pokemon abilities that have only one pokemon which uses it*/


select * from pokemon_abilities p1 natural join ability_names join pokemon_species_names on p1.pokemon_id=pokemon_species_names.pokemon_species_id
where not exists

(select * from pokemon_abilities p2
where p1.ability_id=p2.ability_id
and p1.pokemon_id<>p2.pokemon_id)
and ability_names.local_language_id=9
and pokemon_species_names.local_language_id=9

order by ability_id



;

/*
Selects all pokemon that only have one ability
*/

select * from pokemon_abilities p1 natural join ability_names join pokemon_species_names on p1.pokemon_id=pokemon_species_names.pokemon_species_id
where not exists
(select * from pokemon_abilities p2
where p2.pokemon_id=p1.pokemon_id
and p1.ability_id<>p2.ability_id)


and ability_names.local_language_id=9
and pokemon_species_names.local_language_id=9

order by pokemon_id

;
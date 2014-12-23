/* Selects all pokemon that have the Intimidate ability, but not shed skin 

This can be done the same using the 

EXCEPT word

there are multiple ways to skin a cat
*/


select distinct p1.pokemon_species_id, p1.name, p2.name


from pokemon_species_names p1, ability_names p2, 
pokemon_abilities p3



where

p1.pokemon_species_id=p3.pokemon_id
and p2.ability_id=p3.ability_id


and p1.local_language_id='9'
and p2.local_language_id='9'
and p3.pokemon_id<='151'

/* All Pokemans that have Intimidate */

and p3.pokemon_id in 
(select pokemon_id from pokemon_abilities
where ability_id='22' )

/* But not Shed Skin */

and p3.pokemon_id not in 
(select pokemon_id from pokemon_abilities
where ability_id='61' )






;
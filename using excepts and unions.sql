/* Selects all rows, then remove rows that fit the second criteria 

The same can be accomplished using 

IN

more than one way to skin a cat
*/

select * from pokemon

except

select * from pokemon
where id>151

;


select * from pokemon
where id<100

union

select * from pokemon
where id>100
and id<=151

;
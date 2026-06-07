--PROYECTO SQL ThePower
--Andres Galvan

--1. Crea el esquema de la BBDD
-- Base de datos importada correctamente
-- usando el archivo BBDD_Proyecto_shakila.sql

--2. Muestra los nombres de todas las películas con una clasificación por edades de ‘R’.
select  title, rating
from film
where rating = 'R';

--3. Encuentra los nombres de los actores que tengan un “actor_id” entre 30 y 40.

select actor_id, concat(first_name , ' ', last_name) as "full name"
from actor
where actor_id between '30' and '40';

--4. Obtén las películas cuyo idioma coincide con el idioma original.
select title 
from film
where language_id = original_language_id ;
-- original_language_id contiene valores NULL
-- por lo que la consulta no devuelve resultados

--5. Ordena las películas por duración de forma ascendente.
select title, length
from film
order by "length" asc;

--6. Encuentra el nombre y apellido de los actores que tengan ‘Allen’ en su apellido

select CONCAT(first_name, ' ', last_name) as "Full Name" 
from actor
where last_name = 'ALLEN'
order by last_name asc;

--7. Encuentra la cantidad total de películas en cada clasificación de la tabla “film” y muestra la clasificación junto con el recuento.

select  rating , count(*) as total_films
from film
group by rating;

--8. Encuentra el título de todas las películas que son ‘PG-13’ o tienen una duración mayor a 3 horas en la tabla film.

select rating, length
from film
where rating = 'PG-13' or length > '180';

--9. Encuentra la variabilidad de lo que costaría reemplazar las películas.

select variance(replacement_cost ) as variability_cost
from film;

--10. Encuentra la mayor y menor duración de una película de nuestra BBDD.

select min("length") as shortest_movie, max("length") as longest_movie
from film;

--11. Encuentra lo que costó el antepenúltimo alquiler ordenado por día.

SELECT payment.amount
FROM payment
JOIN rental
ON payment.rental_id = rental.rental_id
ORDER BY rental.rental_date DESC, payment.payment_id DESC
LIMIT 1
OFFSET 2;


--12. Encuentra el título de las películas en la tabla “film” que no sean ni ‘NC17’ ni ‘G’ en cuanto a su clasificación.

select title, rating
from film
where rating not in ('G' ,'NC-17');

--13. Encuentra el promedio de duración de las películas para cada clasificación de la tabla film y muestra la clasificación junto con el promedio de duración.

select rating,avg ("length")  as average_lenght
from film
group by rating;

--14. Encuentra el título de todas las películas que tengan una duración mayor a 180 minutos.

select title
from film
where length > '180';

--15. ¿Cuánto dinero ha generado en total la empresa?

select sum(amount) as total_revenue
from payment;

--16. Muestra los 10 clientes con mayor valor de id.

select customer_id 
from customer
order by customer_id desc
limit 10;

--17. Encuentra el nombre y apellido de los actores que aparecen en la película con título ‘Egg Igby’.

select concat(actor.first_name ,' ', actor.last_name ) as full_name, film.title
from actor
join film_actor fa 
on actor.actor_id = fa.actor_id
join film
on fa.film_id = film.film_id
where film.title = 'EGG IGBY';

--18. Selecciona todos los nombres de las películas únicos.

select distinct title
from film;

--19. Encuentra el título de las películas que son comedias y tienen una duración mayor a 180 minutos en la tabla “film”.

select film.title, c."name" 
from film 
join film_category fc 
on film.film_id = fc.film_id
join category c 
on fc.category_id = c.category_id
where film.length > '180' and c.name = 'Comedy';

--20. Encuentra las categorías de películas que tienen un promedio de duración superior a 110 minutos y muestra el nombre de la categoría junto con el promedio de duración.

select c."name" , round(avg(film.length ),0)
from film 
join film_category fc 
on film.film_id = fc.film_id
join category c 
on fc.category_id = c.category_id
group by c."name" 
having round(avg(film.length) , 0)> 110;

--21. ¿Cuál es la media de duración del alquiler de las películas?

select  avg(rental_duration )
from  film;

--22. Crea una columna con el nombre y apellidos de todos los actores y actrices.

select concat(a.first_name , ' ', a.last_name ) as full_name
from actor a 

--23. Números de alquiler por día, ordenados por cantidad de alquiler de forma descendente.

SELECT 
    rental_date::date AS rental_day,
    COUNT(*) AS total_rentals
FROM rental
GROUP BY rental_day
ORDER BY total_rentals DESC;

--24. Encuentra las películas con una duración superior al promedio.

select title , length
from film
where length > (select avg(length) from film);


--25. Averigua el número de alquileres registrados por mes

SELECT 
    EXTRACT(MONTH FROM rental_date) AS month,
    COUNT(*) AS total_rentals
FROM rental
GROUP BY month
ORDER BY month;

--26. Encuentra el promedio, la desviación estándar y varianza del total pagado

select sum(amount) as total_payment, avg(amount) as avg_payment, variance(amount) as variance, stddev(amount) as standard_deviation
from payment

--27. ¿Qué películas se alquilan por encima del precio medio?

SELECT title, rental_rate
FROM film
WHERE rental_rate > (
    SELECT AVG(rental_rate)
    FROM film
);

--28. Muestra el id de los actores que hayan participado en más de 40 películas.

select fa.actor_id , count(fa.film_id ) as total_films
from film_actor fa 
group by fa.actor_id 
having count(fa.film_id ) >'40';


--29. Obtener todas las películas y, si están disponibles en el inventario,mostrar la cantidad disponible.

select title , count(i.inventory_id ) as available_copies
from film
left join inventory i 
on film.film_id = i.film_id
group by title 
order by available_copies desc;

--30. Obtener los actores y el número de películas en las que ha actuado.

select concat(a.first_name , ' ', a.last_name ) as full_name, count(fa.film_id ) as number_of_movies
from actor a 
join film_actor fa 
on a.actor_id = fa.actor_id
group by full_name ;

--31. Obtener todas las películas y mostrar los actores que han actuado en ellas, incluso si algunas películas no tienen actores asociados.

select title , concat(a.first_name , ' ', a.last_name ) as full_name
from film
left join film_actor fa 
on film.film_id = fa.film_id
left join actor a 
on fa.actor_id = a.actor_id
order by film.title asc;

--32. Obtener todos los actores y mostrar las películas en las que han actuado, incluso si algunos actores no han actuado en ninguna película.

select concat(a.first_name , ' ', a.last_name ) as full_name, title
from film
left join film_actor fa 
on film.film_id = fa.film_id
left join actor a 
on fa.actor_id = a.actor_id
group by full_name , film.title 
order by film.title asc;

--33. Obtener todas las películas que tenemos y todos los registros de alquiler

select title, rental_id  , rental_date 
from film
full join inventory i 
on film.film_id = i.film_id
full join rental
on i.inventory_id = rental.inventory_id;

--34. Encuentra los 5 clientes que más dinero se hayan gastado con nosotros.

select concat(c.first_name ,' ', c.last_name ) as customer_fullname, sum(amount) as money_spent
from customer c 
join payment p 
on c.customer_id = p.customer_id
group by c.customer_id 
order by sum(amount) desc
limit 5;

--35. Selecciona todos los actores cuyo primer nombre es 'Johnny'.

select a.first_name , a.last_name , a.actor_id 
from actor a 
join film_actor fa 
on a.actor_id = fa.actor_id 
where a.first_name = 'JOHNNY'
group by a.actor_id;

--36. Renombra la columna “first_name” como Nombre y “last_name” como Apellido.

select a.first_name as Nombre , a.last_name as Apellido
from actor a 

--37. Encuentra el ID del actor más bajo y más alto en la tabla actor.

select max(a.actor_id), min(a.actor_id )
from actor a;

--38. Cuenta cuántos actores hay en la tabla “actor”.

select count(a.actor_id )
from actor a;

--39. Selecciona todos los actores y ordénalos por apellido en orden ascendente.

select concat(a.last_name , ' ', a.first_name) as full_name
from actor a 
order by full_name asc;

--40. Selecciona las primeras 5 películas de la tabla “film”.

select title
from film
order by title asc
limit 5;

--41. Agrupa los actores por su nombre y cuenta cuántos actores tienen el mismo nombre. ¿Cuál es el nombre más repetido?

select a.first_name , count(a.first_name )
from actor a 
group by a.first_name 
order by count(a.first_name) desc
limit 3;

--42. Encuentra todos los alquileres y los nombres de los clientes que los realizaron.

select r.rental_id , c.first_name , c.last_name 
from rental r 
join customer c 
on r.customer_id = c.customer_id;

--43. Muestra todos los clientes y sus alquileres si existen, incluyendo aquellos que no tienen alquileres.

select  c.first_name , c.last_name , r.rental_id 
from rental r 
left join customer c 
on r.customer_id = c.customer_id;

--44. Realiza un CROSS JOIN entre las tablas film y category. ¿Aporta valor esta consulta? ¿Por qué? Deja después de la consulta la contestación.

select film.title ,c."name" 
from film
cross join category c 

-- Esta consulta no aporta mucho valor analítico,
-- ya que combina todas las películas con todas las categorías
-- sin tener en cuenta la relación real entre ellas.

--45. Encuentra los actores que han participado en películas de la categoría 'Action'

SELECT 
    concat(actor.first_name, ' ', actor.last_name) AS full_name, "name" as category
FROM actor
JOIN film_actor
ON actor.actor_id = film_actor.actor_id
JOIN film
ON film_actor.film_id = film.film_id
JOIN film_category
ON film.film_id = film_category.film_id
JOIN category
ON film_category.category_id = category.category_id
WHERE category.name = 'Action';

--46. Encuentra todos los actores que no han participado en películas.

select concat(first_name, ' ', last_name) AS full_name, f.title 
from actor 
left join film_actor fa 
on actor.actor_id = fa.actor_id
left join film f 
on fa.film_id = f.film_id
where title is null

--47. Selecciona el nombre de los actores y la cantidad de películas en las que han participado.

select concat(first_name, ' ', last_name) AS full_name, count(fa.film_id )
from actor a 
join film_actor fa 
on a.actor_id = fa.actor_id
group by full_name ;

--48. Crea una vista llamada “actor_num_peliculas” que muestre los nombres de los actores y el número de películas en las que han participado.

create view actor_num_peliculas as
select concat(first_name, ' ', last_name) AS full_name, count(fa.film_id ) as num_peliculas
from actor a 
join film_actor fa 
on a.actor_id = fa.actor_id
group by full_name ;

--49. Calcula el número total de alquileres realizados por cada cliente.

select count(r.rental_id ) as total_rentals, concat(c.first_name , ' ' , c.last_name ) as customer_name
from rental r 
join customer c 
on r.customer_id = c.customer_id
group by customer_name;

--50. Calcula la duración total de las películas en la categoría 'Action'.

select sum(f.length) as total_lenght_action_movies
from film f 
join film_category fc 
on f.film_id = fc.film_id
join category c 
on fc.category_id = c.category_id
where name = 'Action';

--51. Crea una tabla temporal llamada “cliente_rentas_temporal” para almacenar el total de alquileres por cliente.

create TEMP TABLE cliente_rentas_temporal as
select c.customer_id,
    concat(c.first_name, ' ', c.last_name) as customer_name,
    count(r.rental_id) as total_rentals
from customer c
join rental r
on c.customer_id = r.customer_id
group by c.customer_id, c.first_name, c.last_name;


--52. Crea una tabla temporal llamada “peliculas_alquiladas” que almacene las películas que han sido alquiladas al menos 10 veces.

create TEMP TABLE peliculas_alquiladas as
select film_id, count(i.film_id ) as veces_alquilada
from rental r 
join inventory i 
on r.inventory_id = i.inventory_id
group by i.film_id 
having count(i.film_id) >=10
order by veces_alquilada desc;

--53. Encuentra el título de las películas que han sido alquiladas por el cliente con el nombre ‘Tammy Sanders’ y que aún no se han devuelto. Ordena los resultados alfabéticamente por título de película.

select c.first_name , c.last_name , title, r.return_date 
from film
left join inventory i 
on film.film_id = i.film_id
join rental r 
on i.inventory_id = r.inventory_id
left join customer c 
on r.customer_id = c.customer_id
where c.first_name = 'TAMMY' and c.last_name = 'SANDERS' and r.return_date is null
order by title asc;

--54. Encuentra los nombres de los actores que han actuado en al menos una película que pertenece a la categoría ‘Sci-Fi’. Ordena los resultados  alfabéticamente por apellido.

select distinct a.first_name ,a.last_name 
from actor a 
join film_actor fa  
on a.actor_id = fa.actor_id
join film f 
on fa.film_id = f.film_id
join film_category fc 
on f.film_id = fc.film_id
join category c 
on fc.category_id = c.category_id
where c.name = 'Sci-Fi'
order by a.last_name asc;

--55. Encuentra el nombre y apellido de los actores que han actuado en películas que se alquilaron después de que la película ‘Spartacus Cheaper’ se alquilara por primera vez. Ordena los resultados alfabéticamente por apellido.

select distinct a.first_name , a.last_name 
from actor a 
join film_actor fa 
on a.actor_id = fa.actor_id
join film f 
on fa.film_id = f.film_id
join inventory i 
on f.film_id = i.film_id
join rental r 
on i.inventory_id = r.inventory_id
where r.rental_date > (select min(rental.rental_date )
from rental
join inventory i2 
on rental.inventory_id = i2.inventory_id
join film f2 
on i2.film_id = f2.film_id
where title = 'SPARTACUS CHEAPER' 
)
order by a.last_name asc ;

--56. Encuentra el nombre y apellido de los actores que no han actuado en ninguna película de la categoría ‘Music’.

select distinct concat(a.first_name , ' ' , a.last_name ) as full_name
from actor a 
where a.actor_id not in( select a.actor_id from actor a
join film_actor fa 
on a.actor_id = fa.actor_id
join film f 
on fa.film_id = f.film_id
join film_category fc 
on f.film_id = fc.film_id
join category c 
on fc.category_id = c.category_id
where c."name" = 'Music');

--57. Encuentra el título de todas las películas que fueron alquiladas por más de 8 días

select title 
from film
join inventory i 
on film.film_id = i.film_id
join rental r 
on i.inventory_id = r.inventory_id
where r.return_date::date  - r.rental_date::date  > 8;

--58. Encuentra el título de todas las películas que son de la misma categoría que ‘Animation’

select title
from film
join film_category fc 
on film.film_id = fc.film_id
join category c 
on fc.category_id = c.category_id
where c."name" = 'Animation';

--59. Encuentra los nombres de las películas que tienen la misma duración que la película con el título ‘Dancing Fever’. Ordena los resultados alfabéticamente por título de película.


select title
from film 
where length = (select film.length  from film
where title = 'DANCING FEVER')
and title <> 'DANCING FEVER'
order by title asc;

--60. Encuentra los nombres de los clientes que han alquilado al menos 7 películas distintas. Ordena los resultados alfabéticamente por apellido.


select distinct c.first_name , c.last_name 
from customer c 
join rental r 
on c.customer_id = r.customer_id
join inventory i 
on r.inventory_id = i.inventory_id
where i.film_id  >= (select count(distinct i2.film_id )  from inventory i2 
where i2.film_id  = 7)
group by c.customer_id 
order by c.last_name asc;



--61. Encuentra la cantidad total de películas alquiladas por categoría y muestra el nombre de la categoría junto con el recuento de alquileres.

select count(r.rental_id ), c."name" 
from rental r 
join inventory i 
on r.inventory_id = i.inventory_id
join film f 
on i.film_id = f.film_id
join film_category fc 
on f.film_id = fc.film_id
join category c 
on fc.category_id = c.category_id
group by "name" ;

--62. Encuentra el número de películas por categoría estrenadas en 2006.

select count(fc.film_id ), c."name" 
from film_category fc 
join category c  
on fc.category_id = c.category_id
join film f 
on fc.film_id = f.film_id
where f.release_year = '2006'
group by c."name" ;

--63. Obtén todas las combinaciones posibles de trabajadores con las tiendas que tenemos.

select s.staff_id , s.first_name , s2.store_id 
from staff s 
cross join store s2 ;




--64. Encuentra la cantidad total de películas alquiladas por cada cliente y muestra el ID del cliente, su nombre y apellido junto con la cantidad de películas alquiladas.


select count(r.rental_id) , r.customer_id , concat( c.first_name , ' ', c.last_name ) as customer_name
from rental r 
join customer c 
on r.customer_id = c.customer_id
group by customer_name , r.customer_id ;
















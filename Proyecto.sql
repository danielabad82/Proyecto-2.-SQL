--1.Crea el esquema de la BBDD.
--Se crea para la realización de las consultas solicitadas y se sube a Github.

--2.Muestra los nombres de todas las películas con una clasificación por edades de ‘Rʼ.
select "title" as "título", 
		"rating" as "clasificación" 
from film f
where "rating" = 'R'; 

--3.Encuentra los nombres de los actores que tengan un “actor_idˮ entre 30 y 40.
select "actor_id", 
		concat("first_name",' ',"last_name") as "nombre_actor" 
from actor a 
where "actor_id" between 30 and 40; 

--4.Obtén las películas cuyo idioma coincide con el idioma original.
select "title" as "título" ,
		"original_language_id" as "idioma_original",
		"language_id" as "idioma" 
from film f 
where "language_id" = "original_language_id" ;

--5.Ordena las películas por duración de forma ascendente.
select "title" as "título", 
		"length" as "duración"
from film f 
order by "length" ;

--6.Encuentra el nombre y apellido de los actores que tengan ‘Allenʼ en su apellido.
select "actor_id", 
		concat("first_name",' ',"last_name") as "nombre_actor" 
from "actor" a
where "last_name" like '%ALLEN%';

--7.Encuentra la cantidad total de películas en cada clasificación de la tabla “film” y muestra la clasificación junto con el recuento.
select distinct "rating" as "clasificacion",
		count("rating") as "total_por_categoría"
from film f 
group by "rating";

--8.Encuentra el título de todas las películas que son ‘PG-13’ o tienen una duración mayor a 3 horas en la tabla film.
select "title" as "título",
		"rating" as "clasificación",
		"length" as "duración"
from film f
where "rating" = 'PG-13'or "length">180 ;

--9.Encuentra la variabilidad de lo que costaría reemplazar las películas.
select round(variance("replacement_cost"),2) as "varianza_reemplazamiento_películas" 
from film f; 

--10.Encuentra la mayor y menor duración de una película de nuestra BBDD.
select max("length") as "película_más_larga",
		min("length") as "película_más_corta"
from film f ;

--11.Encuentra lo que costó el antepenúltimo alquiler ordenado por día.
select p."amount" as "costo", 
		r."rental_date" as "fecha_alquiler", 
		r."rental_id" 
from payment p
inner join rental r 
on p."rental_id" = r. "rental_id"
order by r."rental_date" desc
limit 3; 

--12.Encuentra el título de las películas en la tabla “film” que no sean ni ‘NC-17’ ni ‘G’ en cuanto a su clasificación.
select "title" as "título", 
		"rating" as "clasificación" 
from film f
where "rating" <> 'NC-17' and "rating" <> 'G'; 

--13.Encuentra el promedio de duración de las películas para cada clasificación de la tabla film y muestra la clasificación junto con el promedio de duración.
select 	"rating" as "categoría",
		round(avg("length"),2) as "duración_promedio" 
from film f 
group by rating ;

--14.Encuentra el título de todas las películas que tengan una duración mayor a 180 minutos.
select "title" as "título", 
		"length" as "duración" 
from film f 
where "length" >180;

--15.¿Cuánto dinero ha generado en total la empresa?
select sum("amount") 
from payment p;

--16.Muestra los 10 clientes con mayor valor de id.
select "customer_id" 
from customer c
order by "customer_id" desc 
limit 10;

--17.Encuentra el nombre y apellido de los actores que aparecen en la película con título ‘Egg Igby’.
select  "title" as "título",
		concat(a.first_name,' ',last_name) as "Actor"
from film f 
inner join film_actor fa on f."film_id"=fa."film_id" 
inner join actor a on fa."actor_id" = a."actor_id" 
where "title" = 'EGG IGBY';

--18.Selecciona todos los nombres de las películas únicos.
select  distinct "title"
from film f 
order by "title" ;

--19.Encuentra el título de las películas que son comedias y tienen una duración mayor a 180 minutos en la tabla “film”.
select f."title" as "título",
		c."name" as "categoría",
		f. length as "duración"
from film f
left join film_category fc ON f."film_id"=fc."film_id"
left join category c on fc."category_id"=c."category_id"
where c."name" = 'Comedy' and f."length" >180;

--20.Encuentra las categorías de películas que tienen un promedio de duración superior a 110 minutos y muestra el nombre de la categoría junto con el promedio de duración.
select c."name" as "categoría",
		round(avg(f."length"),2)as "promedio"
from category c
left join film_category fc ON c."category_id"=fc."category_id"
left join film f on fc."film_id"=f."film_id"
group by c."name" 
having avg(f."length")>110;

--21.¿Cuál es la media de duración del alquiler de las películas?
select round( avg("rental_duration"),0)	as "duración_media_alquiler"
from film f ;

--22.Crea una columna con el nombre y apellidos de todos los actores y actrices.
select concat("first_name",' ',"last_name") as "Actor/actriz"
from actor a ;

--23.Números de alquiler por día, ordenados por cantidad de alquiler de forma descendente. 
select  count("rental_date") as "Número _alquileres", 
		date(r."rental_date") as "Fecha_alquiler" 
from rental r
group by "rental_date"
order by "Número _alquileres" desc ;

--24.Encuentra las películas con una duración superior al promedio.
select "title" as "título" , 
		"length" as "duración"
from film f 
where length > 
(select avg("length") from film f2 );

--25.Averigua el número de alquileres registrados por mes.
select extract('MONTH'from "rental_date") as "mes_alquiler",
		count ("rental_date") as "número_alquileres"	
from rental r
group by extract('MONTH'from "rental_date");

--26.Encuentra el promedio, la desviación estándar y varianza del total pagado.
select round(avg("amount"),2) as "promedio",
	round(stddev("amount"),2)as "desviación_estándar",		
	round(variance("amount"),2) as "varianza"
from payment p; 

--27.¿Qué películas se alquilan por encima del precio medio? 
select "title" as "título" ,
		"rental_rate" as "precio_alquiler" 		
from film f
where "rental_rate" > (
	select avg("rental_rate")
	from film f );

--28.Muestra el id de los actores que hayan participado en más de 40 películas. 
select actor_id, 
		count(actor_id) as "total_películas"
from film_actor fa 
group by actor_id
having count(actor_id)>40;

--29.Obtener todas las películas y, si están disponibles en el inventario,mostrar la cantidad disponible.
select f."title" as "Título",
		count(i."film_id") as  "Cantidad_Disponible"
from inventory i 
inner join film f 
	on i."film_id"= f."film_id"
group by f."title"
order by f."title";

--30.Obtener los actores y el número de películas en las que ha actuado.
select concat(a."first_name",' ',a."last_name") as "Actor/actriz",
		count(film_id) as "número_películas"
from film_actor fa
inner join actor a 
	on fa."actor_id"=a."actor_id" 
group by "Actor/actriz"
order by "Actor/actriz"; 

--31.Obtener todas las películas y mostrar los actores que han actuado en ellas, incluso si algunas películas no tienen actores asociados. 
--En el ejercicio 36 pide renombrar las columnas "first_name" y "last_name" de la tabla "actor", por eso tras hacerlo arroja el error de que esas columnas no existen.
select f."title" as "Título" ,
		concat(a."first_name",' ',a."last_name") as "Actor/actriz"
from film f 
left join film_actor fa 
	on f."film_id"=fa."film_id"
left join actor a 
	on fa."actor_id"=a."actor_id"
order by f."title" ;


--32.Obtener todos los actores y mostrar las películas en las que han actuado, incluso si algunos actores no han actuado en ninguna película.
--En el ejercicio 36 pide renombrar las columnas "first_name" y "last_name" de la tabla "actor", por eso tras hacerlo arroja el error de que esas columnas no existen.
select concat(a."first_name",' ',a."last_name") as "Actor/actriz",
		f."title" as "Título"
from actor a 
left join film_actor fa
	on a."actor_id"=fa."actor_id"
left join film f 
	on fa."film_id"=f."film_id" 
order by "Actor/actriz";

--33.Obtener todas las películas que tenemos y todos los registros de alquiler.
select f."title" as "Título",
		r.*
from inventory i 
inner join film f 
	on i."film_id"= f."film_id" 
full join rental r 
	on i."inventory_id"=r."inventory_id"
order by f."title" ;

--34.Encuentra los 5 clientes que más dinero se hayan gastado con nosotros.
select concat("first_name",' ', "last_name") as "Nombre_cliente", 
		sum( p."amount") as "Cantidad_gastada"
from customer c 
inner join payment p 
	on c."customer_id"= p."customer_id"
group by "Nombre_cliente"
order by sum( p."amount") desc 
limit 5;

--35.Selecciona todos los actores cuyo primer nombre es 'Johnny'.
--En el ejercicio 36 pide renombrar las columnas "first_name" y "last_name" de la tabla "actor", por eso tras hacerlo arroja el error de que esas columnas no existen.
select  "actor_id",
		concat(a."first_name",' ', a."last_name") as "Actor"
from actor a 
where "first_name" like 'JOHNNY';

--36.Renombra la columna “first_name” como Nombre y “last_name” como Apellido.
alter table actor
rename column "first_name" to "Nombre";

alter table actor 
rename column "last_name" to "Apellido";

--37.Encuentra el ID del actor más bajo y más alto en la tabla actor.
select min("actor_id") as "Actor_id_más_bajo",
		max("actor_id") as "Actor_id_más_alto"
from  actor a ;

--38.Cuenta cuántos actores hay en la tabla “actor”.
select count("actor_id") as "número_actores"
from actor a ;

--39.Selecciona todos los actores y ordénalos por apellido en orden ascendente.
select "Apellido"
from actor a
order by "Apellido"; 

--40.Selecciona las primeras 5 películas de la tabla “film”.
select *
from film f 
limit 5;

--41.Agrupa los actores por su nombre y cuenta cuántos actores tienen el mismo nombre. ¿Cuál es el nombre más repetido?
select distinct "Nombre",
		count("Nombre") as "Actores/Actrices_mismo_nombre"
from actor a 
group by "Nombre"
having count("Nombre")>1
order by count("Nombre") desc;

--42.Encuentra todos los alquileres y los nombres de los clientes que los realizaron.
select r."rental_id" as "alquiler",
		concat(c."first_name",' ', c."last_name") as "cliente"
from rental r 
left join customer c 
	on r."customer_id"=c."customer_id"
order by "rental_id";

--43.Muestra todos los clientes y sus alquileres si existen, incluyendo aquellos que no tienen alquileres.
select concat(c."first_name",' ', c."last_name") as "cliente",
		r."rental_id"
from customer c 
right join rental r 
 	on c."customer_id"=r."customer_id";

--44.Realiza un CROSS JOIN entre las tablas film y category. ¿Aporta valor esta consulta? ¿Por qué? Deja después de la consulta la contestación.
select *
from film f 
cross join category c ;

-- La consulta no aporta valor porque no nos está diciendo a qué categoría pertenece cada película.

--45.Encuentra los actores que han participado en películas de la categoría 'Action'.
select concat("Nombre",' ',"Apellido") as "Actor/Actriz",
		c."name" as "Categoría"
from actor a 
inner join film_actor fa 
		on a."actor_id"=fa."actor_id"
inner join film f 
		on fa."film_id"=f."film_id"
inner join film_category fc 
		on f."film_id"=fc."film_id"
inner join category c
		on fc."category_id"=c."category_id"
where c."name"='Action';

--46.Encuentra todos los actores que no han participado en películas.
select concat("Nombre",' ',"Apellido") as "Actor/Actriz",
		fa."film_id" as "Película"
from actor a 
inner join film_actor fa 
		on a."actor_id"=fa."actor_id"
where fa."film_id" is null;

--47. Selecciona el nombre de los actores y la cantidad de películas en las que han participado.
select concat("Nombre",' ',"Apellido") as "Actor/Actriz",
		count(fa."film_id") as "Película"
from actor a 
inner join film_actor fa 
		on a."actor_id"=fa."actor_id"
group by "Nombre", "Apellido"
having count(fa."film_id")>1 
order by "Actor/Actriz";

--48.Crea una vista llamada “actor_num_peliculas” que muestre los nombres de los actores y el número de películas en las que han participado.
create view "actor_num_películas" as
select concat("Nombre",' ',"Apellido") as "Actor/Actriz",
		count(fa."film_id") as "Película"
from actor a 
inner join film_actor fa 
		on a."actor_id"=fa."actor_id"
group by "Nombre", "Apellido"
having count(fa."film_id")>1 
order by "Actor/Actriz";	
	
--49.Calcula el número total de alquileres realizados por cada cliente.
select customer_id,
		count(rental_id) as "número_alquileres"
from rental r 
group by customer_id
order by customer_id ;

--50.Calcula la duración total de las películas en la categoría 'Action'.
select sum(f."length") as "duración",
		c."name" as "categoría"
from film f 
inner join film_category fc 
		on f."film_id"=fc."film_id"
inner join category c 
		on fc. "category_id"= c. "category_id"
where c."name" = 'Action'
group by c."name";

--51.Crea una tabla temporal llamada “cliente_rentas_temporal” para almacenar el total de alquileres por cliente.
create temporary table cliente_rentas_temporal as
select "customer_id" as "cliente",
		count("rental_id")as "alquileres_cliente"
from rental r
group by "customer_id" 
order by "customer_id" ; 


--52.Crea una tabla temporal llamada “peliculas_alquiladas” que almacene las películas que han sido alquiladas al menos 10 veces.
create temporary table peliculas_alquiladas as
select f."title" as "pelicula",
		count("rental_id")  as "número_alquileres"
from rental r 
left join inventory i 
		on r."inventory_id"=i."inventory_id"
left join film f 
		on i."film_id"=f."film_id"	
group by f."title"
having count("rental_id")>10
order by f."title";

--53.Encuentra el título de las películas que han sido alquiladas por el cliente con el nombre ‘Tammy Sanders’ y que aún no se han devuelto. Ordena los resultados alfabéticamente por título de película.
select f."title" as "pelicula",
		concat(c."first_name",' ', c."last_name") as "cliente",
		r."rental_id",
		r."return_date" as "fecha_devolución"
from rental r 
inner join customer c 
		on r."customer_id"=c."customer_id"
left join inventory i 
		on r."inventory_id"=i."inventory_id"
left join film f 
		on i."film_id"=f."film_id"
where r."return_date" is null
group by "pelicula","cliente", "rental_id" 
having concat(c."first_name",' ', c."last_name") = 'TAMMY SANDERS'
order by "pelicula" ;

--54.Encuentra los nombres de los actores que han actuado en al menos una película que pertenece a la categoría ‘Sci-Fi’. Ordena los resultados alfabéticamente por apellido.
select concat("Nombre",' ',"Apellido") as "Actor/Actriz",
		c."name" as "Categoria",
		count("name") as "Numero_peliculas"
from actor a 
inner join film_actor fa 
	on a."actor_id"=fa."actor_id"
inner join film f 
	on fa."film_id"=f."film_id"
inner join film_category fc 
	on f."film_id"=fc."film_id"
inner join category c 
	on fc."category_id"=c."category_id"
where c."name"='Sci-Fi'
group by "Apellido", "Nombre" ,c."name"
order by "Apellido";

--No se puede usar la vista creada en el ejercicio 48 porque no está en el select de esta el campo "film_id" como tal, solo con el count.

--55.Encuentra el nombre y apellido de los actores que han actuado en películas que se alquilaron después de que la película ‘Spartacus Cheaper’ se alquilara por primera vez. Ordena los resultados alfabéticamente por apellido.

/*Me ha llevado intentar resolver este ejercicio unos 10 días y no he conseguido hacerlo bien del todo, probe CTEs, subconsultas, tablas temporales y no fuí capaz. 
 * Averigüe con una consulta normal la fecha del primer alquiler de la mencionada película. 
 * Aísle la fecha del alquiler de la hora de la columna "rental_date", ya que los resultados que arrojaba la consulta incluia el mismo dia que se alquilo por primera vez ‘Spartacus Cheaper’*/
 
--Consulta para saber la primera vez que se alquilo la película ‘Spartacus Cheaper’
select f."title",
		r."rental_date" as "fecha_alquiler"
	from film f 
	inner join inventory i 
		on f."film_id"=i."film_id"
	inner join rental r 
		on i."inventory_id"=r."inventory_id"
	where f."title"='SPARTACUS CHEAPER'
	order by r."rental_date"
	limit 1;

-- CTE y su consulta para completar el ejercicio
with "Peliculas_alquiler" as (
	select f."title" as "Titulo",
			date(r."rental_date") as "Fecha_alquiler",
			concat(a."Apellido",' ',"Nombre") as "Actores" 
	from rental r 
	inner join inventory i 
		on i."inventory_id"=r."inventory_id"
	inner join film f 
		on i."film_id"=f."film_id" 
	inner join film_actor fa 
		on f."film_id"=fa."film_id"
	inner join actor a 
		on fa."actor_id"=a."actor_id")

select "Actores", "Titulo","Fecha_alquiler"
from "Peliculas_alquiler"
where "Fecha_alquiler">'2005-07-08'
order by "Actores";

--56.Encuentra el nombre y apellido de los actores que no han actuado en ninguna película de la categoría ‘Music’.
select concat("Nombre",' ',"Apellido") as "Actor/Actriz",
		c."name" as "Categoria"
from actor a 
inner join film_actor fa 
	on a."actor_id"=fa."actor_id"
inner join film f 
	on fa."film_id"=f."film_id"
inner join film_category fc 
	on f."film_id"=fc."film_id"
inner join category c 
	on fc."category_id"=c."category_id"
where c."name"<>'Music'
group by "Apellido", "Nombre" ,c."name"
order by "Actor/Actriz";

--57.Encuentra el título de todas las películas que fueron alquiladas por más de 8 días.
create temporary table Dias_alquilada as
select inventory_id,
		"return_date" - "rental_date" as "Dias_alquiler"
from rental r;

create temporary table Extraccion_dias as
select inventory_id,
		extract (day from "Dias_alquiler") as "Dias_pelicula_alquilada"
from Dias_alquilada;


select f."title","Dias_pelicula_alquilada"
from Extraccion_dias
inner join inventory i 
	on Extraccion_dias."inventory_id"=i."inventory_id"
inner join film f 
	on i."film_id"=f."film_id"
where "Dias_pelicula_alquilada">8
order by f."title";

--Se ha comprobado que algunas películas aparecen repetidas porque han tenido varios alquileres de más de 8 días.


--58.Encuentra el título de todas las películas que son de la misma categoría que ‘Animation’.
select title as "Titulo", 
	   "name" as "Categoria" 
from film f 
inner join film_category fc 
	on f."film_id"=fc."film_id"
inner join category c 
	on fc."category_id"=c."category_id"
where c."name"='Animation'
order by "title";

--59.Encuentra los nombres de las películas que tienen la misma duración que la película con el título ‘Dancing Fever’. Ordena los resultados alfabéticamente por título de película.
--Similar situación que en el ejercicio 55.
with DuracionPelicula as (
	select "title" as "Titulo",
		"length" as "Duracion"
	from film f 
	where "title"='DANCING FEVER')

select "title" as "Titulo",
		"length" as "Duracion"
from film f 
where "length"= 144;

--60.Encuentra los nombres de los clientes que han alquilado al menos 7 películas distintas. Ordena los resultados alfabéticamente por apellido.
select concat(c."first_name",' ', c."last_name") as "Nombre_cliente", 
		count(distinct(i."film_id")) as "Peliculas_alquiladas_diferentes"
from rental r
inner join inventory i 
		on r."inventory_id"=i."inventory_id"
inner join customer c 
		on r."customer_id" =c."customer_id"
group by c."last_name", c."first_name" 
having count(distinct(i."film_id"))>7
order by c."last_name";


--61.Encuentra la cantidad total de películas alquiladas por categoría y muestra el nombre de la categoría junto con el recuento de alquileres.
select c."name" as "Categoría",
		count(i.film_id) as "Peliculas_alquiladas"		
from rental r 
inner join inventory i 
		on r."inventory_id" =i."inventory_id"
inner join film f 
		on i."film_id" = f."film_id"
inner join film_category fc 
		on f."film_id"=fc."film_id"
inner join category c 
		on fc."category_id" = c."category_id"
group by c."name";

--62.Encuentra el número de películas por categoría estrenadas en 2006.
select c."name" as "Categoría", 
		count(f.film_id) as "Número_peliculas", 
		f.release_year as "Año_estreno"
from film f 
inner join film_category fc 
		on f."film_id"=fc."film_id"
inner join category c 
		on fc."category_id" = c."category_id"
where f."release_year" = 2006 
group by c."name", f."release_year"
order by "Número_peliculas";

--63.Obtén todas las combinaciones posibles de trabajadores con las tiendas que tenemos.
select s."store_id" as "Tienda",
		s2."staff_id" as "Trabajador"
from store s
cross join staff s2; 
		
--64.Encuentra la cantidad total de películas alquiladas por cada cliente y muestra el ID del cliente, su nombre y apellido junto con la cantidad de películas alquiladas.
select c."customer_id",
		concat(c."first_name",' ', c."last_name") as "Nombre_cliente", 
		count(i."film_id") as "Peliculas_alquiladas"
from rental r
inner join inventory i 
		on r."inventory_id"=i."inventory_id"
inner join customer c 
		on r."customer_id" =c."customer_id"
group by c."customer_id"
order by c."customer_id"; 
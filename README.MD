## Consultas sobre una tabla

1. Devuelve un listado con el código de oficina y la ciudad donde hay oficinas.

```sql
select o.codigo_oficina, c.ciudad
from oficina as o, ciudad as c
where o.id_ciudad_oficina = c.id_ciudad
+----------------+----------+
| codigo_oficina | ciudad   |
+----------------+----------+
| O001           | Ciudad A |
| O002           | Ciudad B |
| O003           | Madrid   |
+----------------+----------+
```

2. Devuelve un listado con la ciudad y el teléfono de las oficinas de España.

```sql
SELECT ciudad.ciudad, telefono.numero
FROM oficina
JOIN ciudad ON oficina.id_ciudad_oficina = ciudad.id_ciudad
JOIN pais ON oficina.id_pais_oficina = pais.id_pais
JOIN telefono ON oficina.id_telefono_oficina = telefono.id_telefono
WHERE pais.pais = 'España';
+--------+-----------+
| ciudad | numero    |
+--------+-----------+
| Madrid | 222222222 |
+--------+-----------+
```

3. Devuelve un listado con el nombre, apellidos y email de los empleados cuyo
jefe tiene un código de jefe igual a 7.

```sql
SELECT nombre_empleado, apellido1_empleado, apellido2_empleado, email_empleado
FROM empleado
WHERE codigo_jefe = 7;
+-----------------+---------------------+----------------------+-----------------------+
| nombre_empleado | apellido1_empleado  | apellido2_empleado   | email_empleado        |
+-----------------+---------------------+----------------------+-----------------------+
| Empleado 1      | Apellido Empleado 1 | Apellido Empleado 2  | empleado1@example.com |
| Empleado 5      | Apellido Empleado 9 | Apellido Empleado 10 | empleado5@example.com |
+-----------------+---------------------+----------------------+-----------------------+
```

4. Devuelve el nombre del puesto, nombre, apellidos y email del jefe de la
empresa.

```sql
SELECT puesto,nombre_empleado, apellido1_empleado, apellido2_empleado, email_empleado
FROM empleado
WHERE codigo_jefe IS NULL;
+---------+-----------------+---------------------+---------------------+-----------------------+
| puesto  | nombre_empleado | apellido1_empleado  | apellido2_empleado  | email_empleado        |
+---------+-----------------+---------------------+---------------------+-----------------------+
| Gerente | Empleado 2      | Apellido Empleado 3 | Apellido Empleado 4 | empleado2@example.com |
+---------+-----------------+---------------------+---------------------+-----------------------+
```

5. Devuelve un listado con el nombre, apellidos y puesto de aquellos
empleados que no sean representantes de ventas.

```sql
SELECT nombre_empleado, apellido1_empleado, apellido2_empleado, puesto
FROM empleado
WHERE puesto != 'Representante de Ventas';
+-----------------+---------------------+---------------------+----------+
| nombre_empleado | apellido1_empleado  | apellido2_empleado  | puesto   |
+-----------------+---------------------+---------------------+----------+
| Empleado 1      | Apellido Empleado 1 | Apellido Empleado 2 | Vendedor |
| Empleado 2      | Apellido Empleado 3 | Apellido Empleado 4 | Gerente  |
| Empleado 4      | Apellido Empleado 7 | Apellido Empleado 8 | Gerente  |
+-----------------+---------------------+---------------------+----------+
```

6. Devuelve un listado con el nombre de los todos los clientes españoles.

```sql
SELECT cliente.nombre_cliente
FROM cliente
JOIN pais ON cliente.id_pais_cliente = pais.id_pais
WHERE pais.pais = 'España';
+----------------+
| nombre_cliente |
+----------------+
| Cliente 3      |
+----------------+
```

7. Devuelve un listado con los distintos estados por los que puede pasar un
pedido.

```sql
SELECT estado
FROM estado;
+-------------+
| estado      |
+-------------+
| En progreso |
| Rechazado   |
+-------------+
```

8. Devuelve un listado con el código de cliente de aquellos clientes que
realizaron algún pago en 2008. Tenga en cuenta que deberá eliminar
aquellos códigos de cliente que aparezcan repetidos. Resuelva la consulta:
• Utilizando la función YEAR de MySQL.

```sql
SELECT DISTINCT cod_cliente
FROM transaccion
WHERE YEAR(fecha_transaccion) = 2008;
+-------------+
| cod_cliente |
+-------------+
|           1 |
|           2 |
+-------------+
```

• Utilizando la función DATE_FORMAT de MySQL.

```sql
SELECT DISTINCT cod_cliente
FROM transaccion
WHERE DATE_FORMAT(fecha_transaccion, '%Y') = '2008';
+-------------+
| cod_cliente |
+-------------+
|           1 |
|           2 |
+-------------+
```

• Sin utilizar ninguna de las funciones anteriores.

```sql
SELECT DISTINCT cod_cliente
FROM transaccion
WHERE fecha_transaccion BETWEEN '2008-01-01' AND '2008-12-31';
+-------------+
| cod_cliente |
+-------------+
|           1 |
|           2 |
+-------------+
```

9. Devuelve un listado con el código de pedido, código de cliente, fecha
esperada y fecha de entrega de los pedidos que no han sido entregados a
tiempo.

```sql
SELECT codigo_pedido, codigo_cliente_pedido, fecha_esperada, fecha_entrega
FROM pedido
WHERE fecha_entrega > fecha_esperada;
+---------------+-----------------------+----------------+---------------+
| codigo_pedido | codigo_cliente_pedido | fecha_esperada | fecha_entrega |
+---------------+-----------------------+----------------+---------------+
|          1002 |                     2 | 2024-02-10     | 2024-02-24    |
+---------------+-----------------------+----------------+---------------+
```

10. Devuelve un listado con el código de pedido, código de cliente, fecha
esperada y fecha de entrega de los pedidos cuya fecha de entrega ha sido al
menos dos días antes de la fecha esperada.
• Utilizando la función ADDDATE de MySQL.

```sql
SELECT codigo_pedido, codigo_cliente_pedido, fecha_esperada, fecha_entrega
FROM pedido
WHERE fecha_entrega <= ADDDATE(fecha_esperada, INTERVAL -2 DAY);
+---------------+-----------------------+----------------+---------------+
| codigo_pedido | codigo_cliente_pedido | fecha_esperada | fecha_entrega |
+---------------+-----------------------+----------------+---------------+
|          1001 |                     1 | 2024-01-10     | 2024-01-07    |
+---------------+-----------------------+----------------+---------------+
```

• Utilizando la función DATEDIFF de MySQL.

```sql
SELECT codigo_pedido, codigo_cliente_pedido, fecha_esperada, fecha_entrega
FROM pedido
WHERE DATEDIFF(fecha_esperada, fecha_entrega) >= 2;
+---------------+-----------------------+----------------+---------------+
| codigo_pedido | codigo_cliente_pedido | fecha_esperada | fecha_entrega |
+---------------+-----------------------+----------------+---------------+
|          1001 |                     1 | 2024-01-10     | 2024-01-07    |
+---------------+-----------------------+----------------+---------------+
```

• ¿Sería posible resolver esta consulta utilizando el operador de suma + o
resta -?

```sql
SELECT codigo_pedido, codigo_cliente_pedido, fecha_esperada, fecha_entrega
FROM pedido
WHERE fecha_esperada - INTERVAL 2 DAY >= fecha_entrega;
+---------------+-----------------------+----------------+---------------+
| codigo_pedido | codigo_cliente_pedido | fecha_esperada | fecha_entrega |
+---------------+-----------------------+----------------+---------------+
|          1001 |                     1 | 2024-01-10     | 2024-01-07    |
+---------------+-----------------------+----------------+---------------+
```

11. Devuelve un listado de todos los pedidos que fueron rechazados en 2009.

```sql
SELECT p.codigo_pedido
FROM pedido as p
WHERE p.fecha_pedido BETWEEN '2009-01-01' AND '2009-12-31'
  AND p.estado_pedido = (
    SELECT id_estado
    FROM estado
    WHERE estado = 'Rechazado'
  );
 +---------------+
| codigo_pedido |
+---------------+
|          1002 |
+---------------+
```

12. Devuelve un listado de todos los pedidos que han sido entregados en el
mes de enero de cualquier año.

```sql
SELECT codigo_pedido
FROM pedido
WHERE MONTH(fecha_entrega) = 1;
+---------------+
| codigo_pedido |
+---------------+
|          1001 |
+---------------+
```

13. Devuelve un listado con todos los pagos que se realizaron en el
año 2008 mediante Paypal. Ordene el resultado de mayor a menor.

```sql
SELECT t.id_transaccion
FROM transaccion as t
WHERE t.fecha_transaccion BETWEEN '2008-01-01' AND '2008-12-31' 
  AND t.forma_pago_trasaccion = (
  SELECT f.id_forma_pago
  FROM forma_pago as f
  WHERE f.nombre_forma_pago = 'Paypal'
  )
ORDER BY total_transaccion DESC;
+----------------+
| id_transaccion |
+----------------+
| T003           |
| T001           |
+----------------+
```

14. Devuelve un listado con todas las formas de pago que aparecen en la
tabla pago. Tenga en cuenta que no deben aparecer formas de pago
repetidas.

```sql
SELECT DISTINCT nombre_forma_pago 
FROM forma_pago;
+------------------------+
| nombre_forma_pago      |
+------------------------+
| Tarjeta de Crédito     |
| Transferencia Bancaria |
| Paypal                 |
+------------------------+
```

15. Devuelve un listado con todos los productos que pertenecen a la
gama Ornamentales y que tienen más de 100 unidades en stock. El listado
deberá estar ordenado por su precio de venta, mostrando en primer lugar
los de mayor precio.

```sql
SELECT p.nombre, p.precio_venta
FROM producto as p
WHERE p.gama_producto = (
  SELECT g.id_gama
  FROM gama as g
  WHERE g.descripcion_texto = 'Ornamentales'
  )
  AND p.cantidad_stock = (
  SELECT s.id_stock
  FROM stock as s
  WHERE s.cantidad_producto > 100
  )
ORDER BY precio_venta DESC;
+------------+--------------+
| nombre     | precio_venta |
+------------+--------------+
| Producto 3 |       129.99 |
+------------+--------------+
```

16. Devuelve un listado con todos los clientes que sean de la ciudad de Madrid y
cuyo representante de ventas tenga el código de empleado 11 o 30.

```sql
SELECT nombre_cliente
FROM cliente
WHERE id_ciudad_cliente = (SELECT id_ciudad FROM ciudad WHERE ciudad = 'Madrid') 
AND (codigo_empleado_rep_ventas = 11 OR codigo_empleado_rep_ventas = 30);
+----------------+
| nombre_cliente |
+----------------+
| Cliente 2      |
| Cliente 3      |
+----------------+
```



Consultas multitabla (Composición interna)
Resuelva todas las consultas utilizando la sintaxis de SQL1 y SQL2. Las consultas con
sintaxis de SQL2 se deben resolver con INNER JOIN y NATURAL JOIN.

1. Obtén un listado con el nombre de cada cliente y el nombre y apellido de su
representante de ventas.

```sql
select c.nombre_cliente, CONCAT(e.nombre_empleado,' ', e. apellido1_empleado) as "Representante de ventas"
from cliente as c, empleado as e
where c.codigo_empleado_rep_ventas = e.id_empleado;
+----------------+--------------------------------+
| nombre_cliente | Representante de ventas        |
+----------------+--------------------------------+
| Cliente 1      | Empleado 3 Apellido Empleado 5 |
| Cliente 2      | Empleado 5 Apellido Empleado 9 |
| Cliente 3      | Empleado 3 Apellido Empleado 5 |
+----------------+--------------------------------+
```

1. Muestra el nombre de los clientes que hayan realizado pagos junto con el
nombre de sus representantes de ventas.

```sql
select distinct c.nombre_cliente, CONCAT(e.nombre_empleado,' ', e. apellido1_empleado) as "Representante de ventas"
from cliente as c, empleado as e, pedido as p
where c.codigo_empleado_rep_ventas = e.id_empleado and p.codigo_cliente_pedido = c.id_cliente;
+----------------+--------------------------------+
| nombre_cliente | Representante de ventas        |
+----------------+--------------------------------+
| Cliente 1      | Empleado 3 Apellido Empleado 5 |
| Cliente 2      | Empleado 5 Apellido Empleado 9 |
+----------------+--------------------------------+
```

1. Muestra el nombre de los clientes que no hayan realizado pagos junto con
el nombre de sus representantes de ventas.

```sql
select distinct c.nombre_cliente,CONCAT(e.nombre_empleado, ' ', e.apellido1_empleado) as "Representante de ventas"
from cliente as c
join empleado as e
  on c.codigo_empleado_rep_ventas = e.id_empleado
left join pedido as p 
  on c.id_cliente = p.codigo_cliente_pedido
where p.codigo_cliente_pedido IS NULL;
+----------------+--------------------------------+
| nombre_cliente | Representante de ventas        |
+----------------+--------------------------------+
| Cliente 3      | Empleado 3 Apellido Empleado 5 |
+----------------+--------------------------------+
```

1. Devuelve el nombre de los clientes que han hecho pagos y el nombre de sus
representantes junto con la ciudad de la oficina a la que pertenece el
representante.

```sql
select distinct c.nombre_cliente,CONCAT(e.nombre_empleado, ' ', e.apellido1_empleado) as "Representante de ventas", ci.ciudad
from cliente as c
join empleado as e
  on c.codigo_empleado_rep_ventas = e.id_empleado
left join pedido as p 
  on c.id_cliente = p.codigo_cliente_pedido
join oficina as o
  on e.codigo_oficina_empleado = o.codigo_oficina
join ciudad as ci
  on o.id_ciudad_oficina = ci.id_ciudad
where p.codigo_cliente_pedido = c.id_cliente;
+----------------+--------------------------------+----------+
| nombre_cliente | Representante de ventas        | ciudad   |
+----------------+--------------------------------+----------+
| Cliente 1      | Empleado 3 Apellido Empleado 5 | Madrid   |
| Cliente 2      | Empleado 5 Apellido Empleado 9 | Ciudad B |
+----------------+--------------------------------+----------+
```

1. Devuelve el nombre de los clientes que no hayan hecho pagos y el nombre
de sus representantes junto con la ciudad de la oficina a la que pertenece el
representante.

```sql
select distinct c.nombre_cliente,CONCAT(e.nombre_empleado, ' ', e.apellido1_empleado) as "Representante de ventas", ci.ciudad
from cliente as c
join empleado as e
  on c.codigo_empleado_rep_ventas = e.id_empleado
left join pedido as p 
  on c.id_cliente = p.codigo_cliente_pedido
join oficina as o
  on e.codigo_oficina_empleado = o.codigo_oficina
join ciudad as ci
  on o.id_ciudad_oficina = ci.id_ciudad
where p.codigo_cliente_pedido IS NULL;
+----------------+--------------------------------+--------+
| nombre_cliente | Representante de ventas        | ciudad |
+----------------+--------------------------------+--------+
| Cliente 3      | Empleado 3 Apellido Empleado 5 | Madrid |
+----------------+--------------------------------+--------+
```

1. Lista la dirección de las oficinas que tengan clientes en Fuenlabrada.

```sql
select o.codigo_oficina, CONCAT(ca.calle, ' ', b.barrio, ' ', vivienda) as "Direccion"
from cliente as c
join empleado as e
  on c.codigo_empleado_rep_ventas = e.id_empleado
join oficina as o
  on e.codigo_oficina_empleado = o.codigo_oficina
join ciudad as ci
  on c.id_ciudad_cliente = ci.id_ciudad
join direccion as d
 on o.id_direccion_oficina1 = d.id_direccion
join calle as ca
  on ca.id_calle = d.id_calle_direccion
join barrio as b
  on b.id_barrio = d.id_barrio_direccion
where ci.ciudad = "Fuenlabrada";
+----------------+------------------------------------+
| codigo_oficina | Direccion                          |
+----------------+------------------------------------+
| O002           | Calle Secundaria Barrio Sur Casa 2 |
+----------------+------------------------------------+
```

1. Devuelve el nombre de los clientes y el nombre de sus representantes junto
con la ciudad de la oficina a la que pertenece el representante.

```sql
select distinct c.nombre_cliente,CONCAT(e.nombre_empleado, ' ', e.apellido1_empleado) as "Representante de ventas", ci.ciudad
from cliente as c
join empleado as e
  on c.codigo_empleado_rep_ventas = e.id_empleado
join oficina as o
  on e.codigo_oficina_empleado = o.codigo_oficina
join ciudad as ci
  on o.id_ciudad_oficina = ci.id_ciudad;
+----------------+--------------------------------+----------+
| nombre_cliente | Representante de ventas        | ciudad   |
+----------------+--------------------------------+----------+
| Cliente 2      | Empleado 5 Apellido Empleado 9 | Ciudad B |
| Cliente 1      | Empleado 3 Apellido Empleado 5 | Madrid   |
| Cliente 3      | Empleado 3 Apellido Empleado 5 | Madrid   |
+----------------+--------------------------------+----------+
```

1. Devuelve un listado con el nombre de los empleados junto con el nombre
de sus jefes.

```sql
select nombre_empleado, (
  select nombre_empleado
  from empleado
  where codigo_jefe = id_empleado
) as jefe
from empleado;
+-----------------+-------------+
| nombre_empleado | Nombre jefe |
+-----------------+-------------+
| Empleado 3      | Empleado 2  |
| Empleado 4      | Empleado 1  |
| Empleado 5      | Empleado 2  |
+-----------------+-------------+
```

1. Devuelve un listado que muestre el nombre de cada empleados, el nombre
de su jefe y el nombre del jefe de sus jefe.

```sql
select e1.nombre_empleado,e2.nombre_empleado as "Nombre jefe", e3.nombre_empleado as 'Jefe del jefe'
from empleado as e1
left join empleado as e2
  on e1.codigo_jefe = e2.id_empleado
left join empleado as e3
  on e2.codigo_jefe = e3.id_empleado;
 +-----------------+-------------+---------------+
| nombre_empleado | Nombre jefe | Jefe del jefe |
+-----------------+-------------+---------------+
| Empleado 1      | NULL        | NULL          |
| Empleado 2      | NULL        | NULL          |
| Empleado 3      | Empleado 2  | NULL          |
| Empleado 4      | Empleado 1  | NULL          |
| Empleado 5      | Empleado 2  | NULL          |
+-----------------+-------------+---------------+
```

1. Devuelve el nombre de los clientes a los que no se les ha entregado a
tiempo un pedido.

```sql
select c.nombre_cliente
from cliente as c
inner join pedido as p
  on c.id_cliente = p.codigo_cliente_pedido
where p.fecha_entrega > p.fecha_esperada;
+----------------+
| nombre_cliente |
+----------------+
| Cliente 2      |
+----------------+
```

1. Devuelve un listado de las diferentes gamas de producto que ha comprado
cada cliente.

```sql
select c.nombre_cliente, g.descripcion_texto
from cliente as c
join pedido as p
  on c.id_cliente = p.codigo_cliente_pedido
join detalle_pedido as dp
  on p.codigo_pedido = dp.codigo_pedido_detalle
join producto as pr
  on pr.codigo_producto = dp.codigo_producto_pedido
join gama as g
  on g.id_gama = pr.gama_producto;
+----------------+------------------------+
| nombre_cliente | descripcion_texto      |
+----------------+------------------------+
| Cliente 1      | Descripción de gama 1  |
| Cliente 2      | Descripción de gama 2  |
| Cliente 2      | Ornamentales           |
+----------------+------------------------+
```

Consultas multitabla (Composición externa)
Resuelva todas las consultas utilizando las cláusulas LEFT JOIN, RIGHT JOIN, NATURAL
LEFT JOIN y NATURAL RIGHT JOIN.

1. Devuelve un listado que muestre solamente los clientes que no han
realizado ningún pago.

```sql
select c.nombre_cliente
from cliente as c
left join transaccion as t
  on c.id_cliente = t.cod_cliente
where t.cod_cliente is null
+----------------+
| nombre_cliente |
+----------------+
| Cliente 4      |
+----------------+
```

1. Devuelve un listado que muestre solamente los clientes que no han
realizado ningún pedido.

```sql
select c.nombre_cliente
from cliente as c
left join pedido as p
  on c.id_cliente = p.codigo_cliente_pedido
where p.codigo_cliente_pedido is null
+----------------+
| nombre_cliente |
+----------------+
| Cliente 3      |
| Cliente 4      |
+----------------+
```

1. Devuelve un listado que muestre los clientes que no han realizado ningún
pago y los que no han realizado ningún pedido.

```sql
select c.nombre_cliente
from cliente as c
left join pedido as p
  on c.id_cliente = p.codigo_cliente_pedido
left join transaccion as t
  on c.id_cliente = t.cod_cliente
where p.codigo_cliente_pedido is null and t.cod_cliente is null;
+----------------+
| nombre_cliente |
+----------------+
| Cliente 4      |
+----------------+
```

1. Devuelve un listado que muestre solamente los empleados que no tienen
una oficina asociada.

```sql
select e.nombre_empleado
from empleado as e
left join oficina as o 
  on e.codigo_oficina_empleado = o.codigo_oficina
where o.codigo_oficina is null;
+-----------------+
| nombre_empleado |
+-----------------+
| Empleado 4      |
+-----------------+
```

1. Devuelve un listado que muestre solamente los empleados que no tienen un
cliente asociado.

```sql
select e.nombre_empleado
from empleado as e
left join cliente as c
  on c.codigo_empleado_rep_ventas = e.id_empleado
where c.codigo_empleado_rep_ventas is null;
+-----------------+
| nombre_empleado |
+-----------------+
| Empleado 1      |
| Empleado 2      |
| Empleado 4      |
+-----------------+
```

1. Devuelve un listado que muestre solamente los empleados que no tienen un
cliente asociado junto con los datos de la oficina donde trabajan.

```sql
select e.nombre_empleado, codigo_oficina
from empleado as e
left join cliente as c
  on c.codigo_empleado_rep_ventas = e.id_empleado
join oficina as o
  on o.codigo_oficina = e.codigo_oficina_empleado
where c.codigo_empleado_rep_ventas is null;
+-----------------+----------------+
| nombre_empleado | codigo_oficina |
+-----------------+----------------+
| Empleado 1      | O001           |
| Empleado 2      | O002           |
+-----------------+----------------+
```

1. Devuelve un listado que muestre los empleados que no tienen una oficina
asociada y los que no tienen un cliente asociado.

```sql
select e.nombre_empleado, codigo_oficina
from empleado as e
left join cliente as c
  on c.codigo_empleado_rep_ventas = e.id_empleado
left join oficina as o
  on o.codigo_oficina = e.codigo_oficina_empleado
where c.codigo_empleado_rep_ventas is null and o.codigo_oficina is null;
+-----------------+----------------+
| nombre_empleado | codigo_oficina |
+-----------------+----------------+
| Empleado 4      | NULL           |
+-----------------+----------------+
```

1. Devuelve un listado de los productos que nunca han aparecido en un
pedido.

```sql
select p.nombre
from producto as p
left join detalle_pedido as dt
 on p.codigo_producto = dt.codigo_producto_pedido
where dt.codigo_producto_pedido is null;
+------------+
| nombre     |
+------------+
| Producto 4 |
+------------+
```

1. Devuelve un listado de los productos que nunca han aparecido en un
pedido. El resultado debe mostrar el nombre, la descripción y la imagen del
producto.

```sql
select p.nombre, p.descripcion, g.imagen
from producto as p
left join detalle_pedido as dt
 on p.codigo_producto = dt.codigo_producto_pedido
join gama as g
  on p.gama_producto = g.id_gama 
where dt.codigo_producto_pedido is null;
+------------+----------------------------+-------------+
| nombre     | descripcion                | imagen      |
+------------+----------------------------+-------------+
| Producto 4 | Descripción de producto 4  | imagen4.jpg |
+------------+----------------------------+-------------+
```

1. Devuelve las oficinas donde no trabajan ninguno de los empleados que
hayan sido los representantes de ventas de algún cliente que haya realizado
la compra de algún producto de la gama Frutales.

```sql
select distinct f.codigo_oficina as oficina
from oficina as f
left join empleado as e
  on f.codigo_oficina = e.codigo_oficina_empleado
join cliente as c
  on e.id_empleado = c.codigo_empleado_rep_ventas
join pedido as p
  on c.id_cliente = p.codigo_cliente_pedido
join detalle_pedido as dp
  on p.codigo_pedido = dp.codigo_pedido_detalle
join producto as pr
 on dp.codigo_producto_pedido = pr.codigo_producto
join gama as g 
  on pr.gama_producto = g.id_gama
where g.descripcion_texto not in ('Frutales')
+---------+
| oficina |
+---------+
| O003    |
| O002    |
+---------+
```

1. Devuelve un listado con los clientes que han realizado algún pedido pero no
han realizado ningún pago.

```sql
select c.nombre_cliente
from cliente as c
join pedido as p
 on c.id_cliente = p.codigo_cliente_pedido
left join transaccion as t
  on c.id_cliente = t.cod_cliente
where t.cod_cliente is null;
+----------------+
| nombre_cliente |
+----------------+
| Cliente 3      |
+----------------+
```

1. Devuelve un listado con los datos de los empleados que no tienen clientes
asociados y el nombre de su jefe asociado.

```sql
select e1.nombre_empleado, e2.nombre_empleado as Jefe
from empleado as e1
left join cliente as c
  on e1.id_empleado = c.codigo_empleado_rep_ventas
left join empleado as e2
  on e1.codigo_jefe = e2.id_empleado
where c.codigo_empleado_rep_ventas is null;
+-----------------+------------+
| nombre_empleado | Jefe       |
+-----------------+------------+
| Empleado 1      | NULL       |
| Empleado 2      | NULL       |
| Empleado 4      | Empleado 1 |
+-----------------+------------+
```

Consultas resumen

1. ¿Cuántos empleados hay en la compañía?

```sql
select COUNT(id_empleado) as "Numero empleados"
from empleado 
+------------------+
| Numero empleados |
+------------------+
|                5 |
+------------------+

```

1. ¿Cuántos clientes tiene cada país?

```sql
select p.pais, COUNT(id_pais_cliente) as "Numero clientes"
from cliente as e
join pais as p
  on e.id_pais_cliente = p.id_pais
group by p.pais
+---------+-----------------+
| pais    | Numero clientes |
+---------+-----------------+
| País A  |               1 |
| País B  |               2 |
| España  |               1 |
	+---------+-----------------+
```

1. ¿Cuál fue el pago medio en 2009?

```sql
select AVG(total_transaccion)
from transaccion
where YEAR(fecha_transaccion)  = 2009;
+------------------------+
| AVG(total_transaccion) |
+------------------------+
|            1299.900000 |
+------------------------+
```

1. ¿Cuántos pedidos hay en cada estado? Ordena el resultado de forma
descendente por el número de pedidos.

```sql
select e.estado, count(p.codigo_pedido) as pedidos
from pedido as p
join estado as e
  on p.estado_pedido = e.id_estado
group by e.id_estado
order by pedidos desc;
+-------------+---------+
| estado      | pedidos |
+-------------+---------+
| En progreso |       2 |
| Rechazado   |       1 |
+-------------+---------+
```

1. Calcula el precio de venta del producto más caro y más barato en una
misma consulta.

```sql
select p1.precio_venta as "precio mas caro", p2.precio_venta as "precio mas barato"
from producto as p1
join producto as p2
order by p1.precio_venta desc, p2.precio_venta asc
limit 1;
+-----------------+-------------------+
| precio mas caro | precio mas barato |
+-----------------+-------------------+
|          129.99 |             89.99 |
+-----------------+-------------------+
```

1. Calcula el número de clientes que tiene la empresa.

```sql
select count(id_cliente) as Clientes
from cliente
+----------+
| Clientes |
+----------+
|        4 |
+----------+
```

1. ¿Cuántos clientes existen con domicilio en la ciudad de Madrid?

```sql
select COUNT(c.id_cliente) as "Clientes en madrid"
from cliente as c
join ciudad as ci
  on c.id_ciudad_cliente = ci.id_ciudad
where ci.ciudad = 'Madrid'
+--------------------+
| Clientes en madrid |
+--------------------+
|                  2 |
+--------------------+
```

1. ¿Calcula cuántos clientes tiene cada una de las ciudades que empiezan
por M?

```sql
select COUNT(c.id_cliente) as "Clientes en m--"
from cliente as c
join ciudad as ci
  on c.id_ciudad_cliente = ci.id_ciudad
where ci.ciudad like "M%";
+-----------------+
| Clientes en m-- |
+-----------------+
|               2 |
+-----------------+
```

1. Devuelve el nombre de los representantes de ventas y el número de clientes
al que atiende cada uno.

```sql
select e.nombre_empleado, count(c.id_cliente) as "numero clientes"
from empleado as e
left join cliente as c
  on e.id_empleado = c.codigo_empleado_rep_ventas
group by e.id_empleado
+-----------------+-----------------+
| nombre_empleado | numero clientes |
+-----------------+-----------------+
| Empleado 1      |               0 |
| Empleado 2      |               0 |
| Empleado 3      |               2 |
| Empleado 4      |               0 |
| Empleado 5      |               1 |
+-----------------+-----------------+
```

1. Calcula el número de clientes que no tiene asignado representante de
ventas.

```sql
select count(c.id_cliente) as "clientes sin representante"
from cliente as c
left join empleado as e
  on e.id_empleado = c.codigo_empleado_rep_ventas
where c.codigo_empleado_rep_ventas is null;
+----------------------------+
| clientes sin representante |
+----------------------------+
|                          1 |
+----------------------------+

```

1. Calcula la fecha del primer y último pago realizado por cada uno de los
clientes. El listado deberá mostrar el nombre y los apellidos de cada cliente.

```sql
select c.nombre_cliente, MIN(t1.fecha_transaccion) as "primer pago", MAX(t2.fecha_transaccion) as "ultimo pago"
from cliente as c
left join transaccion as t1
  on c.id_cliente = t1.cod_cliente
left join transaccion as t2
  on c.id_cliente = t2.cod_cliente
group by c.id_cliente;
+----------------+-------------+-------------+
| nombre_cliente | primer pago | ultimo pago |
+----------------+-------------+-------------+
| Cliente 1      | 2008-01-05  | 2008-01-05  |
| Cliente 2      | 2008-02-15  | 2008-02-15  |
| Cliente 3      | NULL        | NULL        |
| Cliente 4      | 2009-03-05  | 2009-04-10  |
+----------------+-------------+-------------+
```

1. Calcula el número de productos diferentes que hay en cada uno de los
pedidos.

```sql
select p.codigo_pedido, count(dp.codigo_pedido_detalle)
from pedido as p
join detalle_pedido as dp
  on p.codigo_pedido = dp.codigo_pedido_detalle
group by p.codigo_pedido;
+---------------+---------------------------------+
| codigo_pedido | count(dp.codigo_pedido_detalle) |
+---------------+---------------------------------+
|          1001 |                               2 |
|          1002 |                               2 |
|          1003 |                               2 |
+---------------+---------------------------------+
```

1. Calcula la suma de la cantidad total de todos los productos que aparecen en
cada uno de los pedidos.

```sql
select p.codigo_pedido, sum(dp.cantidad)
from pedido as p
join detalle_pedido as dp
  on p.codigo_pedido = dp.codigo_pedido_detalle
group by p.codigo_pedido;
+---------------+------------------+
| codigo_pedido | sum(dp.cantidad) |
+---------------+------------------+
|          1001 |                9 |
|          1002 |               10 |
|          1003 |               18 |
+---------------+------------------+
```

1. Devuelve un listado de los 20 productos más vendidos y el número total de
unidades que se han vendido de cada uno. El listado deberá estar ordenado
por el número total de unidades vendidas.

```sql
select p.nombre, sum(dp.cantidad) as cantidad
from producto as p
left join detalle_pedido as dp
  on p.codigo_producto = dp.codigo_producto_pedido
group by p.nombre
order by cantidad desc
limit 0,20;
+------------+----------+
| nombre     | cantidad |
+------------+----------+
| Producto 3 |       22 |
| Producto 1 |        8 |
| Producto 2 |        7 |
| Producto 4 |     NULL |
+------------+----------+
```

1. La facturación que ha tenido la empresa en toda la historia, indicando la
base imponible, el IVA y el total facturado. La base imponible se calcula
sumando el coste del producto por el número de unidades vendidas de la
tabla detalle_pedido. El IVA es el 21 % de la base imponible, y el total la
suma de los dos campos anteriores.

```sql
select p.nombre, sum(dp.cantidad*dp.precio_unidad) as "base imponible", sum(dp.cantidad*dp.precio_unidad)*0.21 as iva, sum(dp.cantidad*dp.precio_unidad)*1.21 as total
from producto as p
left join detalle_pedido as dp
  on p.codigo_producto = dp.codigo_producto_pedido
group by p.codigo_producto;
+------------+----------------+----------+-----------+
| nombre     | base imponible | iva      | total     |
+------------+----------------+----------+-----------+
| Producto 1 |         889.92 | 186.8832 | 1076.8032 |
| Producto 2 |         759.93 | 159.5853 |  919.5153 |
| Producto 3 |        2789.78 | 585.8538 | 3375.6338 |
| Producto 4 |           NULL |     NULL |      NULL |
+------------+----------------+----------+-----------+
```

1. La misma información que en la pregunta anterior, pero agrupada por
código de producto.

```sql
select p.nombre, sum(dp.cantidad*dp.precio_unidad) as "base imponible", sum(dp.cantidad*dp.precio_unidad)*0.21 as iva, sum(dp.cantidad*dp.precio_unidad)*1.21 as total
from producto as p
left join detalle_pedido as dp
  on p.codigo_producto = dp.codigo_producto_pedido
group by p.codigo_producto;
+------------+----------------+----------+-----------+
| nombre     | base imponible | iva      | total     |
+------------+----------------+----------+-----------+
| Producto 1 |         889.92 | 186.8832 | 1076.8032 |
| Producto 2 |         759.93 | 159.5853 |  919.5153 |
| Producto 3 |        2789.78 | 585.8538 | 3375.6338 |
| Producto 4 |           NULL |     NULL |      NULL |
+------------+----------------+----------+-----------+
```

1. La misma información que en la pregunta anterior, pero agrupada por
código de producto filtrada por los códigos que empiecen por OR.

```sql
select p.nombre, sum(dp.cantidad*dp.precio_unidad) as "base imponible", sum(dp.cantidad*dp.precio_unidad)*0.21 as iva, sum(dp.cantidad*dp.precio_unidad)*1.21 as total
from producto as p
left join detalle_pedido as dp
  on p.codigo_producto = dp.codigo_producto_pedido
where p.codigo_producto like "OR%"
group by p.codigo_producto;
```

1. Lista las ventas totales de los productos que hayan facturado más de 3000
euros. Se mostrará el nombre, unidades vendidas, total facturado y total
facturado con impuestos (21% IVA).

```sql
select p.nombre, sum(dp.cantidad) as "cantidad vendida", sum(dp.precio_unidad*dp.cantidad) as "total facturado",sum(dp.cantidad*dp.precio_unidad)*1.21 as total
from producto as p
left join detalle_pedido as dp
  on p.codigo_producto = dp.codigo_producto_pedido
group by p.codigo_producto
having sum(dp.precio_unidad*dp.cantidad) > 3000;
+------------+------------------+-----------------+-----------+
| nombre     | cantidad vendida | total facturado | total     |
+------------+------------------+-----------------+-----------+
| Producto 2 |                7 |         3159.93 | 3823.5153 |
+------------+------------------+-----------------+-----------+
```

1. Muestre la suma total de todos los pagos que se realizaron para cada uno
de los años que aparecen en la tabla pagos.

```sql
select year(fecha_transaccion),sum(total_transaccion)
from transaccion 
group by year(fecha_transaccion);
+-------------------------+------------------------+
| year(fecha_transaccion) | sum(total_transaccion) |
+-------------------------+------------------------+
|                    2008 |                 859.92 |
|                    2009 |                2599.80 |
+-------------------------+------------------------+
```

Subconsultas
Con operadores básicos de comparación

1. Devuelve el nombre del cliente con mayor límite de crédito.

```sql
select nombre_cliente
from cliente
where limite_credito =(
  select max(limite_credito)
  from cliente
  );
+----------------+
| nombre_cliente |
+----------------+
| Cliente 2      |
+----------------+
```

1. Devuelve el nombre del producto que tenga el precio de venta más caro.

```sql
select nombre
from producto 
where precio_venta = (
  select max(precio_venta)
  from producto
  );
+------------+
| nombre     |
+------------+
| Producto 3 |
+------------+
```

1. Devuelve el nombre del producto del que se han vendido más unidades.
(Tenga en cuenta que tendrá que calcular cuál es el número total de
unidades que se han vendido de cada producto a partir de los datos de la
tabla detalle_pedido)

```sql
select p.nombre
from producto as p
join (
  select dp.codigo_producto_pedido as mas_vendido
  from detalle_pedido as dp
  group by dp.codigo_producto_pedido
  order by sum(dp.cantidad) asc
  limit 1
  ) as mayor
  on p.codigo_producto = mayor.mas_vendido;
+------------+
| nombre     |
+------------+
| Producto 2 |
+------------+
  
```

1. Los clientes cuyo límite de crédito sea mayor que los pagos que haya
realizado. (Sin utilizar INNER JOIN).

```sql
select c.nombre_cliente
from cliente as c
where c.limite_credito > (
  select sum(t.total_transaccion)
  from transaccion as t
  where c.id_cliente = t.cod_cliente
  group by t.cod_cliente
  );
+----------------+
| nombre_cliente |
+----------------+
| Cliente 1      |
| Cliente 2      |
+----------------+
```

1. Devuelve el producto que más unidades tiene en stock.

```sql
select p.nombre
from producto  as p
join (
  select s.id_stock as stock_producto
  from stock as s
  order by s.cantidad_producto desc
  limit 1
  ) as cantidad
on p.cantidad_stock = cantidad.stock_producto;
+------------+
| nombre     |
+------------+
| Producto 3 |
+------------+
```

1. Devuelve el producto que menos unidades tiene en stock.

```sql
select p.nombre
from producto  as p
join (
  select s.id_stock as stock_producto
  from stock as s
  order by s.cantidad_producto asc
  limit 1
  ) as cantidad
on p.cantidad_stock = cantidad.stock_producto;
+------------+
| nombre     |
+------------+
| Producto 1 |
+------------+
```

1. Devuelve el nombre, los apellidos y el email de los empleados que están a
cargo de Alberto Soria.

```sql
select nombre_empleado,apellido1_empleado,apellido2_empleado, email_empleado
from empleado
where id_empleado = (
  select codigo_jefe
  from empleado 
  where nombre_empleado = 'Alberto' and apellido1_empleado = 'Soria');
+-----------------+---------------------+---------------------+-----------------------+
| nombre_empleado | apellido1_empleado  | apellido2_empleado  | email_empleado        |
+-----------------+---------------------+---------------------+-----------------------+
| Empleado 1      | Apellido Empleado 1 | Apellido Empleado 2 | empleado1@example.com |
+-----------------+---------------------+---------------------+-----------------------+
```

Subconsultas con ALL y ANY

1. Devuelve el nombre del cliente con mayor límite de crédito.

```sql
select nombre_cliente
from cliente
where limite_credito > any(
  select limite_credito
  from cliente
  );
+----------------+
| nombre_cliente |
+----------------+
| Cliente 2      |
+----------------+
```

1. Devuelve el nombre del producto que tenga el precio de venta más caro.

```sql
select nombre
from producto
where precio_venta >= all(
  select precio_venta
  from producto
  );
+------------+
| nombre     |
+------------+
| Producto 3 |
+------------+
```

1. Devuelve el producto que menos unidades tiene en stock.

```sql
select nombre
from producto
where cantidad_stock = (
  select id_stock
  from stock
  where cantidad_producto <= all(
    select cantidad_producto
    from stock
    )
  );
+------------+
| nombre     |
+------------+
| Producto 1 |
+------------+
```

Subconsultas con IN y NOT IN

1. Devuelve el nombre, apellido1 y cargo de los empleados que no
representen a ningún cliente.

```sql
select concat(nombre_empleado, ' ', apellido1_empleado) as "nombre completo", puesto
from empleado
where id_empleado NOT IN (
  select codigo_empleado_rep_ventas
  from cliente
  where codigo_empleado_rep_ventas is not null
  );
+--------------------------------+----------+
| nombre completo                | puesto   |
+--------------------------------+----------+
| Empleado 1 Apellido Empleado 1 | Vendedor |
| Empleado 2 Apellido Empleado 3 | Gerente  |
| Alberto Soria                  | Gerente  |
+--------------------------------+----------+
```

1. Devuelve un listado que muestre solamente los clientes que no han
realizado ningún pago.

```sql
select nombre_cliente
from cliente
where id_cliente not in (
  select cod_cliente
  from transaccion
  );
+----------------+
| nombre_cliente |
+----------------+
| Cliente 3      |
+----------------+
```

1. Devuelve un listado que muestre solamente los clientes que sí han realizado
algún pago.

```sql
select nombre_cliente
from cliente
where id_cliente in (
  select cod_cliente
  from transaccion
  );
+----------------+
| nombre_cliente |
+----------------+
| Cliente 1      |
| Cliente 2      |
| Cliente 4      |
+----------------+
```

1. Devuelve un listado de los productos que nunca han aparecido en un
pedido.

```sql
select nombre
from producto
where codigo_producto not in (
  select codigo_producto_pedido
  from detalle_pedido
  );
+------------+
| nombre     |
+------------+
| Producto 4 |
+------------+
```

1. Devuelve el nombre, apellidos, puesto y teléfono de la oficina de aquellos
empleados que no sean representante de ventas de ningún cliente.

```sql
select concat(e.nombre_empleado, ' ', e.apellido1_empleado) as "nombre completo", e.puesto, concat(t.prefijo,' ',t.numero) as numero
from empleado as e
left join oficina as o
  on e.codigo_oficina_empleado = o.codigo_oficina
join telefono as t
  on o.id_telefono_oficina = t.id_telefono
where e.id_empleado NOT IN (
  select c.codigo_empleado_rep_ventas
  from cliente as c
  where c.codigo_empleado_rep_ventas is not null
  );
+--------------------------------+----------+---------------+
| nombre completo                | puesto   | numero        |
+--------------------------------+----------+---------------+
| Empleado 1 Apellido Empleado 1 | Vendedor | +34 111111111 |
| Empleado 2 Apellido Empleado 3 | Gerente  | +34 222222222 |
+--------------------------------+----------+---------------+
```

1. Devuelve las oficinas donde no trabajan ninguno de los empleados que
hayan sido los representantes de ventas de algún cliente que haya realizado
la compra de algún producto de la gama Frutales.

```sql
select  o.codigo_oficina
from  oficina as o
where not exists 
  (
  select 1
  from empleado as e
  join cliente as c 
    on e.id_empleado = c.codigo_empleado_rep_ventas
  join pedido as p 
    on c.id_cliente = p.codigo_cliente_pedido
  join detalle_pedido as dp 
    on p.codigo_pedido = dp.codigo_pedido_detalle
  join producto as pr 
    on dp.codigo_producto_pedido = pr.codigo_producto
  where pr.gama_producto = 'G004'and e.codigo_oficina_empleado = o.codigo_oficina
  );
+----------------+
| codigo_oficina |
+----------------+
| O001           |
| O002           |
| O003           |
+----------------+
```

1. Devuelve un listado con los clientes que han realizado algún pedido pero no
han realizado ningún pago.

```sql

```

Subconsultas con EXISTS y NOT EXISTS
18. Devuelve un listado que muestre solamente los clientes que no han
realizado ningún pago.

```sql

```

19. Devuelve un listado que muestre solamente los clientes que sí han realizado
algún pago.

```sql

```

20. Devuelve un listado de los productos que nunca han aparecido en un
pedido.

```sql

```

21. Devuelve un listado de los productos que han aparecido en un pedido
alguna vez.

```sql

```

Subconsultas correlacionadas
Consultas variadas

1. Devuelve el listado de clientes indicando el nombre del cliente y cuántos
pedidos ha realizado. Tenga en cuenta que pueden existir clientes que no
han realizado ningún pedido.

```sql
select concat(c.nombre_cliente,' ',c.apellido1_cliente) as nombre, (
  select count(p.codigo_pedido)
  from pedido as p
  where p.codigo_cliente_pedido = c.id_cliente
  ) as pedidos
from cliente as c;
+---------------------+---------+
| nombre              | pedidos |
+---------------------+---------+
| Cliente 1 Apellido1 |       1 |
| Cliente 2 Apellido3 |       1 |
| Cliente 3 Apellido5 |       1 |
| Cliente 4 Apellido7 |       0 |
+---------------------+---------+
```

1. Devuelve un listado con los nombres de los clientes y el total pagado por
cada uno de ellos. Tenga en cuenta que pueden existir clientes que no han
realizado ningún pago.

```sql
select concat(c.nombre_cliente,' ',c.apellido1_cliente) as nombre, (
  select sum(t.total_transaccion)
  from transaccion as t
  where t.cod_cliente = c.id_cliente
  ) as pago
from cliente as c;
+---------------------+---------+
| nombre              | pago    |
+---------------------+---------+
| Cliente 1 Apellido1 |  499.95 |
| Cliente 2 Apellido3 |  359.97 |
| Cliente 3 Apellido5 |    NULL |
| Cliente 4 Apellido7 | 2599.80 |
+---------------------+---------+
```

1. Devuelve el nombre de los clientes que hayan hecho pedidos en 2008
ordenados alfabéticamente de menor a mayor.

```sql
select concat(c.nombre_cliente,' ',c.apellido1_cliente) as nombre, (
  select p.fecha_pedido 
  from pedido as p
  where p.codigo_cliente_pedido = c.id_cliente and year(p.fecha_pedido) = 2008
  ) as fecha
from cliente as c
order by nombre_cliente asc;
+---------------------+------------+
| nombre              | fecha      |
+---------------------+------------+
| Cliente 1 Apellido1 | NULL       |
| Cliente 2 Apellido3 | NULL       |
| Cliente 3 Apellido5 | 2008-03-01 |
| Cliente 4 Apellido7 | NULL       |
+---------------------+------------+
```

1. Devuelve el nombre del cliente, el nombre y primer apellido de su
representante de ventas y el número de teléfono de la oficina del
representante de ventas, de aquellos clientes que no hayan realizado ningún
pago.

```sql
select c.nombre_cliente, 
  (
  select concat(e.nombre_empleado, ' ', apellido1_empleado)
  from empleado as e
  where c.codigo_empleado_rep_ventas = e.id_empleado
  ) as Representante,
  (
  select concat(tel.prefijo,' ',tel.numero) 
  from telefono as tel
  join oficina as o
    on tel.id_telefono = o.id_telefono_oficina
  join empleado as e
    on o.codigo_oficina = e.codigo_oficina_empleado
  where c.codigo_empleado_rep_ventas = e.id_empleado
  ) as "numero tel oficina"
from cliente as c
left join transaccion as t
  on c.id_cliente = t.cod_cliente
where t.cod_cliente is null;
+----------------+--------------------------------+--------------------+
| nombre_cliente | Representante                  | numero tel oficina |
+----------------+--------------------------------+--------------------+
| Cliente 3      | Empleado 3 Apellido Empleado 5 | +34 222222222      |
+----------------+--------------------------------+--------------------+
```

1. Devuelve el listado de clientes donde aparezca el nombre del cliente, el
nombre y primer apellido de su representante de ventas y la ciudad donde
está su oficina.

```sql
select c.nombre_cliente, 
  (
  select concat(e.nombre_empleado, ' ', apellido1_empleado)
  from empleado as e
  where c.codigo_empleado_rep_ventas = e.id_empleado
  ) as Representante,
  (
  select ci.ciudad
  from ciudad as ci
  join oficina as o
    on ci.id_ciudad = o.id_ciudad_oficina
  join empleado as e
    on o.codigo_oficina = e.codigo_oficina_empleado
  where c.codigo_empleado_rep_ventas = e.id_empleado
  ) as ciudad
from cliente as c;
+----------------+--------------------------------+----------+
| nombre_cliente | Representante                  | ciudad   |
+----------------+--------------------------------+----------+
| Cliente 1      | Empleado 3 Apellido Empleado 5 | Madrid   |
| Cliente 2      | Empleado 5 Apellido Empleado 9 | Ciudad B |
| Cliente 3      | Empleado 3 Apellido Empleado 5 | Madrid   |
| Cliente 4      | NULL                           | NULL     |
+----------------+--------------------------------+----------+
```

1. Devuelve el nombre, apellidos, puesto y teléfono de la oficina de aquellos
empleados que no sean representante de ventas de ningún cliente.

```sql
select distinct concat(e.nombre_empleado, ' ', apellido1_empleado) as "representante de ventas", e.puesto,
  (
  select concat(tel.prefijo,' ',tel.numero) 
  from telefono as tel
  join oficina as o
    on tel.id_telefono = o.id_telefono_oficina
  join empleado as e
    on o.codigo_oficina = e.codigo_oficina_empleado
  where c.codigo_empleado_rep_ventas = e.id_empleado
  ) as "numero tel oficina"
from empleado as e
join cliente as c
  on c.codigo_empleado_rep_ventas = e.id_empleado
+--------------------------------+-------------------------+--------------------+
| representante de ventas        | puesto                  | numero tel oficina |
+--------------------------------+-------------------------+--------------------+
| Empleado 3 Apellido Empleado 5 | Representante de Ventas | +34 222222222      |
| Empleado 5 Apellido Empleado 9 | Representante de Ventas | +34 222222222      |
+--------------------------------+-------------------------+--------------------+
```

1. Devuelve un listado indicando todas las ciudades donde hay oficinas y el
número de empleados que tiene.

```sql
select c.ciudad,
  (
  select count(e.id_empleado)
  from oficina as o
  join empleado as e
    on o.codigo_oficina = e.codigo_oficina_empleado
  where o.id_ciudad_oficina = c.id_ciudad
  ) as "numero empleados"
from ciudad as c;
+-------------+------------------+
| ciudad      | numero empleados |
+-------------+------------------+
| Ciudad A    |                1 |
| Ciudad B    |                2 |
| Madrid      |                1 |
| Fuenlabrada |                0 |
+-------------+------------------+
```

## VISTAS

### **1. Vista de Empleados por Oficina**

```sql
CREATE VIEW empleados_por_oficina AS
SELECT e.id_empleado, e.nombre_empleado, e.apellido1_empleado, e.codigo_oficina_empleado
FROM empleado AS e; 

SELECT *
FROM empleados_por_oficina

+-------------+-----------------+---------------------+-------------------------+
| id_empleado | nombre_empleado | apellido1_empleado  | codigo_oficina_empleado |
+-------------+-----------------+---------------------+-------------------------+
|           1 | Empleado 1      | Apellido Empleado 1 | O001                    |
|           2 | Empleado 2      | Apellido Empleado 3 | O002                    |
|           3 | Empleado 3      | Apellido Empleado 5 | O003                    |
|           4 | Alberto         | Soria               | NULL                    |
|           5 | Empleado 5      | Apellido Empleado 9 | O002                    |
+-------------+-----------------+---------------------+-------------------------+
```

### **2. Vista de Productos en Stock**

```sql
CREATE VIEW productos_en_stock AS
SELECT p.nombre, s.cantidad_producto AS cantidad
FROM producto AS p
JOIN stock AS s
  ON p.cantidad_stock = s.id_stock;

SELECT *
FROM productos_en_stock

+------------+----------+
| nombre     | cantidad |
+------------+----------+
| Producto 1 |       25 |
| Producto 2 |       30 |
| Producto 3 |      150 |
| Producto 4 |       50 |
+------------+----------+
```

### **3. Vista de Pedidos por Cliente**

```sql
CREATE VIEW pedidos_por_cliente AS
SELECT c.nombre_cliente, p.codigo_pedido, p.fecha_pedido, p.estado_pedido
FROM cliente AS c
JOIN pedido AS p
  ON c.id_cliente = p.codigo_cliente_pedido;

SELECT *
FROM pedidos_por_cliente

+----------------+---------------+--------------+---------------+
| nombre_cliente | codigo_pedido | fecha_pedido | estado_pedido |
+----------------+---------------+--------------+---------------+
| Cliente 1      |          1001 | 2024-01-01   |             1 |
| Cliente 2      |          1002 | 2009-02-01   |             2 |
| Cliente 3      |          1003 | 2008-03-01   |             1 |
+----------------+---------------+--------------+---------------+
```

### **4. Vista de Clientes que No Han Realizado Pagos**

```sql
CREATE VIEW clientes_sin_pagos AS
SELECT c.nombre_cliente
FROM cliente AS c
LEFT JOIN transaccion AS t
  ON c.id_cliente = t.cod_cliente
WHERE t.cod_cliente IS NULL;

SELECT *
FROM clientes_sin_pagos

+----------------+
| nombre_cliente |
+----------------+
| Cliente 3      |
+----------------+
```

### **5. Vista de Productos Nunca Vendidos**

```sql
CREATE VIEW productos_no_vendidos AS
SELECT p.nombre
FROM producto AS p
WHERE NOT EXISTS (
  SELECT dp.codigo_producto_pedido
  FROM
    detalle_pedido AS dp
  WHERE
    dp.codigo_producto_pedido = p.codigo_producto
  );

SELECT *
FROM productos_no_vendidos

+------------+
| nombre     |
+------------+
| Producto 4 |
+------------+
```

### **6. Vista para Empleados por Ciudad**

```sql
CREATE VIEW empleados_por_ciudad as
SELECT e.nombre_empleado, c.ciudad
FROM empleado as e
LEFT JOIN oficina as o
  ON e.codigo_oficina_empleado = o.codigo_oficina
JOIN ciudad as c
  ON o.id_ciudad_oficina = c.id_ciudad;

SELECT *
FROM empleados_por_ciudad
+-----------------+----------+
| nombre_empleado | ciudad   |
+-----------------+----------+
| Empleado 1      | Ciudad A |
| Empleado 2      | Ciudad B |
| Empleado 5      | Ciudad B |
| Empleado 3      | Madrid   |
+-----------------+----------+
```

### **7. Vista para Productos por Gama**

```sql
CREATE VIEW productos_gama AS
SELECT p.nombre, g.descripcion_texto
FROM producto as p
LEFT JOIN gama as g
  ON p.gama_producto = g.id_gama;
  
SELECT *
FROM productos_gama

+------------+------------------------+
| nombre     | descripcion_texto      |
+------------+------------------------+
| Producto 1 | Descripción de gama 1  |
| Producto 2 | Descripción de gama 2  |
| Producto 3 | Ornamentales           |
| Producto 4 | Frutales               |
+------------+------------------------+
```

### **8. Vista para Pedidos en Progreso**

```sql
CREATE VIEW pedidos_en_progreso AS
SELECT p.codigo_pedido, e.estado
FROM pedido as p
LEFT JOIN estado as e
  ON p.estado_pedido = e.id_estado
WHERE e.id_estado = 1;

SELECT *
FROM pedidos_en_progreso

+---------------+-------------+
| codigo_pedido | estado      |
+---------------+-------------+
|          1001 | En progreso |
|          1003 | En progreso |
+---------------+-------------+
```

### **9. Vista para Transacciones por Cliente**

```sql
CREATE VIEW transacciones_por_cliente AS
SELECT c.nombre_cliente, t.id_transaccion, t.fecha_transaccion
FROM cliente as c
LEFT JOIN transaccion as t
  ON c.id_cliente = t.cod_cliente
WHERE t.cod_cliente IS NOT NULL;
  
SELECT *
FROM transacciones_por_cliente
+----------------+----------------+-------------------+
| nombre_cliente | id_transaccion | fecha_transaccion |
+----------------+----------------+-------------------+
| Cliente 1      | T001           | 2008-01-05        |
| Cliente 2      | T002           | 2008-02-15        |
| Cliente 4      | T003           | 2009-03-05        |
| Cliente 4      | T004           | 2009-04-10        |
+----------------+----------------+-------------------+
```

### **10. Vista para Empleados sin Jefe**

```sql
CREATE VIEW empleados_sin_jefe AS
SELECT nombre_empleado
FROM empleado
WHERE codigo_jefe IS NULL;

SELECT *
FROM empleados_sin_jefe;

+-----------------+
| nombre_empleado |
+-----------------+
| Empleado 1      |
| Empleado 2      |
+-----------------+
```

## PROCEDIMIENTOS ALMACENADOS

**1. Obtener Empleados por Oficina**

```sql
DELIMITER //

CREATE PROCEDURE obtener_empleados_por_oficina (IN codigo_oficina VARCHAR(10))
BEGIN
    SELECT e.id_empleado, e.nombre_empleado, e.apellido1_empleado, e.apellido2_empleado, e.puesto
    FROM empleado AS e
    WHERE e.codigo_oficina_empleado = codigo_oficina;
END//

DELIMITER ;

CALL obtener_empleados_por_oficina('O001');

+-------------+-----------------+---------------------+---------------------+----------+
| id_empleado | nombre_empleado | apellido1_empleado  | apellido2_empleado  | puesto   |
+-------------+-----------------+---------------------+---------------------+----------+
|           1 | Empleado 1      | Apellido Empleado 1 | Apellido Empleado 2 | Vendedor |
+-------------+-----------------+---------------------+---------------------+----------+
```

### **2. Insertar Nuevo Producto**

```sql
DELIMITER //

CREATE PROCEDURE insertar_producto (
    IN codigo_producto INT(10),
    IN nombre_producto VARCHAR(100),
    IN gama_producto VARCHAR(50),
    IN dimensiones_producto INT,
    IN descripcion TEXT,
    IN id_proveedor_producto INT,
    IN cantidad_stock INT,
    IN precio_venta DECIMAL(15,2),
    IN precio_proveedor DECIMAL(15,2)
)
BEGIN
    INSERT INTO producto (codigo_producto, nombre, gama_producto, dimensiones_producto, descripcion, id_proveedor_producto, cantidad_stock, precio_venta, precio_proveedor) VALUES
    (codigo_producto, nombre_producto, gama_producto, dimensiones_producto, descripcion, id_proveedor_producto, cantidad_stock, precio_venta, precio_proveedor);
END//

DELIMITER ;

CALL insertar_producto(
    1005,
    'Nuevo Producto',
    'G002',  
    1, 
    'Descripción del nuevo producto',  
    1, 
    4, 
    49.99,  
    25.50 
);
```

### **3. Obtener Pedidos por Cliente**

```sql
DELIMITER //

CREATE PROCEDURE obtener_pedidos_por_cliente (IN id_cliente INT)
BEGIN
    SELECT p.codigo_pedido, p.fecha_pedido, p.fecha_esperada, p.fecha_entrega, p.estado_pedido
    FROM pedido AS p
    WHERE p.codigo_cliente_pedido = id_cliente;
END//

DELIMITER ;

CALL obtener_pedidos_por_cliente(3);
+---------------+--------------+----------------+---------------+---------------+
| codigo_pedido | fecha_pedido | fecha_esperada | fecha_entrega | estado_pedido |
+---------------+--------------+----------------+---------------+---------------+
|          1003 | 2008-03-01   | 2024-03-10     | 2024-03-09    |             1 |
+---------------+--------------+----------------+---------------+---------------+
```

### **4. Actualizar Información del Cliente**

```sql
DELIMITER //

CREATE PROCEDURE actualizar_cliente (
    IN id_cliente INT,
    IN nuevo_nombre VARCHAR(50),
    IN nuevo_apellido1 VARCHAR(50),
    IN nuevo_apellido2 VARCHAR(50),
    IN nuevo_telefono INT
)
BEGIN
    UPDATE cliente
    SET nombre_cliente = nuevo_nombre, apellido1_cliente = nuevo_apellido1, apellido2_cliente = nuevo_apellido2, telefono_cliente = nuevo_telefono
    WHERE id_cliente = id_cliente;
END//

DELIMITER ;

CALL actualizar_cliente(
  4,
  'Jaime',
  'Perez',
  'Hernandez',
  1
);
```

### **5. Eliminar Pedido**

```sql
CREATE PROCEDURE eliminar_pedido (IN codigo_pedido INT)
BEGIN
    DELETE FROM pedido
    WHERE
        codigo_pedido = codigo_pedido;
END;
```

### **6. Registrar un nuevo empleado**

```sql
DELIMITER //

CREATE PROCEDURE registrar_nuevo_empleado (
  IN id_empleado INT(11),
  IN nombre_empleado VARCHAR(50),
  IN apellido1_empleado VARCHAR(50),
  IN apellido2_empleado VARCHAR(50),
  IN extension VARCHAR(10),
  IN email_empleado VARCHAR(100),
  IN codigo_oficina_empleado VARCHAR(10),
  IN codigo_jefe INT(11),
  IN puesto VARCHAR(50)
)
BEGIN 
  INSERT INTO empleado (id_empleado, nombre_empleado, apellido1_empleado, apellido2_empleado, extension, email_empleado, codigo_oficina_empleado, codigo_jefe, puesto) VALUES
  (id_empleado, nombre_empleado, apellido1_empleado, apellido2_empleado, extension, email_empleado, codigo_oficina_empleado, codigo_jefe, puesto);
END//

DELIMITER ;

CALL registrar_nuevo_empleado(
  6,
  'pepito',
  'perez',
  'paez',
  '569',
  'pepito@gmail.com',
  'O001',
  2,
  'Representante de Ventas'
);
```

### **7. Obtener clientes con límite de crédito alto**

```sql
DELIMITER //

CREATE PROCEDURE clientes_limite_credito_alto (IN limite_credito_minimo DECIMAL(15, 2))
BEGIN 
  SELECT 
    nombre_cliente, 
    apellido1_cliente, 
    apellido2_cliente, 
    limite_credito
  FROM 
    cliente
  WHERE 
    limite_credito >= limite_credito_minimo
  ORDER BY 
    limite_credito DESC;
END//

DELIMITER ;

+----------------+-------------------+-------------------+----------------+
| nombre_cliente | apellido1_cliente | apellido2_cliente | limite_credito |
+----------------+-------------------+-------------------+----------------+
| Cliente 2      | Apellido3         | Apellido4         |       15000.00 |
| Cliente 1      | Apellido1         | Apellido2         |       10000.00 |
+----------------+-------------------+-------------------+----------------+
```

### **8. Actualizar el estado de un pedido**

```sql
DELIMITER //

CREATE PROCEDURE actualizar_estado_pedido(
  IN codigo_pedido INT(11),
  IN nuevo_estado INT(10)
  )
BEGIN
  UPDATE pedido
  SET nuevo_estado = estado_pedido
  WHERE codigo_pedido = codigo_pedido;
END//

DELIMITER ;

CALL actualizar_estado_pedido(
  1001,
  2
);
```

### **9. Obtener la lista de clientes sin transacciones**

```sql
DELIMITER //

CREATE PROCEDURE clientes_sin_transacciones ()
BEGIN
  SELECT c.nombre_cliente
  FROM cliente as c
  LEFT JOIN transaccion as t
    on c.id_cliente = t.cod_cliente
  WHERE t.cod_cliente IS NULL;
END//
DELIMITER ;

CALL clientes_sin_transacciones();

+----------------+
| nombre_cliente |
+----------------+
| Cliente 3      |
+----------------+
```

### **10. Obtener productos de una gama específica**

```sql
DELIMITER //

CREATE PROCEDURE productos_gama(IN gama_producto VARCHAR(50))
BEGIN
  SELECT p.nombre
  FROM producto as p
  LEFT JOIN gama as g
   ON p.gama_producto = g.id_gama
  WHERE g.id_gama = gama_producto;
END//
DELIMITER ;

CALL productos_gama('G001');

+------------+
| nombre     |
+------------+
| Producto 1 |
+------------+
```

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



## Consultas multitabla (Composición interna)

Resuelva todas las consultas utilizando la sintaxis de SQL1 y SQL2. Las consultas con
sintaxis de SQL2 se deben resolver con INNER JOIN y NATURAL JOIN.

1. Obtén un listado con el nombre de cada cliente y el nombre y apellido de su
  representante de ventas.

2. Muestra el nombre de los clientes que hayan realizado pagos junto con el
  nombre de sus representantes de ventas.

3. Muestra el nombre de los clientes que no hayan realizado pagos junto con
  el nombre de sus representantes de ventas.

4. Devuelve el nombre de los clientes que han hecho pagos y el nombre de sus
  representantes junto con la ciudad de la oficina a la que pertenece el
  representante.

5. Devuelve el nombre de los clientes que no hayan hecho pagos y el nombre
  de sus representantes junto con la ciudad de la oficina a la que pertenece el
  representante.

6. Lista la dirección de las oficinas que tengan clientes en Fuenlabrada.

7. Devuelve el nombre de los clientes y el nombre de sus representantes junto
  con la ciudad de la oficina a la que pertenece el representante.

8. Devuelve un listado con el nombre de los empleados junto con el nombre
  de sus jefes.

9. Devuelve un listado que muestre el nombre de cada empleados, el nombre
  de su jefe y el nombre del jefe de sus jefe.

10. Devuelve el nombre de los clientes a los que no se les ha entregado a
    tiempo un pedido.

11. Devuelve un listado de las diferentes gamas de producto que ha comprado
    cada cliente.

    ## Consultas multitabla (Composición externa)

    Resuelva todas las consultas utilizando las cláusulas LEFT JOIN, RIGHT JOIN, NATURAL
    LEFT JOIN y NATURAL RIGHT JOIN.

12. Devuelve un listado que muestre solamente los clientes que no han
   realizado ningún pago.

13. Devuelve un listado que muestre solamente los clientes que no han
   realizado ningún pedido.

14. Devuelve un listado que muestre los clientes que no han realizado ningún
   pago y los que no han realizado ningún pedido.

15. Devuelve un listado que muestre solamente los empleados que no tienen
   una oficina asociada.

16. Devuelve un listado que muestre solamente los empleados que no tienen un
   cliente asociado.

17. Devuelve un listado que muestre solamente los empleados que no tienen un
   cliente asociado junto con los datos de la oficina donde trabajan.

18. Devuelve un listado que muestre los empleados que no tienen una oficina
   asociada y los que no tienen un cliente asociado.

19. Devuelve un listado de los productos que nunca han aparecido en un
   pedido.

20. Devuelve un listado de los productos que nunca han aparecido en un
   pedido. El resultado debe mostrar el nombre, la descripción y la imagen del
   producto.

21. Devuelve las oficinas donde no trabajan ninguno de los empleados que
    hayan sido los representantes de ventas de algún cliente que haya realizado
    la compra de algún producto de la gama Frutales.

22. Devuelve un listado con los clientes que han realizado algún pedido pero no
    han realizado ningún pago.

23. Devuelve un listado con los datos de los empleados que no tienen clientes
    asociados y el nombre de su jefe asociado.

    ## Consultas resumen

24. ¿Cuántos empleados hay en la compañía?

25. ¿Cuántos clientes tiene cada país?

26. ¿Cuál fue el pago medio en 2009?

27. ¿Cuántos pedidos hay en cada estado? Ordena el resultado de forma
   descendente por el número de pedidos.

28. Calcula el precio de venta del producto más caro y más barato en una
   misma consulta.

29. Calcula el número de clientes que tiene la empresa.

30. ¿Cuántos clientes existen con domicilio en la ciudad de Madrid?

31. ¿Calcula cuántos clientes tiene cada una de las ciudades que empiezan
   por M?

32. Devuelve el nombre de los representantes de ventas y el número de clientes
   al que atiende cada uno.

33. Calcula el número de clientes que no tiene asignado representante de
    ventas.

34. Calcula la fecha del primer y último pago realizado por cada uno de los
    clientes. El listado deberá mostrar el nombre y los apellidos de cada cliente.

35. Calcula el número de productos diferentes que hay en cada uno de los
    pedidos.

36. Calcula la suma de la cantidad total de todos los productos que aparecen en
    cada uno de los pedidos.

37. Devuelve un listado de los 20 productos más vendidos y el número total de
    unidades que se han vendido de cada uno. El listado deberá estar ordenado
    por el número total de unidades vendidas.

38. La facturación que ha tenido la empresa en toda la historia, indicando la
    base imponible, el IVA y el total facturado. La base imponible se calcula
    sumando el coste del producto por el número de unidades vendidas de la
    tabla detalle_pedido. El IVA es el 21 % de la base imponible, y el total la
    suma de los dos campos anteriores.

39. La misma información que en la pregunta anterior, pero agrupada por
    código de producto.

40. La misma información que en la pregunta anterior, pero agrupada por
    código de producto filtrada por los códigos que empiecen por OR.

41. Lista las ventas totales de los productos que hayan facturado más de 3000
    euros. Se mostrará el nombre, unidades vendidas, total facturado y total
    facturado con impuestos (21% IVA).

42. Muestre la suma total de todos los pagos que se realizaron para cada uno
    de los años que aparecen en la tabla pagos.

    ## Subconsultas

    Con operadores básicos de comparación

43. Devuelve el nombre del cliente con mayor límite de crédito.

44. Devuelve el nombre del producto que tenga el precio de venta más caro.

45. Devuelve el nombre del producto del que se han vendido más unidades.
   (Tenga en cuenta que tendrá que calcular cuál es el número total de
   unidades que se han vendido de cada producto a partir de los datos de la
   tabla detalle_pedido)

46. Los clientes cuyo límite de crédito sea mayor que los pagos que haya
   realizado. (Sin utilizar INNER JOIN).

47. Devuelve el producto que más unidades tiene en stock.

48. Devuelve el producto que menos unidades tiene en stock.

49. Devuelve el nombre, los apellidos y el email de los empleados que están a
   cargo de Alberto Soria.

   ## Subconsultas con ALL y ANY

50. Devuelve el nombre del cliente con mayor límite de crédito.

51. Devuelve el nombre del producto que tenga el precio de venta más caro.

52. Devuelve el producto que menos unidades tiene en stock.

    ## Subconsultas con IN y NOT IN

53. Devuelve el nombre, apellido1 y cargo de los empleados que no
    representen a ningún cliente.

54. Devuelve un listado que muestre solamente los clientes que no han
    realizado ningún pago.

55. Devuelve un listado que muestre solamente los clientes que sí han realizado
    algún pago.

56. Devuelve un listado de los productos que nunca han aparecido en un
    pedido.

57. Devuelve el nombre, apellidos, puesto y teléfono de la oficina de aquellos
    empleados que no sean representante de ventas de ningún cliente.

58. Devuelve las oficinas donde no trabajan ninguno de los empleados que
    hayan sido los representantes de ventas de algún cliente que haya realizado
    la compra de algún producto de la gama Frutales.

59. Devuelve un listado con los clientes que han realizado algún pedido pero no
    han realizado ningún pago.

## Subconsultas con EXISTS y NOT EXISTS

18. Devuelve un listado que muestre solamente los clientes que no han
realizado ningún pago.
19. Devuelve un listado que muestre solamente los clientes que sí han realizado
algún pago.
20. Devuelve un listado de los productos que nunca han aparecido en un
pedido.
21. Devuelve un listado de los productos que han aparecido en un pedido
    alguna vez.

    ## Subconsultas correlacionadas

    Consultas variadas
1. Devuelve el listado de clientes indicando el nombre del cliente y cuántos
pedidos ha realizado. Tenga en cuenta que pueden existir clientes que no
han realizado ningún pedido.
2. Devuelve un listado con los nombres de los clientes y el total pagado por
cada uno de ellos. Tenga en cuenta que pueden existir clientes que no han
realizado ningún pago.
3. Devuelve el nombre de los clientes que hayan hecho pedidos en 2008
ordenados alfabéticamente de menor a mayor.
4. Devuelve el nombre del cliente, el nombre y primer apellido de su
representante de ventas y el número de teléfono de la oficina del
representante de ventas, de aquellos clientes que no hayan realizado ningún
pago.
5. Devuelve el listado de clientes donde aparezca el nombre del cliente, el
nombre y primer apellido de su representante de ventas y la ciudad donde
está su oficina.
6. Devuelve el nombre, apellidos, puesto y teléfono de la oficina de aquellos
empleados que no sean representante de ventas de ningún cliente.

7. Devuelve un listado indicando todas las ciudades donde hay oficinas y el
número de empleados que tiene.

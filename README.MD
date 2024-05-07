Consultas sobre una tabla

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


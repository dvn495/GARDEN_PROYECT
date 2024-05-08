INSERT INTO gama (id_gama, descripcion_texto, descripcion_html, imagen) VALUES
('G001', 'Descripción de gama 1', '<p>Descripción en HTML de gama 1</p>', 'imagen1.jpg'),
('G002', 'Descripción de gama 2', '<p>Descripción en HTML de gama 2</p>', 'imagen2.jpg'),
('G003', 'Ornamentales', '<p>Descripción en HTML de gama Ornamentales</p>', 'imagen3.jpg'),
('G004', 'Frutales', '<p>Descripción en HTML de gama Frutales</p>', 'imagen4.jpg');

INSERT INTO dimensiones (id_dimensiones, ancho, alto, largo) VALUES
(1, 5.25, 7.10, 15.80),
(2, 6.00, 8.25, 18.00);

INSERT INTO stock (id_stock, cantidad_producto) VALUES
(1,25),
(2,30),
(3,150),
(4, 50);

INSERT INTO proveedor (id_proveedor, nombre, apellido1, apellido2, telefono) VALUES
(1, 'Juan', 'Pérez', 'López', 987654321),
(2, 'Ana', 'García', 'Mendoza', 123456789);  
  
INSERT INTO producto (codigo_producto, nombre, gama_producto, dimensiones_producto, descripcion, id_proveedor_producto, cantidad_stock, precio_venta, precio_proveedor) VALUES
(1001, 'Producto 1', 'G001', 1, 'Descripción de producto 1', 1, 1, 99.99, 50.00),
(1002, 'Producto 2', 'G002', 2, 'Descripción de producto 2', 2, 2, 119.99, 55.00),
(1003, 'Producto 3', 'G003', 1, 'Descripción de producto 3', 1, 3, 129.99, 70.00),
(1004, 'Producto 4', 'G004', 2, 'Descripción de producto 4', 2, 4, 89.99, 40.00);
  
INSERT INTO tipo_tel (id_tipo_tel, nombre_tipo_tel) VALUES
(1, 'Teléfono fijo'),
(2, 'Teléfono móvil');

INSERT INTO telefono (id_telefono, id_tipo, numero, prefijo) VALUES
(1, 1, 111111111, '+34'),
(2, 2, 222222222, '+34');

INSERT INTO contacto (id_contacto, nombre_contacto, apellido1_contacto, apellido2_contacto, telefono_contacto) VALUES
(1, 'Pedro', 'González', 'Rodríguez', 1), 
(2, 'Laura', 'Martínez', 'Hernández', 2);

INSERT INTO fax (id_fax, codigo_fax) VALUES
(1, 'F001'),
(2, 'F002');

INSERT INTO calle (id_calle, calle) VALUES
(1, 'Calle Principal'),
(2, 'Calle Secundaria');

INSERT INTO barrio (id_barrio, barrio) VALUES
(1, 'Barrio Norte'),
(2, 'Barrio Sur');

INSERT INTO direccion (id_direccion, id_calle_direccion, id_barrio_direccion, vivienda) VALUES
(1, 1, 1, 'Casa 1'),
(2, 2, 2, 'Casa 2');

INSERT INTO ciudad (id_ciudad, ciudad) VALUES
(1, 'Ciudad A'),
(2, 'Ciudad B'),
(3, 'Madrid'),
(4, 'Fuenlabrada');

INSERT INTO region (id_region, region) VALUES
(1, 'Región 1'),
(2, 'Región 2');

INSERT INTO pais (id_pais, pais) VALUES
(1, 'País A'),
(2, 'País B'),
(3, 'España');

INSERT INTO codigo_postal (id_codigo_postal, codigo_postal, lugar_perteneciente) VALUES
(1, '12345', 'Lugar A'),
(2, '54321', 'Lugar B');

INSERT INTO cliente (id_cliente, nombre_cliente, apellido1_cliente, apellido2_cliente, id_contacto_cliente, telefono_cliente, id_fax_cliente, id_direccion1_cliente, id_direccion2_cliente, id_ciudad_cliente, id_region_cliente, id_pais_cliente, codigo_postal_cliente, codigo_empleado_rep_ventas, limite_credito) VALUES
(1, 'Cliente 1', 'Apellido1', 'Apellido2', 1, 1, 1, 1, NULL, 1, 1, 1, 1, NULL, 10000),
(2, 'Cliente 2', 'Apellido3', 'Apellido4', 2, 2, 2, 2, NULL, 3, 2, 2, 2, NULL, 15000),
(3, 'Cliente 3', 'Apellido5', 'Apellido6', NULL, 1, 1, 1, NULL, 3, 1, 3, NULL, NULL, NULL),
(4, 'Cliente 4', 'Apellido7', 'Apellido8', NULL, 2, 2, 2, NULL, 2, 2, 2, NULL, NULL, NULL);

INSERT INTO estado (id_estado, estado) VALUES
(1, 'En progreso'),
(2, 'Rechazado');

INSERT INTO pedido (codigo_pedido, fecha_pedido, fecha_esperada, fecha_entrega, estado_pedido, comentarios, codigo_cliente_pedido) VALUES
(1001, '2024-01-01', '2024-01-10','2024-01-07' , 1, 'Primer pedido', 1),
(1002, '2009-02-01', '2009-02-10', '2009-02-24', 2, 'Segundo pedido', 2),
(1003, '2024-03-01', '2024-03-10', '2024-03-09', 1, NULL, 3);

INSERT INTO detalle_pedido (codigo_pedido_detalle, codigo_producto_pedido, cantidad, precio_unidad, numero_linea) VALUES
(1001, 1001, 5, 99.99, 1),
(1002, 1002, 3, 119.99, 2),
(1003, 1003, 15, 129.99, 1);

INSERT INTO forma_pago (id_forma_pago, nombre_forma_pago, descripcion_forma_pago) VALUES
(1, 'Tarjeta de Crédito', 'Pago con tarjeta de crédito'),
(2, 'Transferencia Bancaria', 'Pago mediante transferencia bancaria'),
(3, 'Paypal', 'Pago mediante Paypal');

INSERT INTO transaccion (id_transaccion, cod_cliente, forma_pago_trasaccion, fecha_transaccion, total_transaccion) VALUES
('T001', 1, 3, '2008-01-05', 499.95),
('T002', 2, 2, '2008-02-15', 359.97),
('T003', 4, 3, '2009-03-05', 1949.85),
('T004', 4, 1, '2009-04-10', 649.95);

INSERT INTO oficina (codigo_oficina, id_ciudad_oficina, id_region_oficina, id_pais_oficina, id_codigo_postal_oficina, id_telefono_oficina, id_direccion_oficina1, id_direccion_oficina2) VALUES
('O001', 1, 1, 1, 1, 1, 1, NULL),
('O002', 2, 2, 2, 2, 2, 2, NULL),
('O003', 3, 2, 3, 1, 2, 1, NULL);

INSERT INTO empleado (id_empleado, nombre_empleado, apellido1_empleado, apellido2_empleado, extension, email_empleado, codigo_oficina_empleado, codigo_jefe, puesto) VALUES
(1, 'Empleado 1', 'Apellido Empleado 1', 'Apellido Empleado 2', '123', 'empleado1@example.com', 'O001', NULL, 'Vendedor'),
(2, 'Empleado 2', 'Apellido Empleado 3', 'Apellido Empleado 4', '456', 'empleado2@example.com', 'O002', NULL, 'Gerente'),
(3, 'Empleado 3', 'Apellido Empleado 5', 'Apellido Empleado 6', '789', 'empleado3@example.com', 'O003', 2, 'Representante de Ventas'),
(4, 'Empleado 4', 'Apellido Empleado 7', 'Apellido Empleado 8', '101', 'empleado4@example.com', NULL, 1, 'Gerente'),
(5, 'Empleado 5', 'Apellido Empleado 9', 'Apellido Empleado 10', '112', 'empleado5@example.com', 'O002', 2, 'Representante de Ventas');

UPDATE cliente SET codigo_empleado_rep_ventas = 3 WHERE id_cliente = 1;
UPDATE cliente SET codigo_empleado_rep_ventas = 5 WHERE id_cliente = 2;
UPDATE cliente SET codigo_empleado_rep_ventas = 3 WHERE id_cliente = 3;

CREATE TABLE gama(
  id_gama VARCHAR(50) PRIMARY KEY,
  descripcion_texto TEXT,
  descripcion_html TEXT,
  imagen VARCHAR(256)
  );

CREATE TABLE dimensiones(
  id_dimensiones INT(10) PRIMARY KEY,
  cod_producto_dimensiones INT(10),
  ancho DECIMAL (18,5) NOT NULL,
  alto DECIMAL (18,5) NOT NULL,
  largo DECIMAL (18,5)NOT NULL
  );
  

CREATE TABLE proveedor(
  id_proveedor INT(10) PRIMARY KEY,
  nombre VARCHAR(50) NOT NULL,
  apellido1 VARCHAR(50)NOT NULL,
  apellido2 VARCHAR(50),
  telefono INT(10)
  );

CREATE TABLE stock(
  id_stock INT(10) PRIMARY KEY,
  cantidad_producto INT(10) NOT NULL,
  id_producto_stock INT(10) 
  );
  
CREATE TABLE producto(
  codigo_producto INT(10) PRIMARY KEY,
  nombre VARCHAR(100) NOT NULL,
  gama_producto VARCHAR(50) NOT NULL,
  dimensiones_producto INT(10),
  descripcion text,
  id_proveedor_producto INT(10), 
  cantidad_stock INT(10) NOT NULL,
  precio_venta DECIMAL(15,2) NOT NULL,
  precio_proveedor DECIMAL(15,2),
	CONSTRAINT FK_gama FOREIGN KEY (gama_producto) REFERENCES gama(id_gama),
	CONSTRAINT FK_dimensiones FOREIGN KEY (dimensiones_producto) REFERENCES dimensiones(id_dimensiones),
	CONSTRAINT FK_proveedor FOREIGN KEY (id_proveedor_producto) REFERENCES proveedor(id_proveedor),
	CONSTRAINT FK_stock FOREIGN KEY (cantidad_stock) REFERENCES stock(id_stock)
  );
  
CREATE TABLE tipo_tel(
  id_tipo_tel INT(10) PRIMARY KEY,
  nombre_tipo_tel VARCHAR(50) NOT NULL,
  descripcion_tipo_tel TEXT
  );

CREATE TABLE telefono(
  id_telefono INT(10)PRIMARY KEY,
  id_cliente_telefono INT(10),
  id_tipo INT(10) NOT NULL,
  numero INT(10) NOT NULL,
  prefijo VARCHAR(5),
  CONSTRAINT FK_tipo_tel FOREIGN KEY (id_tipo) REFERENCES tipo_tel(id_tipo_tel)
  );
  
CREATE TABLE contacto(
  id_contacto INT(10) PRIMARY KEY,
  nombre_contacto VARCHAR(50) NOT NULL,
  apellido1_contacto VARCHAR(50) NOT NULL,
  apellido2_contacto VARCHAR(50),
  telefono_contacto INT(10) NOT NULL,
  CONSTRAINT FK_telefono_contacto FOREIGN KEY (telefono_contacto) REFERENCES telefono(id_telefono)
  );

CREATE TABLE fax(
  id_fax INT(10)PRIMARY KEY,
  codigo_fax VARCHAR(50) NOT NULL
  );
  
CREATE TABLE calle(
  id_calle INT(10) PRIMARY KEY,
  calle VARCHAR(100) NOT NULL
  );

CREATE TABLE barrio(
  id_barrio INT(10) PRIMARY KEY,
  barrio VARCHAR(100) NOT NULL
  );
  
CREATE TABLE direccion(
  id_direccion INT(10)PRIMARY KEY,
  id_calle_direccion INT(10) NOT NULL,
  id_barrio_direccion INT(10) NOT NULL,
  vivienda VARCHAR(50),
  CONSTRAINT FK_calle FOREIGN KEY (id_calle_direccion) REFERENCES calle(id_calle), 
  CONSTRAINT FK_barrio FOREIGN KEY (id_barrio_direccion) REFERENCES barrio(id_barrio)
  );

CREATE TABLE ciudad(
  id_ciudad INT(10) PRIMARY KEY,
  ciudad VARCHAR(100) NOT NULL
  );
  
CREATE TABLE region(
  id_region INT(10) PRIMARY KEY,
  region VARCHAR(100) NOT NULL
  );
  
CREATE TABLE pais(
  id_pais INT(10) PRIMARY KEY,
  pais VARCHAR(100) NOT NULL
  );
  
CREATE TABLE codigo_postal(
  id_codigo_postal INT(10) PRIMARY KEY,
  codigo_postal VARCHAR(50) NOT NULL,
  lugar_perteneciente VARCHAR(50)
  );

CREATE TABLE cliente(
  id_cliente INT(10) PRIMARY KEY,
  nombre_cliente VARCHAR(50) NOT NULL,
  apellido1_cliente VARCHAR(50) NOT NULL,
  apellido2_cliente VARCHAR(50),
  id_contacto_cliente INT(10),
  telefono_cliente INT(10) NOT NULL,
  id_fax_cliente INT(10) NOT NULL,
  id_direccion1_cliente INT(10) NOT NULL,
  id_direccion2_cliente INT(10),
  id_ciudad_cliente INT(10) NOT NULL,
  id_region_cliente INT(10) NOT NULL,
  id_pais_cliente INT(10) NOT NULL,
  codigo_postal_cliente INT(10),
  codigo_empleado_rep_ventas INT(10),
  limite_credito DECIMAL(15,2),
  CONSTRAINT FK_contacto FOREIGN KEY (id_contacto_cliente) REFERENCES contacto(id_contacto),
  CONSTRAINT FK_telefono_cliente FOREIGN KEY (telefono_cliente) REFERENCES telefono(id_telefono),
  CONSTRAINT FK_fax_cliente FOREIGN KEY (id_fax_cliente) REFERENCES fax(id_fax),
  CONSTRAINT FK_direccion1_cliente FOREIGN KEY (id_direccion1_cliente) REFERENCES direccion(id_direccion),
  CONSTRAINT FK_direccion2_cliente FOREIGN KEY (id_direccion2_cliente) REFERENCES direccion(id_direccion),
  CONSTRAINT FK_ciudad_cliente FOREIGN KEY (id_ciudad_cliente) REFERENCES ciudad(id_ciudad),
  CONSTRAINT FK_region_cliente FOREIGN KEY (id_region_cliente) REFERENCES region(id_region),
  CONSTRAINT FK_pais_cliente FOREIGN KEY (id_pais_cliente) REFERENCES pais(id_pais),
  CONSTRAINT FK_codigo_postal_cliente FOREIGN KEY (codigo_postal_cliente) REFERENCES codigo_postal(id_codigo_postal)
  );
  

CREATE TABLE estado(
  id_estado INT(10) PRIMARY KEY,
  estado VARCHAR(50) NOT NULL
  );

CREATE TABLE pedido(
  codigo_pedido INT(11) PRIMARY KEY,
  fecha_pedido DATE NOT NULL,
  fecha_esperada DATE NOT NULL,
  fecha_entrega DATE, 
  estado_pedido INT(10) NOT NULL,
  comentarios TEXT,
  codigo_cliente_pedido INT(10) NOT NULL,
  CONSTRAINT FK_estado FOREIGN KEY (estado_pedido) REFERENCES estado(id_estado),
  CONSTRAINT FK_cliente_pedido FOREIGN KEY (codigo_cliente_pedido) REFERENCES cliente(id_cliente)
  );
  
CREATE TABLE detalle_pedido(
  codigo_pedido_detalle INT(10) NOT NULL,
  codigo_producto_pedido INT(10) NOT NULL,
  cantidad INT(11) NOT NULL,
  precio_unidad DECIMAL(15,2) NOT NULL,
  numero_linea SMALLINT(6) NOT NULL,
  PRIMARY KEY (codigo_pedido_detalle, codigo_producto_pedido),
  CONSTRAINT FK_producto_pedido FOREIGN KEY (codigo_producto_pedido) REFERENCES producto(codigo_producto),
  CONSTRAINT FK_codigo_pedido FOREIGN KEY (codigo_pedido_detalle) REFERENCES pedido(codigo_pedido)
  );

CREATE TABLE forma_pago(
  id_forma_pago INT(10) PRIMARY KEY,
  nombre_forma_pago VARCHAR(50) NOT NULL,
  descripcion_forma_pago TEXT
  );
  
CREATE TABLE transaccion(
  id_transaccion VARCHAR(50),
  cod_cliente INT(10) NOT NULL,
  forma_pago_trasaccion INT(10) NOT NULL,
  fecha_transaccion DATE,
  total_transaccion DECIMAL (15,2),
  CONSTRAINT FK_forma_pago FOREIGN KEY (forma_pago_trasaccion) REFERENCES forma_pago(id_forma_pago)
  );

CREATE TABLE oficina(
  codigo_oficina VARCHAR(10) PRIMARY KEY,
  id_ciudad_oficina INT(10) NOT NULL,
  id_region_oficina INT(10) NOT NULL,
  id_pais_oficina INT(10),
  id_codigo_postal_oficina INT(10) NOT NULL,
  id_telefono_oficina INT(10) NOT NULL,
  id_direccion_oficina1 INT(10) NOT NULL,
  id_direccion_oficina2 INT(10),
  CONSTRAINT FK_telefono_oficina FOREIGN KEY (id_telefono_oficina) REFERENCES telefono(id_telefono),
  CONSTRAINT FK_direccion1_oficina FOREIGN KEY (id_direccion_oficina1) REFERENCES direccion(id_direccion),
  CONSTRAINT FK_direccion2_oficina FOREIGN KEY (id_direccion_oficina2) REFERENCES direccion(id_direccion),
  CONSTRAINT FK_ciudad_oficina FOREIGN KEY (id_ciudad_oficina) REFERENCES ciudad(id_ciudad),
  CONSTRAINT FK_region_oficina FOREIGN KEY (id_region_oficina) REFERENCES region(id_region),
  CONSTRAINT FK_pais_oficina FOREIGN KEY (id_pais_oficina) REFERENCES pais(id_pais),
  CONSTRAINT FK_codigo_postal_oficina FOREIGN KEY (id_codigo_postal_oficina) REFERENCES codigo_postal(id_codigo_postal)
  );
  
CREATE TABLE empleado(
  id_empleado INT(11) PRIMARY KEY,
  nombre_empleado VARCHAR(50) NOT NULL,
  apellido1_empleado VARCHAR(50) NOT NULL,
  apellido2_empleado VARCHAR(50),
  extension VARCHAR(10) NOT NULL,
  email_empleado VARCHAR(100) NOT NULL,
  codigo_oficina_empleado VARCHAR(10),
  codigo_jefe INT(11),
  puesto VARCHAR(50),
  CONSTRAINT FK_oficina_empleado FOREIGN KEY (codigo_oficina_empleado) REFERENCES oficina(codigo_oficina)
  );

ALTER TABLE cliente
ADD CONSTRAINT FK_representante_ventas FOREIGN KEY (codigo_empleado_rep_ventas) REFERENCES empleado(id_empleado);

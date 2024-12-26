# TABLA CLIENTE

CREATE TABLE clientes (
 id_cliente INT AUTO_INCREMENT PRIMARY KEY,
nombre_cliente VARCHAR(255) NOT NULL,
direccion_cliente VARCHAR(255),
telefono_cliente VARCHAR(50),
email_cliente VARCHAR(100)
);

# TABLA PARA REMITOS

CREATE TABLE remitos (
id_remito INT AUTO_INCREMENT PRIMARY KEY,
numero_remito VARCHAR(50) NOT NULL UNIQUE,
fecha_salida DATE NOT NULL,
id_cliente INT,
FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente)
);

# TABLA PARA FACTURAS

CREATE TABLE facturas (
id_factura INT AUTO_INCREMENT PRIMARY KEY,
numero_factura VARCHAR(50) NOT NULL UNIQUE,
numero_proforma VARCHAR(50) NOT NULL,
id_remito INT,
fecha_factura DATE NOT NULL,
FOREIGN KEY (id_remito) REFERENCES remitos(id_remito)
);

# TABLA PARA MERCADERIA

CREATE TABLE mercaderia (
id_mercaderia INT AUTO_INCREMENT PRIMARY KEY,
id_remito INT,
descripcion VARCHAR(255) NOT NULL,
lote_produccion VARCHAR(50) NOT NULL,
cantidad INT NOT NULL,
FOREIGN KEY (id_remito) REFERENCES remitos(id_remito)
);

# TABLA PARA LOTES DE PRODUCCION

CREATE TABLE lotes_produccion (
 id_lote INT AUTO_INCREMENT PRIMARY KEY,
lote_produccion VARCHAR(50) NOT NULL UNIQUE,
fecha_produccion DATE,
responsable VARCHAR(255)
);

# EJEMPLO DE CARGA DE DATOS 

-- Insertar un cliente
INSERT INTO clientes (nombre_cliente, direccion_cliente, telefono_cliente, email_cliente)
VALUES ('Juan Pérez', 'Calle Pamplona 123', '123456789', 'juan@correo.com');

-- Insertar un remito
INSERT INTO remitos (numero_remito, fecha_salida, id_cliente)
VALUES ('RMT-001', '2024-12-01', 1);

-- Insertar una factura
INSERT INTO facturas (numero_factura, numero_proforma, id_remito, fecha_factura)
VALUES ('FCT-001', 'PRF-001', 1, '2024-12-01');

-- Insertar mercancía
INSERT INTO mercaderia (id_remito, descripcion, lote_produccion, cantidad)
VALUES (1, 'Producto A', 'L0001', 100);

-- Insertar un lote de producción (opcional)
INSERT INTO lotes_produccion (lote_produccion, fecha_produccion, responsable)
VALUES ('L0001', '2024-11-25', 'Carlos Gómez');

# consulta para la trazabilidad

SELECT 
r.numero_remito,
f.numero_proforma,
f.numero_factura,
c.nombre_cliente,
r.fecha_salida,
m.descripcion,
m.lote_produccion
FROM 
remitos r
JOIN 
facturas f ON r.id_remito = f.id_remito
JOIN 
clientes c ON r.id_cliente = c.id_cliente
JOIN 
mercaderia m ON r.id_remito = m.id_remito
ORDER BY 
r.fecha_salida DESC;
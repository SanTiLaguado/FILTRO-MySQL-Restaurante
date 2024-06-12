CREATE DATABASE restaurante_gd;

USE restaurante_gd;

CREATE TABLE cliente (
	id INT AUTO_INCREMENT,
    nombre VARCHAR(100) NOT NULL,
    correo_electronico VARCHAR(100) NOT NULL,
	telefono VARCHAR(15) NOT NULL,
    fecha_registro DATE NOT NULL,
    CONSTRAINT PK_Cliente_Id PRIMARY KEY(id)
);

CREATE TABLE menu (
	id INT AUTO_INCREMENT,
    nombre VARCHAR(100) NOT NULL,
    descripcion TEXT NOT NULL,
    precio DECIMAL(10,2) NOT NULL,
    CONSTRAINT PK_Menu_Id PRIMARY KEY(id)
);

CREATE TABLE pedido (
	id INT AUTO_INCREMENT,
    id_cliente INT NOT NULL,
    fecha DATE NOT NULL,
    total DECIMAL(10,2) NOT NULL,
    CONSTRAINT PK_Pedido_Id PRIMARY KEY(id),
    CONSTRAINT FK_Cliente_Pedido_Id FOREIGN KEY (id_cliente) REFERENCES cliente(id)
);

CREATE TABLE detallepedido (
	id_pedido INT NOT NULL,
    id_menu INT NOT NULL,
    cantidad INT NOT NULL,
    precio_unitario DECIMAL(10,2) NOT NULL,
	CONSTRAINT FK_DetalleP_Pedido_Id FOREIGN KEY (id_pedido) REFERENCES pedido(id),
    CONSTRAINT FK_DetalleP_Menu_Id FOREIGN KEY (id_menu) REFERENCES menu(id)
);




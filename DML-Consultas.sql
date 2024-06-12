
USE restaurante_gd;


#1 Obtener la lista de todos los menús con sus precios

SELECT
	m.nombre AS nombre,
    m.precio AS precio
FROM
	menu m;
    
#2 Encontrar todos los pedidos realizados por el cliente 'Juan Perez'

SELECT
	p.id AS id,
    p.fecha AS fecha,
    p.total AS total
FROM
	pedido p
WHERE
	p.id_cliente = 1;
    
#3 Listar los detalles de todos los pedidos, incluyendo el nombre del menú,
#   cantidad y precio unitario

SELECT
	dp.id_pedido AS PedidoID,
    m.nombre AS Menu,
    dp.cantidad AS cantidad,
    dp.precio_unitario AS precio_unitario
FROM
	detallepedido dp
INNER JOIN
	menu m ON dp.id_menu = m.id;
	
#4 Calcular el total gastado por cada cliente en todos sus pedidos.

SELECT
	c.nombre AS nombre,
    SUM(p.total) AS TotalGastado
FROM
	cliente c
INNER JOIN
	pedido p ON c.id = p.id_cliente
GROUP BY
	c.id;
    
#5 Encontrar los menús con un precio mayor a $10

SELECT
	m.nombre AS nombre,
    m.precio AS precio
FROM
	menu m
WHERE
	m.precio > 10.00;
    
#6 Obtener el menú más caro pedido al menos una vez

SELECT
    m.nombre AS nombre,
    m.precio AS precio
FROM menu m
INNER JOIN
	detallepedido dp ON m.id = dp.id_menu
ORDER BY m.precio DESC
LIMIT 1;

#7 Listar los clientes que han realizado más de un pedido

SELECT DISTINCT
	c.nombre AS nombre,
    c.correo_electronico AS correo_electronico
FROM
	cliente c
INNER JOIN
	pedido p ON c.id = p.id_cliente
WHERE 1 < (
	SELECT
		COUNT(p.id_cliente) AS VECES
	FROM pedido p
	WHERE p.id_cliente = c.id);
                
#8 Obtener el cliente con el mayor gasto total


SELECT
    c.nombre
FROM
    cliente c
WHERE
    c.id = (
	SELECT p.id_cliente
	FROM pedido p
	GROUP BY p.id_cliente
	ORDER BY SUM(p.total) DESC
	LIMIT 1
);

#9 Mostrar el pedido más reciente de cada cliente

SELECT
	c.nombre AS nombre,
    p.fecha AS fecha,
    p.total AS total
FROM
	pedido p
INNER JOIN
	cliente c ON p.id_cliente = c.id
INNER JOIN (
	SELECT
		id_cliente,
        MAX(fecha) AS fechaMax
	FROM
		pedido
	GROUP BY
		id_cliente
) AS fecha_maxima ON p.id_cliente = fecha_maxima.id_cliente 
  AND p.fecha = fecha_maxima.fechaMax;
    
#10 Obtener el detalle de pedidos (menús y cantidades) 
#    para el cliente 'Juan Perez'.

SELECT
	p.id AS id,
    m.nombre AS nombre,
    dp.cantidad AS cantidad,
    dp.precio_unitario AS precio_unitario
FROM
	cliente c
INNER JOIN
	pedido p ON c.id = p.id_cliente
INNER JOIN
	detallepedido dp ON p.id = dp.id_pedido
INNER JOIN
	menu m ON dp.id_menu = m.id
WHERE c.id = 1;


##PROCEDIMIENTOS

#1

DELIMITER //
DROP PROCEDURE IF EXISTS AgregarCliente;
CREATE PROCEDURE AgregarCliente (
	IN nombre VARCHAR(100),
    IN correo_electronico VARCHAR(100),
    IN telefono VARCHAR(15),
    IN fecha_registro DATE
)
BEGIN
	INSERT INTO cliente (nombre, correo_electronico, telefono, fecha_registro) VALUES
	(nombre, correo_electronico, telefono, fecha_registro);
END//

DELIMITER ;
    
#2

DELIMITER //

DROP PROCEDURE IF EXISTS ObtenerDetallesPedido;
CREATE PROCEDURE ObtenerDetallesPedido (
	IN pedido_id INT
)
BEGIN
	SELECT
		dp.id_pedido AS IdPedido,
        m.nombre AS Menu,
        dp.cantidad AS Cantidad,
        dp.precio_unitario AS PrecioUnitario
	FROM
		detallepedido dp
	INNER JOIN
		menu m ON dp.id_menu = m.id
	WHERE dp.id_pedido = pedido_id;
END//

DELIMITER ;

#3

DELIMITER //

DROP PROCEDURE IF EXISTS ActualizarPrecioMenu;
CREATE PROCEDURE ActualizarPrecioMenu (
	IN menu_id INT,
    IN nuevoprecio DECIMAL(10,2)
)
BEGIN
	UPDATE menu
		SET precio = nuevoprecio
	WHERE id = menu_id;
END//

DELIMITER ;
  
#4

DELIMITER //

DROP PROCEDURE IF EXISTS EliminarCliente;
CREATE PROCEDURE EliminarCliente (
    IN cliente_id INT
)
BEGIN
    START TRANSACTION;
    
    DELETE dp FROM detallepedido dp
    INNER JOIN pedido p1 ON dp.id_pedido = p1.id
    WHERE p1.id_cliente = cliente_id;
    
    DELETE FROM pedido WHERE id_cliente = cliente_id;
    
    DELETE FROM cliente WHERE id = cliente_id;
    
    COMMIT;
END //

DELIMITER ;

#5

DELIMITER //

DROP PROCEDURE IF EXISTS TotalGastadoPorCliente;
CREATE PROCEDURE TotalGastadoPorCliente (
	IN cliente_id INT
)
BEGIN
	SELECT
		c.nombre AS nombre,
		SUM(p.total) AS TotalGastado
	FROM
		cliente c
	INNER JOIN
		pedido p ON c.id = p.id_cliente
	WHERE
		c.id = cliente_id
	GROUP BY
		c.id;
END//

DELIMITER ;

    













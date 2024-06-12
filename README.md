# FILTRO MySQL - RestauranteGD

**CONSULTAS**



1. Obtener la lista de todos los menús con sus precios.

   ```mysql
   mysql> SELECT
       -> m.nombre AS nombre,
       ->     m.precio AS precio
       -> FROM
       -> menu m;
   +----------------+--------+
   | nombre         | precio |
   +----------------+--------+
   | Ensalada Cesar |  12.50 |
   | Sopa de Tomate |   8.75 |
   | Filete de Res  |  25.00 |
   | Pasta Alfredo  |  15.00 |
   | Tarta de Queso |   7.50 |
   | Cafe Americano |   3.00 |
   +----------------+--------+
   ```

   

2. Encontrar todos los pedidos realizados por el cliente 'Juan Perez'.

  ```mysql
  mysql> SELECT
      -> p.id AS id,
      ->     p.fecha AS fecha,
      ->     p.total AS total
      -> FROM
      -> pedido p
      -> WHERE
      -> p.id_cliente = 1;
  +----+------------+-------+
  | id | fecha      | total |
  +----+------------+-------+
  |  1 | 2024-05-15 | 40.00 |
  |  2 | 2024-06-04 | 25.50 |
  +----+------------+-------+
  ```

  

3. Listar los detalles de todos los pedidos, incluyendo el nombre del menú, cantidad y precio unitario.

   ```mysql
   mysql> SELECT
       -> dp.id_pedido AS PedidoID,
       ->     m.nombre AS Menu,
       ->     dp.cantidad AS cantidad,
       ->     dp.precio_unitario AS precio_unitario
       -> FROM
       -> detallepedido dp
       -> INNER JOIN
       -> menu m ON dp.id_menu = m.id;
   +----------+----------------+----------+-----------------+
   | PedidoID | Menu           | cantidad | precio_unitario |
   +----------+----------------+----------+-----------------+
   |        1 | Ensalada Cesar |        1 |           12.50 |
   |        3 | Ensalada Cesar |        1 |           12.50 |
   |        5 | Ensalada Cesar |        2 |           12.50 |
   |        7 | Ensalada Cesar |        2 |           12.50 |
   |       10 | Ensalada Cesar |        1 |           12.50 |
   |       13 | Ensalada Cesar |        2 |           12.50 |
   |       16 | Ensalada Cesar |        1 |           12.50 |
   |        2 | Sopa de Tomate |        1 |            8.75 |
   |        6 | Sopa de Tomate |        1 |            8.75 |
   |        8 | Sopa de Tomate |        1 |            8.75 |
   |       12 | Sopa de Tomate |        1 |            8.75 |
   |       14 | Sopa de Tomate |        1 |            8.75 |
   |       18 | Sopa de Tomate |        1 |            8.75 |
   |        1 | Filete de Res  |        1 |           25.00 |
   |        4 | Filete de Res  |        1 |           25.00 |
   |        9 | Filete de Res  |        1 |           25.00 |
   |       10 | Filete de Res  |        1 |           25.00 |
   |       15 | Filete de Res  |        1 |           25.00 |
   |       16 | Filete de Res  |        1 |           25.00 |
   |        2 | Pasta Alfredo  |        1 |           15.00 |
   |        3 | Pasta Alfredo  |        1 |           15.00 |
   |        7 | Pasta Alfredo  |        1 |           15.00 |
   |       11 | Pasta Alfredo  |        1 |           15.00 |
   |       12 | Pasta Alfredo  |        1 |           15.00 |
   |       13 | Pasta Alfredo  |        1 |           15.00 |
   |       17 | Pasta Alfredo  |        1 |           15.00 |
   |       18 | Pasta Alfredo  |        1 |           15.00 |
   |        2 | Tarta de Queso |        1 |            7.50 |
   |        5 | Tarta de Queso |        2 |            7.50 |
   |        8 | Tarta de Queso |        2 |            7.50 |
   |       11 | Tarta de Queso |        1 |            7.50 |
   |       12 | Tarta de Queso |        1 |            7.50 |
   |       14 | Tarta de Queso |        2 |            7.50 |
   |       17 | Tarta de Queso |        1 |            7.50 |
   |       18 | Tarta de Queso |        1 |            7.50 |
   |        1 | Cafe Americano |        3 |            3.00 |
   |        3 | Cafe Americano |        2 |            3.00 |
   |        4 | Cafe Americano |        1 |            3.00 |
   |        6 | Cafe Americano |        3 |            3.00 |
   |        9 | Cafe Americano |        3 |            3.00 |
   |       11 | Cafe Americano |        2 |            3.00 |
   |       15 | Cafe Americano |        3 |            3.00 |
   |       17 | Cafe Americano |        2 |            3.00 |
   +----------+----------------+----------+-----------------+
   ```

   

4. Calcular el total gastado por cada cliente en todos sus pedidos.

   ```mysql
   mysql> SELECT
       -> c.nombre AS nombre,
       ->     SUM(p.total) AS TotalGastado
       -> FROM
       -> cliente c
       -> INNER JOIN
       -> pedido p ON c.id = p.id_cliente
       -> GROUP BY
       -> c.id;
   +------------------+--------------+
   | nombre           | TotalGastado |
   +------------------+--------------+
   | Juan Perez       |        65.50 |
   | Maria Lopez      |        83.75 |
   | Carlos Mendoza   |        55.00 |
   | Ana Gonzalez     |        61.00 |
   | Luis Torres      |        45.00 |
   | Laura Rivera     |        56.25 |
   | Fernando Garcia  |        97.50 |
   | Isabel Fernandez |        84.25 |
   | Ricardo Morales  |        41.00 |
   | Lucia Martinez   |        55.75 |
   | Santiago Jimenez |        52.00 |
   | Patricia Romero  |        46.25 |
   +------------------+--------------+
   ```

   

5. Encontrar los menús con un precio mayor a $10.

   ```mysql
   mysql> SELECT
       -> m.nombre AS nombre,
       ->     m.precio AS precio
       -> FROM
       -> menu m
       -> WHERE
       -> m.precio > 10.00;
   +----------------+--------+
   | nombre         | precio |
   +----------------+--------+
   | Ensalada Cesar |  12.50 |
   | Filete de Res  |  25.00 |
   | Pasta Alfredo  |  15.00 |
   +----------------+--------+
   
   ```

   

6. Obtener el menú más caro pedido al menos una vez.

   ```mysql
   mysql> SELECT
       ->     m.nombre AS nombre,
       ->     m.precio AS precio
       -> FROM menu m
       -> INNER JOIN
       -> detallepedido dp ON m.id = dp.id_menu
       -> ORDER BY m.precio DESC
       -> LIMIT 1;
   +---------------+--------+
   | nombre        | precio |
   +---------------+--------+
   | Filete de Res |  25.00 |
   +---------------+--------+
   ```

   

7. Listar los clientes que han realizado más de un pedido.

   ```mysql
   mysql> SELECT DISTINCT
       -> c.nombre AS nombre,
       ->     c.correo_electronico AS correo_electronico
       -> FROM
       -> cliente c
       -> INNER JOIN
       -> pedido p ON c.id = p.id_cliente
       -> WHERE 1 < (
       -> SELECT
       -> COUNT(p.id_cliente) AS VECES
       -> FROM pedido p
       -> WHERE p.id_cliente = c.id);
   +------------------+------------------------------+
   | nombre           | correo_electronico           |
   +------------------+------------------------------+
   | Juan Perez       | juan.perez@example.com       |
   | Maria Lopez      | maria.lopez@example.com      |
   | Ana Gonzalez     | ana.gonzalez@example.com     |
   | Laura Rivera     | laura.rivera@example.com     |
   | Fernando Garcia  | fernando.garcia@example.com  |
   | Isabel Fernandez | isabel.fernandez@example.com |
   +------------------+------------------------------+
   
   ```

   

8. Obtener el cliente con el mayor gasto total.

   ```mysql
   mysql> SELECT
       ->     c.nombre
       -> FROM
       ->     cliente c
       -> WHERE
       ->     c.id = (
       -> SELECT p.id_cliente
       -> FROM pedido p
       -> GROUP BY p.id_cliente
       -> ORDER BY SUM(p.total) DESC
       -> LIMIT 1
       -> );
   +-----------------+
   | nombre          |
   +-----------------+
   | Fernando Garcia |
   +-----------------+
   ```

   

9. Mostrar el pedido más reciente de cada cliente.

   ```mysql
   mysql> SELECT
       -> c.nombre AS nombre,
       ->     p.fecha AS fecha,
       ->     p.total AS total
       -> FROM
       -> pedido p
       -> INNER JOIN
       -> cliente c ON p.id_cliente = c.id
       -> INNER JOIN (
       -> SELECT
       ->     id_cliente,
       ->     MAX(fecha) AS fechaMax
       -> FROM
       -> pedido
       -> GROUP BY
       -> id_cliente) AS fecha_maxima ON p.id_cliente = fecha_maxima.id_cliente 
       -> AND p.fecha = fecha_maxima.fechaMax;
   +------------------+------------+-------+
   | nombre           | fecha      | total |
   +------------------+------------+-------+
   | Juan Perez       | 2024-06-04 | 25.50 |
   | Maria Lopez      | 2024-06-05 | 48.00 |
   | Carlos Mendoza   | 2024-06-10 | 55.00 |
   | Ana Gonzalez     | 2024-06-15 | 28.25 |
   | Luis Torres      | 2024-06-20 | 45.00 |
   | Laura Rivera     | 2024-06-10 | 33.75 |
   | Fernando Garcia  | 2024-06-25 | 47.00 |
   | Isabel Fernandez | 2024-06-30 | 39.50 |
   | Ricardo Morales  | 2024-05-25 | 41.00 |
   | Lucia Martinez   | 2024-06-04 | 55.75 |
   | Santiago Jimenez | 2024-06-09 | 52.00 |
   | Patricia Romero  | 2024-06-15 | 46.25 |
   +------------------+------------+-------+
   ```

   

10. Obtener el detalle de pedidos (menús y cantidades) para el cliente 'Juan Perez'.

    ```mysql
    mysql> SELECT
        -> p.id AS id,
        ->     m.nombre AS nombre,
        ->     dp.cantidad AS cantidad,
        ->     dp.precio_unitario AS precio_unitario
        -> FROM
        -> cliente c
        -> INNER JOIN
        -> pedido p ON c.id = p.id_cliente
        -> INNER JOIN
        -> detallepedido dp ON p.id = dp.id_pedido
        -> INNER JOIN
        -> menu m ON dp.id_menu = m.id
        -> WHERE c.id = 1;
    +----+----------------+----------+-----------------+
    | id | nombre         | cantidad | precio_unitario |
    +----+----------------+----------+-----------------+
    |  1 | Ensalada Cesar |        1 |           12.50 |
    |  1 | Filete de Res  |        1 |           25.00 |
    |  1 | Cafe Americano |        3 |            3.00 |
    |  2 | Sopa de Tomate |        1 |            8.75 |
    |  2 | Pasta Alfredo  |        1 |           15.00 |
    |  2 | Tarta de Queso |        1 |            7.50 |
    +----+----------------+----------+-----------------+
    ```



**PROCEDIMIENTOS ALMACENADOS**

1. Crea un procedimiento almacenado llamado AgregarCliente que reciba como
   parámetros el nombre, correo electrónico, teléfono y fecha de registro de un nuevo cliente y lo
   inserte en la tabla Clientes .

   ```mysql
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
   ```

2. Crea un procedimiento almacenado llamado ObtenerDetallesPedido que reciba
   como parámetro el ID del pedido y devuelva los detalles del pedido, incluyendo el nombre del
   menú, cantidad y precio unitario.

   ```mysql
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
   
   mysql> CALL ObtenerDetallesPedido(1);
   +----------+----------------+----------+----------------+
   | IdPedido | Menu           | Cantidad | PrecioUnitario |
   +----------+----------------+----------+----------------+
   |        1 | Ensalada Cesar |        1 |          12.50 |
   |        1 | Filete de Res  |        1 |          25.00 |
   |        1 | Cafe Americano |        3 |           3.00 |
   +----------+----------------+----------+----------------+
   ```

3. Crea un procedimiento almacenado llamado ActualizarPrecioMenu que reciba
   como parámetros el ID del menú y el nuevo precio, y actualice el precio del menú en la tabla
   Menus.

   ```mysql
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
   ```

4. Crea un procedimiento almacenado llamado EliminarCliente que reciba como
   parámetro el ID del cliente y elimine el cliente junto con todos sus pedidos y los detalles de los
   pedidos.

   ```mysql
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
   ```

5. Crea un procedimiento almacenado llamado TotalGastadoPorCliente que reciba como parámetro el ID del cliente y devuelva el total gastado por ese cliente en todos sus pedidos.

   ```mysql
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
   ```

   


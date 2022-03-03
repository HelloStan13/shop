/*Script 2 Mysql*/
/*Consulta SQL donde pueda obtener los productos vendidos digitando tipo de documento y número de documento.*/

select dato.name as tipoDocumento, cliente.number_doc as numeroDocumento, productofactura.sku as skuProducto,producto.name as nombreProducto
from invoice as factura 
inner join product_invoice as productofactura on productofactura.fk_invoice_id = factura.id_invoice
inner join client as cliente on cliente.id_client = factura.fk_client_id
inner join config_data as dato on dato.id_data=cliente.fk_config_typedoc
inner join product as producto on producto.id_product =productofactura.fk_product_id
where cliente.number_doc='1056056056' and dato.name='Cedula de ciudadania';

/*Consultar productos por medio del nombre, el cual debe mostrar quien o quienes han sido sus proveedores.*/
/* 1 */
select producto.id_product,producto.name as nombreProducto, proveedor.name as nombreProveedor 
from product as producto
inner join supplier as proveedor on proveedor.id_supplier = producto.fk_supplier_id
where producto.name like'%Monitor 20%';

/* 2 */

select producto.id_product,producto.name as nombreProducto, proveedor.name as nombreProveedor 
from product as producto
inner join supplier as proveedor on proveedor.id_supplier = producto.fk_supplier_id
where producto.name like'%monitor%';

/* Crear una consulta que me permita ver qué producto ha sido el más vendido y en qué cantidades de mayor a menor.*/
SELECT producto.name as nombreProducto, producto.sku, COUNT(c.amount) as cantidad 
FROM product as producto
INNER JOIN product_invoice  c ON c.fk_product_id = producto.id_product
GROUP BY producto.sku,producto.name
ORDER BY  cantidad DESC


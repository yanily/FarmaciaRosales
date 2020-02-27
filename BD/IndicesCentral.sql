USE [CENTRAL]
GO

create index idx_preciosInventario on CENTRAL.dbo.INVENTARIO(precioVenta, precioCompra);
create index idx_direccionProveedores on CENTRAL.dbo.PROVEEDORES(direccion);
create index idx_direccionEmpleado on CENTRAL.dbo.EMPLEADOS(direccion, rol);
create index idx_fechaFactura on CENTRAL.dbo.FACTURAS(fecha);
create index idx_rolUsuario on CENTRAL.dbo.USUARIOS(rol);
GO
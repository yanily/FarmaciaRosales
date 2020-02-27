USE [SUCURSAL2]
GO

create index idx_direccionEmpleado on SUCURSAL2.dbo.EMPLEADOS(direccion, rol);
create index idx_fechaFactura on SUCURSAL2.dbo.FACTURAS(fecha);
create index idx_preciosInventario on SUCURSAL2.dbo.INVENTARIO(precioVenta, precioCompra);
create index idx_direccionProveedores on SUCURSAL2.dbo.PROVEEDORES(direccion);
create index idx_rolUsuario on SUCURSAL2.dbo.USUARIOS(rol);
GO
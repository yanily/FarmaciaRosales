USE [SUCURSAL1]
GO

create index idx_direccionEmpleado on SUCURSAL1.dbo.EMPLEADOS(direccion, rol);
create index idx_fechaFactura on SUCURSAL1.dbo.FACTURAS(fecha);
create index idx_preciosInventario on SUCURSAL1.dbo.INVENTARIO(precioVenta, precioCompra);
create index idx_direccionProveedores on SUCURSAL1.dbo.PROVEEDORES(direccion);
create index idx_rolUsuario on SUCURSAL1.dbo.USUARIOS(rol);
GO
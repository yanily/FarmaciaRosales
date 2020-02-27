USE [SUCURSAL2]
GO

/*
	Para poder realizar la sincronización, es necesario tener tablas temporales donde se va a tener la información nueva a sincronizar, ya sea una inserción,
	actualización o eliminación.
	Donde:
		- A: Actualizado.
		- D: Eliminado.
		- I: Ingresado.
*/


/*
	Los datos de estas tablas temporales deben poseer los datos de operaciones DML, para ello es necesario llenarlas con triggers.
	Para ver los triggers realizados para la inserción de datos en las tablas temporales, diríjase a los triggers.
*/

/*
	El procedimiento para realizar la sincronización es el siguiente; el cual se encargará de pasar los nuevos datos o modificaciones de estos datos a la base de datos
	central.
*/

CREATE OR ALTER PROCEDURE [dbo].[Sync_Data]
AS

BEGIN
	declare cur_empleados cursor for
		select * from SUCURSAL2.dbo.EMP_ING_ACT_ELI;

	declare cur_empleadosTelefono cursor for
		select * from SUCURSAL2.dbo.EMP_TEL_ING_ACT_ELI;

	declare cur_empleadosCorreos cursor for
		select * from SUCURSAL2.dbo.EMP_CORREO_ING_ACT_ELI;

	declare cur_facturas cursor for
		select * from SUCURSAL2.dbo.FACT_ING_ACT_ELI;

	declare cur_factDetalles cursor for
		select * from SUCURSAL2.dbo.DET_FACT_ING_ACT_ELI;

	declare @idEmpleado int,
			@nombre varchar(50),
			@direccion varchar(100),
			@salario decimal(10,2),
			@rol varchar(10),
			@idFarmacia int,
			@tipo char(1);

	declare @telefono varchar(20),
			@correo varchar(50);

	declare @idFactura int,
			@fecha datetime,
			@montoTotal decimal(10,2),
			@tipoPago int;

	declare @idProducto int,
			@costo decimal(10,2),
			@cantidad int,
			@subtotal decimal(10,2),
			@descuento int,
			@IVA int,
			@IV int;

	open cur_empleados;
	fetch next from cur_empleados into @idEmpleado, @tipo;

	while @@fetch_status = 0
	begin
		if @tipo = 'I'
		begin
			select @nombre = nombre, @direccion = direccion, @salario = salario, @rol = rol, @idFarmacia = idFarmacia from SUCURSAL2.dbo.EMPLEADOS
					where idEmpleado = @idEmpleado;
			insert into ROBERT.CENTRAL.dbo.EMPLEADOS values (@idEmpleado, @nombre, @direccion, @salario, @rol, @idFarmacia);
		end

		else if @tipo = 'A'
		begin
			select @nombre = nombre, @direccion = direccion, @salario = salario, @rol = rol, @idFarmacia = idFarmacia from SUCURSAL2.dbo.EMPLEADOS
				where idEmpleado = @idEmpleado;

			if not exists(select idEmpleado from ROBERT.CENTRAL.dbo.EMPLEADOS where idEmpleado = @idEmpleado and idFarmacia = @idFarmacia)
			begin
				insert into ROBERT.CENTRAL.dbo.EMPLEADOS values (@idEmpleado, @nombre, @direccion, @salario, @rol, @idFarmacia);
			end

			else
			begin
				update ROBERT.CENTRAL.dbo.EMPLEADOS set nombre = @nombre, direccion = @direccion, salario = @salario, rol = @rol where idEmpleado = @idEmpleado and
					idFarmacia = @idFarmacia;
			end
		end

		else
		begin
			select @idFarmacia = idFarmacia from SUCURSAL2.dbo.EMPLEADOS where idEmpleado = @idEmpleado;
			delete from ROBERT.CENTRAL.dbo.EMPLEADOS where idEmpleado = @idEmpleado and idFarmacia = @idFarmacia;
		end

		fetch next from cur_empleados into @idEmpleado, @tipo;
	end

	close cur_empleados;
	deallocate cur_empleados;

	open cur_empleadosTelefono;
	fetch next from cur_empleadosTelefono into @idEmpleado, @telefono, @tipo;

	while @@fetch_status = 0
	begin
		select @idFarmacia = idFarmacia from SUCURSAL2.dbo.EMPLEADOS_TELEFONOS where idEmpleado = @idEmpleado and telefono = @telefono;
		if @tipo = 'I'
		begin
			insert into ROBERT.CENTRAL.dbo.EMPLEADOS_TELEFONOS values (@idEmpleado, @telefono, @idFarmacia);
		end

		else
		begin
			delete from ROBERT.CENTRAL.dbo.EMPLEADOS_TELEFONOS where idEmpleado = @idEmpleado and telefono = @telefono and idFarmacia = @idFarmacia;
		end
		
		fetch next from cur_empleadosTelefono into @idEmpleado, @telefono, @tipo;
	end

	close cur_empleadosTelefono;
	deallocate cur_empleadosTelefono;

	open cur_empleadosCorreos;
	fetch next from cur_empleadosCorreos into @idEmpleado, @correo, @tipo;

	while @@fetch_status = 0
	begin
		select @idFactura = idFarmacia from SUCURSAL2.dbo.EMPLEADOS_CORREOS where idEmpleado = @idEmpleado and correo = @correo;
		if @tipo = 'I'
		begin
			insert into ROBERT.CENTRAL.dbo.EMPLEADOS_CORREOS values (@idEmpleado, @correo, @idFarmacia);
		end

		else
		begin
			delete from ROBERT.CENTRAL.dbo.EMPLEADOS_CORREOS where idEmpleado = @idEmpleado and correo = @correo and idFarmacia = @idFarmacia;
		end

		fetch next from cur_empleadosCorreos into @idEmpleado, @correo, @tipo;
	end

	close cur_empleadosCorreos;
	deallocate cur_empleadosCorreos;

	open cur_facturas;
	fetch next from cur_facturas into @idFactura, @tipo;

	while @@fetch_status = 0
	begin
		if @tipo = 'I'
		begin
			select @fecha = fecha, @montoTotal = montoTotal, @idEmpleado = idEmpleado, @idFarmacia = idFarmacia, @tipoPago = tipoPago, 
			@descuento = descuento, @IVA = IVA, @IV = IV , @correo = correo from SUCURSAL2.dbo.FACTURAS where idFactura = @idFactura;
			insert into ROBERT.CENTRAL.dbo.FACTURAS values (@idFactura, @fecha, @montoTotal, @idEmpleado, @idFarmacia, @tipoPago, @correo, @descuento, @IVA, @IV);
		end
		
		else if @tipo = 'A'
		begin
			select @fecha = fecha, @montoTotal = montoTotal, @idEmpleado = idEmpleado, @idFarmacia = idFarmacia, @tipoPago = tipoPago, 
			@descuento = descuento, @IVA = IVA, @IV = IV from SUCURSAL2.dbo.FACTURAS where idFactura = @idFactura;

			if not exists(select idFactura from ROBERT.CENTRAL.dbo.FACTURAS where idFactura = @idFactura and idFarmacia = @idFarmacia)
			begin
				insert into ROBERT.CENTRAL.dbo.FACTURAS values (@idFactura, @fecha, @montoTotal, @idEmpleado, @idFarmacia, @tipoPago, @correo, @descuento, @IVA, @IV);
			end

			else
			begin
				update ROBERT.CENTRAL.dbo.FACTURAS set fecha = @fecha, montoTotal = @montoTotal, idEmpleado = @idEmpleado,  tipoPago = @tipoPago,
				descuento = @descuento, IVA = @IVA, IV = @IV, correo = @correo where idFactura = @idFactura and idFarmacia = @idFarmacia;
			end
		end

		else
		begin
			select @idFarmacia = idFarmacia from SUCURSAL2.dbo.FACTURAS where idFactura = @idFactura;
			delete from ROBERT.CENTRAL.dbo.FACTURAS where idFactura = @idFactura and idFarmacia = @idFarmacia;
		end

		fetch next from cur_facturas into @idFactura, @tipo;
	end

	close cur_facturas;
	deallocate cur_facturas;

	open cur_factDetalles;
	fetch next from cur_factDetalles into @idFactura, @idProducto, @tipo;

	while @@fetch_status = 0
	begin
		if @tipo = 'I'
		begin
			select @costo = costo, @cantidad = cantidad, @subtotal = subtotal, @idFarmacia = idFarmacia from SUCURSAL2.dbo.DETALLEFACTURA
			where idFactura = @idFactura and idProducto = @idProducto;
			insert into ROBERT.CENTRAL.dbo.DETALLEFACTURA values (@idFactura, @idProducto, @costo, @cantidad, @subtotal, @idFarmacia);
		end
		
		else if @tipo = 'A'
		begin
			select @cantidad = cantidad, @subtotal = subtotal, @idFarmacia = idFarmacia from SUCURSAL2.dbo.DETALLEFACTURA
			where idFactura = @idFactura and idProducto = @idProducto;

			if not exists (select cantidad from SUCURSAL2.dbo.DETALLEFACTURA where idFactura = @idFactura and idProducto = @idProducto 
				and idFarmacia = @idFarmacia)
			begin
				insert into ROBERT.CENTRAL.dbo.DETALLEFACTURA values (@idFactura, @idProducto, @costo, @cantidad, @subtotal, @idFarmacia);
			end

			else
			begin
				update ROBERT.CENTRAL.dbo.DETALLEFACTURA set cantidad = @cantidad, subtotal = @subtotal where idFactura = @idFactura and idProducto = @idProducto 
					and idFarmacia = @idFarmacia;
			end
		end

		else
		begin
			select @idFarmacia = idFarmacia from SUCURSAL2.dbo.DETALLEFACTURA where idFactura = @idFactura and idProducto = @idProducto;
			delete from ROBERT.CENTRAL.dbo.DETALLEFACTURA where idFactura = @idFactura and idFarmacia = @idFarmacia and idProducto = @idProducto;
		end

		fetch next from cur_factDetalles into @idFactura, @idProducto, @tipo;
	end

	close cur_factDetalles;
	deallocate cur_factDetalles;

	delete from EMP_ING_ACT_ELI;
	delete from EMP_CORREO_ING_ACT_ELI;
	delete from EMP_TEL_ING_ACT_ELI;
	delete from FACT_ING_ACT_ELI;
	delete from DET_FACT_ING_ACT_ELI;

END
GO

exec Sync_Data
GO
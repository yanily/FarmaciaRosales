using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data.SqlClient;
using DataEntity;
using System.Diagnostics;
using System.Data;


namespace DataAccess
{
    public class ConnectionData
    {
        SqlConnection connection = new SqlConnection("Data Source=DESKTOP-PG46I4S;Initial Catalog=CENTRAL;Integrated Security=True");

        //actualizar prodcutos
        public void ActualizarProducto(Inventario inventario)
        {
            string query = "update Inventario set precioCompra = " + inventario.precioCompra + ", precioVenta = " +
                inventario.precioVenta + ", medida = '" + inventario.medida
                + "', descripcion= '" + inventario.descripcion + "', existencias = " + inventario.existencias +
                " where idProducto = " + inventario.idProducto;
            Debug.WriteLine(query);
            try
            {
                connection.Open();
                SqlCommand command = new SqlCommand(query, connection);
                command.ExecuteNonQuery();
                connection.Close();
            }
            catch (SqlException ex)
            {
                Debug.WriteLine(ex.ToString());
                throw;
            }
        }
        public DataSet GetInventarioID(int idProducto)
        {
            try
            {
                connection.Open();
                SqlCommand command = new SqlCommand("select nombre,precioVenta,precioCompra,descripcion,medida,existencias from Inventario where idProducto = " + idProducto,
                    connection);
                SqlDataAdapter sqlDataAdapter = new SqlDataAdapter(command);
                DataSet data = new DataSet();
                sqlDataAdapter.Fill(data);
                connection.Close();
                return data;
            }
            catch (SqlException ex)
            {
                Debug.WriteLine(ex.ToString());
                throw;
            }
        }
        //fin

        public DataSet GetProveedores()
        {
            try
            {
                connection.Open();
                SqlCommand command = new SqlCommand("select * from PROVEEDORES", connection);
                SqlDataAdapter sqlDataAdapter = new SqlDataAdapter(command);
                DataSet data = new DataSet();
                sqlDataAdapter.Fill(data);
                connection.Close();
                return data;
            }
            catch (SqlException ex)
            {
                Debug.WriteLine(ex.ToString());
                throw;
            }
        }
        public DataSet VerifyLogin(string username, string password)
        {
            try
            {
                connection.Open();
                SqlCommand command = new SqlCommand("select rol from Usuarios where usuario = '" + username
                    + "' and contrasena = '" + password + "'", connection);
                SqlDataAdapter dataAdapter = new SqlDataAdapter(command);
                DataSet data = new DataSet();
                dataAdapter.Fill(data);
                connection.Close();

                return data;
            }
            catch (SqlException ex)
            {
                connection.Close();
                Debug.WriteLine(ex.ToString());
                return null;
            }
        }
        public void agregarEmpleado(Empleados empleados, string correo, string telefono)
        {
            try
            {
                connection.Open();
                SqlCommand sqlCommand = new SqlCommand("AddEmpleado", connection)
                {
                    CommandType = CommandType.StoredProcedure
                };

                sqlCommand.Parameters.Add(new SqlParameter("@idEmpleado", empleados.idEmpleado));
                sqlCommand.Parameters.Add(new SqlParameter("@nombre", empleados.nombre));
                sqlCommand.Parameters.Add(new SqlParameter("@direccion", empleados.direccion));
                sqlCommand.Parameters.Add(new SqlParameter("@salario", empleados.salario));
                sqlCommand.Parameters.Add(new SqlParameter("@rol", empleados.rol));
                sqlCommand.Parameters.Add(new SqlParameter("@idFarmacia", empleados.idFarmacia));
                sqlCommand.Parameters.Add(new SqlParameter("@correo", correo));
                sqlCommand.Parameters.Add(new SqlParameter("@telefono", telefono));

                sqlCommand.ExecuteNonQuery();

                connection.Close();
            }
            catch (SqlException ex)
            {
                Debug.WriteLine(ex.ToString());
                connection.Close();
            }
        }
        
        public DataSet GetCategoria()
        {
            try
            {
                connection.Open();
                SqlCommand command = new SqlCommand("select * from CATEGORIAS", connection);
                SqlDataAdapter sqlDataAdapter = new SqlDataAdapter(command);
                DataSet data = new DataSet();
                sqlDataAdapter.Fill(data);
                connection.Close();
                return data;
            }
            catch (SqlException ex)
            {
                Debug.WriteLine(ex.ToString());
                throw;
            }
        }

        public  int GetNewID(string tabla, string idName)
        {
            try
            {
                connection.Open();
                SqlCommand command = new SqlCommand("select top 1 " + idName + " from " + tabla + " order by " + idName +
                    " desc", connection);
                SqlDataAdapter sqlDataAdapter = new SqlDataAdapter(command);
                DataSet data = new DataSet();
                sqlDataAdapter.Fill(data);
                connection.Close();

                if (data.Tables[0].Rows.Count == 0)
                    return 1;
                else
                    return Convert.ToInt32(data.Tables[0].Rows[0][0]) + 1;
            }
            catch (SqlException ex)
            {
                Debug.WriteLine(ex.ToString());
                throw;
            }
        }



        public DataSet GetInventario()
        {
            try
            {
                connection.Open();
                SqlCommand command = new SqlCommand("select * from Inventario", connection);
                SqlDataAdapter sqlDataAdapter = new SqlDataAdapter(command);
                DataSet data = new DataSet();
                sqlDataAdapter.Fill(data);
                connection.Close();
                return data;
            }
            catch (SqlException ex)
            {
                Debug.WriteLine(ex.ToString());
                throw;
            }
        }


        public void AddProducto(Inventario inventario)
        {

            string query = "insert into INVENTARIO values(" + inventario.idProducto + ", " + inventario.idCategoria + ", '" +
                inventario.nombre + "',' " + inventario.medida + "', " + inventario.precioVenta + ", " + inventario.precioCompra + ",'" +
                 inventario.descripcion + "', " + inventario.existencias + ", '" + inventario.estado + "','" + inventario.imagen + "')";
            try
            {
                connection.Open();
                SqlCommand command = new SqlCommand(query, connection);
                command.ExecuteNonQuery();
                connection.Close();

            }
            catch (SqlException ex)

            {
                Debug.WriteLine(ex.ToString());
                throw;

            }
        }

        public void AddDetalleInventario(int idProducto,int idProveedor)
        {

            string query = "insert into DetalleInventario values(" + idProducto + ", " + idProveedor + ")";
            try
            {
                connection.Open();
                SqlCommand command = new SqlCommand(query, connection);
                command.ExecuteNonQuery();
                connection.Close();

            }
            catch (SqlException ex)

            {
                Debug.WriteLine(ex.ToString());
                throw;

            }
        }

     
        public void AgregarCategoria(Categoria categoria)
        {

            string query = "insert into CATEGORIAS values(" + categoria.idCategoria + ", '" + categoria.nombre + "')";
            try
            {
                connection.Open();
                SqlCommand command = new SqlCommand(query, connection);
                command.ExecuteNonQuery();
                connection.Close();

            }
            catch (SqlException ex)

            {
                Debug.WriteLine(ex.ToString());
                throw;

            }
        }



        public DataSet GetTipoPagos()
        {
            try
            {
                connection.Open();
                SqlCommand command = new SqlCommand("select * from TIPOPAGO", connection);
                SqlDataAdapter sqlDataAdapter = new SqlDataAdapter(command);
                DataSet data = new DataSet();
                sqlDataAdapter.Fill(data);
                connection.Close();
                return data;
            }
            catch (SqlException ex)
            {
                Debug.WriteLine(ex.ToString());
                throw;
            }
        }

        public DataSet GetProductos()
        {
            try
            {
                connection.Open();
                SqlCommand command = new SqlCommand("select * from INVENTARIO where estado = 'A'", connection);
                SqlDataAdapter sqlDataAdapter = new SqlDataAdapter(command);
                DataSet data = new DataSet();
                sqlDataAdapter.Fill(data);
                connection.Close();
                return data;
            }
            catch (SqlException ex)
            {
                Debug.WriteLine(ex.ToString());
                throw;
            }
        }

        public string GetNombreProducto(int idProducto)
        {
            try
            {
                SqlCommand command = new SqlCommand("select nombre from INVENTARIO where idProducto = " + idProducto, connection);
                SqlDataAdapter sqlDataAdapter = new SqlDataAdapter(command);
                DataSet data = new DataSet();
                sqlDataAdapter.Fill(data);
                connection.Close();

                return data.Tables[0].Rows[0][0].ToString();
            }
            catch (SqlException ex)
            {
                Debug.WriteLine(ex.ToString());
                throw;
            }
        }

        public decimal GetCosto(int idProducto)
        {
            try
            {
                connection.Open();
                SqlCommand command = new SqlCommand("select precioVenta from INVENTARIO where idProducto = " + idProducto,
                    connection);
                SqlDataAdapter sqlDataAdapter = new SqlDataAdapter(command);
                DataSet data = new DataSet();
                sqlDataAdapter.Fill(data);
                connection.Close();
                return Convert.ToDecimal(data.Tables[0].Rows[0][0]);
            }
            catch (SqlException ex)
            {
                Debug.WriteLine(ex.ToString());
                throw;
            }
        }

        public void agregarFactura(int idFactura, Factura factura)
        {
            try
            {
                int id = GetID();
                connection.Open();

                SqlCommand sqlCommand = new SqlCommand("ADDFACTURA", connection)
                {
                    CommandType = CommandType.StoredProcedure
                };

                sqlCommand.Parameters.Add(new SqlParameter("@idFactura", id));
                sqlCommand.Parameters.Add(new SqlParameter("@montototal", factura.montoTotal));
                sqlCommand.Parameters.Add(new SqlParameter("@idEmpleado", factura.idEmpleado));
                sqlCommand.Parameters.Add(new SqlParameter("@tipoPago", factura.tipoPago));
                sqlCommand.Parameters.Add(new SqlParameter("@correo", factura.correo));
                sqlCommand.Parameters.Add(new SqlParameter("@descuento", factura.descuento));

                sqlCommand.ExecuteNonQuery();

                connection.Close();
            }
            catch (SqlException ex)
            {
                Debug.WriteLine(ex.ToString());
                connection.Close();
            }
        }

        public void agregarDetallesFactura(int idFactura, List<DetalleFactura> detalles)
        {
            try
            {
                connection.Open();

                foreach (DetalleFactura d in detalles)
                {
                    SqlCommand sqlCommand = new SqlCommand("AddFacturaDetalle", connection)
                    {
                        CommandType = CommandType.StoredProcedure
                    };

                    sqlCommand.Parameters.Add(new SqlParameter("@idFactura", idFactura));
                    sqlCommand.Parameters.Add(new SqlParameter("@idProducto", d.idProducto));
                    sqlCommand.Parameters.Add(new SqlParameter("@costo", d.costo));
                    sqlCommand.Parameters.Add(new SqlParameter("@cantidad", d.cantidad));
                    sqlCommand.Parameters.Add(new SqlParameter("@subtotal", d.subtotal));
                    sqlCommand.Parameters.Add(new SqlParameter("@idFarmacia", d.idFarmacia));

                    sqlCommand.ExecuteNonQuery();
                }
                connection.Close();
            }
            catch (SqlException ex)
            {
                Debug.WriteLine(ex.ToString());
                connection.Close();
            }
        }

        public int VerificarExistencias(int cantidad, int idProducto)
        {
            try
            {
                SqlCommand command = new SqlCommand("select [dbo].[ConsultarExistencias](@cantidad, @idProducto)", connection);
                command.Parameters.Add(new SqlParameter("@cantidad", cantidad));
                command.Parameters.Add(new SqlParameter("@idProducto", idProducto));
                SqlDataAdapter sqlDataAdapter = new SqlDataAdapter(command);
                DataSet data = new DataSet();
                sqlDataAdapter.Fill(data);
                connection.Close();

                return Convert.ToInt32(data.Tables[0].Rows[0][0]);
            }
            catch (SqlException ex)
            {
                Debug.WriteLine(ex.ToString());
                throw;
            }
        }

        public int GetID()
        {
            try
            {
                SqlCommand command = new SqlCommand("select top 1 idFactura from Facturas order by idFactura desc", connection);
                SqlDataAdapter sqlDataAdapter = new SqlDataAdapter(command);
                DataSet data = new DataSet();
                sqlDataAdapter.Fill(data);
                connection.Close();

                if (data.Tables[0].Rows.Count == 0)
                    return 1;
                else
                    return Convert.ToInt32(data.Tables[0].Rows[0][0]) + 1;
            }
            catch (SqlException ex)
            {
                Debug.WriteLine(ex.ToString());
                throw;
            }
        }

        public DataSet GetEmpleados()
        {
            try
            {
                connection.Open();
                SqlCommand command = new SqlCommand("select * from Empleados", connection);
                SqlDataAdapter sqlDataAdapter = new SqlDataAdapter(command);
                DataSet data = new DataSet();
                sqlDataAdapter.Fill(data);
                connection.Close();
                return data;
            }
            catch (SqlException ex)
            {
                Debug.WriteLine(ex.ToString());
                throw;
            }
        }

       


        //METODOS YANILY

        public string GetRol(int idEmpleado)
        {

            try
            {
                connection.Open();
                SqlCommand command = new SqlCommand("select rol from EMPLEADOS where idEmpleado=" + idEmpleado, connection);
                SqlDataAdapter sqlDataAdapter = new SqlDataAdapter(command);
                DataSet data = new DataSet();
                sqlDataAdapter.Fill(data);
                connection.Close();

                return data.Tables[0].Rows[0][0].ToString();
            }
            catch (SqlException ex)
            {
                Debug.WriteLine(ex.ToString());
                throw;
            }

        }

        public DataSet GetNombreEmpleados()
        {

            try
            {
                connection.Open();
                SqlCommand command = new SqlCommand("select idEmpleado, nombre from EMPLEADOS", connection);
                SqlDataAdapter sqlDataAdapter = new SqlDataAdapter(command);
                DataSet data = new DataSet();
                sqlDataAdapter.Fill(data);
                connection.Close();
                return data;
            }
            catch (SqlException ex)
            {
                Debug.WriteLine(ex.ToString());
                throw;
            }
        }


        public void AgregarUsuario(Usuario usuario)
        {
            string query = "insert into USUARIOS values('" + usuario.usuario + "', '" + usuario.contrasena + "', '" + usuario.rol + "', " + usuario.idEmpleado + ")";
            try
            {
                connection.Open();
                SqlCommand command = new SqlCommand(query, connection);
                command.ExecuteNonQuery();
                connection.Close();

            }
            catch (SqlException ex)

            {
                Debug.WriteLine(ex.ToString());
                throw;

            }
        }
        public void AgregarProveedor(Proveedor proveedor)
        {
            string query = "insert into PROVEEDORES values(" + proveedor.idProveedor + ", '" +
                proveedor.nombre + "','" + proveedor.direccion + "','" +
                 proveedor.descripcion + "')";
            try
            {
                connection.Open();
                SqlCommand command = new SqlCommand(query, connection);
                command.ExecuteNonQuery();
                connection.Close();

            }
            catch (SqlException ex)

            {
                Debug.WriteLine(ex.ToString());
                throw;

            }
        }

        public void AgregarProveedorT(int idProveedor, string telefono)
        {
            string query = "insert into PROVEEDORES_TELEFONOS values(" + idProveedor + ", '" +
                telefono + "')";
            try
            {
                connection.Open();
                SqlCommand command = new SqlCommand(query, connection);
                command.ExecuteNonQuery();
                connection.Close();

            }
            catch (SqlException ex)

            {
                Debug.WriteLine(ex.ToString());
                throw;

            }
        }

     
        public void AgregarProveedorC(int idProveedor, string correo)
        {
            string query = "insert into PROVEEDORES_CORREOS values(" + idProveedor + ", '" + correo + "')";
            try
            {
                connection.Open();
                SqlCommand command = new SqlCommand(query, connection);
                command.ExecuteNonQuery();
                connection.Close();

            }
            catch (SqlException ex)

            {
                Debug.WriteLine(ex.ToString());
                throw;

            }
        }
        //METODOS NUEVOS 

        public DataSet GetConsultarEmpleados(int idEmpleado)
        {
            try
            {
                connection.Open();
                SqlCommand command = new SqlCommand("select * from EMPLEADOS where idEmpleado = " + idEmpleado,
                    connection);
                SqlDataAdapter sqlDataAdapter = new SqlDataAdapter(command);
                DataSet data = new DataSet();
                sqlDataAdapter.Fill(data);
                connection.Close();
                return data;
            }
            catch (SqlException ex)
            {
                Debug.WriteLine(ex.ToString());
                throw;
            }
        }

        public DataSet GetConsultarProducto(int idProducto)
        {
            try
            {
                connection.Open();
                SqlCommand command = new SqlCommand("select t.nombre as nombreCategoria, i.nombre as nombre, " +
                    "i.medida as medida, i.precioVenta as precioVenta, i.precioCompra as precioCompra," +
                    " i.descripcion as descripcion, i.existencias from CATEGORIAS t, INVENTARIO i where idProducto = " + idProducto
                    + " and t.idCategoria = i.idCategoria",
                    connection);
                SqlDataAdapter sqlDataAdapter = new SqlDataAdapter(command);
                DataSet data = new DataSet();
                sqlDataAdapter.Fill(data);
                connection.Close();
                return data;
            }
            catch (SqlException ex)
            {
                Debug.WriteLine(ex.ToString());
                throw;
            }
        }


        public DataSet GetConsultarProveedor(int idProveedor)
        {
            try
            {
                connection.Open();
                SqlCommand command = new SqlCommand("select * from PROVEEDORES where idProveedor = " + idProveedor,
                    connection);
                SqlDataAdapter sqlDataAdapter = new SqlDataAdapter(command);
                DataSet data = new DataSet();
                sqlDataAdapter.Fill(data);
                connection.Close();
                return data;
            }
            catch (SqlException ex)
            {
                Debug.WriteLine(ex.ToString());
                throw;
            }
        }


        public DataSet GetProveedorID(int idProveedor)
        {
            try
            {
                connection.Open();
                SqlCommand command = new SqlCommand("select nombre,direccion,descripcion from PROVEEDORES where idProveedor = " + idProveedor,
                    connection);
                SqlDataAdapter sqlDataAdapter = new SqlDataAdapter(command);
                DataSet data = new DataSet();
                sqlDataAdapter.Fill(data);
                connection.Close();
                return data;
            }
            catch (SqlException ex)
            {
                Debug.WriteLine(ex.ToString());
                throw;
            }
        }

        public DataSet GetEmpleado()
        {
            try
            {
                connection.Open();
                SqlCommand command = new SqlCommand("select * from EMPLEADOS", connection);
                SqlDataAdapter sqlDataAdapter = new SqlDataAdapter(command);
                DataSet data = new DataSet();
                sqlDataAdapter.Fill(data);
                connection.Close();
                return data;
            }
            catch (SqlException ex)
            {
                Debug.WriteLine(ex.ToString());
                throw;
            }

        }

        public void ActualizarProveedor(Proveedor proveedor)
        {
            string query = "Update PROVEEDORES set direccion='" + proveedor.direccion + "', descripcion='" + proveedor.descripcion + "' where idProveedor=" + proveedor.idProveedor;
            try
            {
                connection.Open();
                SqlCommand command = new SqlCommand(query, connection);
                command.ExecuteNonQuery();
                connection.Close();

            }
            catch (SqlException ex)

            {
                Debug.WriteLine(ex.ToString());
                throw;

            }
        }



    }
}

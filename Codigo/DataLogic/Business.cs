using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using DataEntity;
using DataAccess;
using System.Data;
using System.Windows.Forms;
using System.Transactions;
using System.Data.SqlClient;
using System.Diagnostics;

namespace DataLogic
{
    public class Business
    {
        public void ActualizarProducto(Inventario inventario)
        {
            ConnectionData connection = new ConnectionData();
             connection.ActualizarProducto(inventario);

        }
            public DataSet GetProveedores()
        {
            ConnectionData connection = new ConnectionData();
            return connection.GetProveedores();
        }
        public DataSet GetCategoria()
        {
            ConnectionData connection = new ConnectionData();
            return connection.GetCategoria();
        }

        public DataSet GetInventario()
        {
            ConnectionData connection = new ConnectionData();
            return connection.GetInventario();
        }

        public int GetNewID(string tabla, string idName)
        {
            ConnectionData connection = new ConnectionData();
            return connection.GetNewID(tabla, idName); 
        }

            public void agregarProducto(Inventario inventario, int idProveedor)
        {
            try
            {

                using (TransactionScope scope = new TransactionScope())
                 {
                    ConnectionData connection = new ConnectionData();

                    connection.AddProducto(inventario);
            
                    connection.AddDetalleInventario(inventario.idProducto,idProveedor);
                    scope.Complete();


                }
            }
            catch
            {
                  MessageBox.Show("Error al guardar el producto, intente nuevamente", "Error"
                , MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
        }

        public DataSet GetInventarioID(int idProducto)
        {
            ConnectionData connection = new ConnectionData();
              return  connection.GetInventarioID(idProducto);
        }

        public void agregarEmpleado(Empleados empleados, string correo, string telefono)
        {
            ConnectionData connection = new ConnectionData();
            connection.agregarEmpleado(empleados, correo, telefono);
        }
        public DataSet VerifyLogin(string username, string password)
        {
            ConnectionData connection = new ConnectionData();
            return connection.VerifyLogin(username, password);
        }


        public void AgregarCategoria(Categoria categoria)
        {
                    ConnectionData connection = new ConnectionData();
                    connection.AgregarCategoria(categoria);
        }


        //METODOS ROBERTH FACTURA
        //public DataSet GetProveedores()
        //{
        //    ConnectionData connection = new ConnectionData();
        //    return connection.GetProveedores();
        //}
        //public DataSet GetCategoria()
        //{
        //    ConnectionData connection = new ConnectionData();
        //    return connection.GetCategoria();
        //}

        //public DataSet GetInventario()
        //{
        //    ConnectionData connection = new ConnectionData();
        //    return connection.GetInventario();
        //}

        public DataSet GetTipoPagos()
        {
            ConnectionData connection = new ConnectionData();
            return connection.GetTipoPagos();
        }

        public DataSet GetProductos()
        {
            ConnectionData connection = new ConnectionData();
            return connection.GetProductos();
        }


        public string GetNombreProducto(int idProducto)
        {
            ConnectionData connection = new ConnectionData();
            return connection.GetNombreProducto(idProducto);
        }

        public decimal GetCosto(int idProducto)
        {
            ConnectionData connection = new ConnectionData();
            return connection.GetCosto(idProducto);
        }

        public DataSet GetEmpleados()
        {
            ConnectionData connection = new ConnectionData();
            return connection.GetEmpleados();
        }

        //public void AgregarCategoria(Categoria categoria)
        //{
        //    ConnectionData connection = new ConnectionData();
        //    connection.AgregarCategoria(categoria);
        //}

        public bool agregarFactura(Factura factura, List<DetalleFactura> detalles)
        {
            try
            {
                using (TransactionScope scope = new TransactionScope())
                {
                    ConnectionData connection = new ConnectionData();
                    int idFactura = connection.GetID();
                    connection.agregarFactura(idFactura, factura);
                    connection.agregarDetallesFactura(idFactura, detalles);
                    scope.Complete();
                    return true;
                }
            }
            catch (Exception ex)
            {
                Debug.WriteLine(ex.Message);
                return false;
            }
        }

        public int VerificarExistencias(string cantidad, string idProducto)
        {
            ConnectionData connection = new ConnectionData();
            return connection.VerificarExistencias(Convert.ToInt32(cantidad), Convert.ToInt32(idProducto));
        }


        //METODOS YANILY

        public void AgregarProveedor(Proveedor proveedor, string correo, string telefono)
        {
            try
            {

                using (TransactionScope scope = new TransactionScope())
                {
                    ConnectionData connection = new ConnectionData();

                    connection.AgregarProveedor(proveedor);
                    connection.AgregarProveedorT(proveedor.idProveedor, telefono);
                    connection.AgregarProveedorC(proveedor.idProveedor, correo);
                    scope.Complete();


                }
            }
            catch
            {
                MessageBox.Show("Error al guardar el proveedor, intente nuevamente", "Error"
              , MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
        }

        public object GetAllEmpleado()
        {
            ConnectionData connection = new ConnectionData();
            return connection.GetNombreEmpleados();
        }

        public string GetRol(int idEmpleado)
        {
            ConnectionData connection = new ConnectionData();
            return connection.GetRol(idEmpleado);
        }


        public void AgregarUsuario(Usuario usuario)
        {
            ConnectionData connection = new ConnectionData();
            connection.AgregarUsuario(usuario);
        }

        //METODOS NUEVOS
        public DataSet GetConsultarProveedor(int idProveedor)
        {
            ConnectionData connection = new ConnectionData();
            return connection.GetConsultarProveedor(idProveedor);
        }
        public DataSet GetConsultarEmpleados(int idEmpleado)
        {
            ConnectionData connection = new ConnectionData();
            return connection.GetConsultarEmpleados(idEmpleado);
        }

        public DataSet GetConsultarProducto(int IdProducto)
        {

            ConnectionData connection = new ConnectionData();
            return connection.GetConsultarProducto(IdProducto);

        }


        public DataSet GetProveedorID(int idProveedor)
        {
            ConnectionData connection = new ConnectionData();
            return connection.GetProveedorID(idProveedor);

        }


        public void ActualizarProveedor(Proveedor proveedor)
        {
            ConnectionData connection = new ConnectionData();
            connection.ActualizarProveedor(proveedor);
        }

    }




  



}


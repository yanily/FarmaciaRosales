using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DataEntity;
using DataLogic;
namespace DataPresentation
{
    public partial class RegistroProducto : System.Web.UI.Page
    {
       

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                FillDDLCampos();
                GetProductoID();
            }
        }

        private void GetProductoID()
        {

            Business business = new Business();
            tbProducto.Text = business.GetNewID("Inventario","idProducto").ToString();
        }

        private void FillDDLCampos()
        {
            
            Business business = new Business();
            DDLCategoria.DataSource = business.GetCategoria();
            DDLCategoria.DataTextField = "Nombre";
            DDLCategoria.DataValueField = "idCategoria";
            DDLCategoria.DataBind();
            DDLCategoria.Items.Insert(0, "Seleccione la categoria");

            DDLProveedor.DataSource = business.GetProveedores();
            DDLProveedor.DataTextField = "Nombre";
            DDLProveedor.DataValueField = "idProveedor";
            DDLProveedor.DataBind();
            DDLProveedor.Items.Insert(0, "Seleccione el proveedor");


            DDLEstado.Items.Insert(0, "Seleccionar estado");
            DDLEstado.Items.Insert(1, "Activo");
            DDLEstado.Items.Insert(2, "Inactivo");
        }


        private void ShowMessage(string v)
        {
            ClientScript.RegisterStartupScript(this.GetType(), "myalert", "alert('" + v + "')", true);
        }

        private void limpiar()
        {
            tbDescripcion.Text = "";
            tbExistencias.Text = "";
            tbMedida.Text = "";
            tbNombre.Text = "";
            tbPrecioVenta.Text = "";
            tbPrecioCompra.Text="";
            tbDescripcion.Text = "";
            FillDDLCampos();
            GetProductoID();


        }

        protected void btnAgregar_Click(object sender, EventArgs e)
        {
            int idProveedor=0;
            bool completed=true;
            string ruta = "imag/Medicamentos/" + FileUpload1.FileName; 

                Inventario inventario = new Inventario();
            if (DDLProveedor.SelectedIndex != 0)

                idProveedor = Convert.ToInt32(DDLProveedor.SelectedValue);
            else
                completed = false;
            if (DDLCategoria.SelectedIndex != 0)
                inventario.idCategoria = Convert.ToInt32(DDLCategoria.SelectedValue);
            else
                completed=false;

            if (!String.IsNullOrEmpty(tbProducto.Text))
                inventario.idProducto = Convert.ToInt32(tbProducto.Text);
            else
                completed = false;

            if (!String.IsNullOrEmpty(tbPrecioCompra.Text))
                inventario.precioCompra = Convert.ToDouble(tbPrecioCompra.Text);
            else
                completed = false;
            if (!String.IsNullOrEmpty(tbPrecioVenta.Text))

                inventario.precioVenta = Convert.ToDouble(tbPrecioVenta.Text);
            else
                completed=false;
            if (!String.IsNullOrEmpty(tbMedida.Text))
                inventario.medida = tbMedida.Text;
            else
                completed = false;
            if (!String.IsNullOrEmpty(tbNombre.Text))
                inventario.nombre = tbNombre.Text;
            else completed = false;
            if (!String.IsNullOrEmpty(tbExistencias.Text))

                inventario.existencias = Convert.ToInt32(tbExistencias.Text);
            else
                completed = false;
            if (!String.IsNullOrEmpty(tbDescripcion.Text))
                inventario.descripcion = tbDescripcion.Text;
            else
                completed = false;

            if (DDLEstado.SelectedIndex != 0)
            {
                if (DDLEstado.SelectedValue == "Activo")
                {


                    inventario.estado = 'A';
                }
                else
                {
                    inventario.estado = 'I';

                }
            }
            else
                completed = false;

            if (FileUpload1.HasFile)

                inventario.imagen = ruta;
            else
                completed = false;

            if (completed)
            {
               
                Business business = new Business();
                business.agregarProducto(inventario, idProveedor);
                ShowMessage("Añadido correctamente.");
                limpiar();
            }
            else
                ShowMessage("Debe llenar todos los campos.");                                    
        }
    }
}
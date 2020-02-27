using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DataLogic;
using DataEntity;
using System.Data;

namespace DataPresentation
{
    public partial class ActualizarProducto : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
                FillDDLProducto();
        }





        private void FillDDLProducto()
        {

            Business business = new Business();
            DDLProducto.DataSource = business.GetInventario();
            DDLProducto.DataTextField = "Nombre";
            DDLProducto.DataValueField = "idProducto";
            DDLProducto.DataBind();
            DDLProducto.Items.Insert(0, "Seleccione el producto");
        }


        protected void btnActualizar_Click(object sender, EventArgs e)
        {

            bool completed = true;


            Inventario inventario = new Inventario();

            if (DDLProducto.SelectedIndex != 0)
                inventario.idProducto = Convert.ToInt32(DDLProducto.SelectedValue);
            else
                completed = false;

            if (!String.IsNullOrEmpty(tbPrecioCompra.Text))
                inventario.precioCompra = Convert.ToDouble(tbPrecioCompra.Text);
            else
                completed = false;
            if (!String.IsNullOrEmpty(tbPrecioVenta.Text))

                inventario.precioVenta = Convert.ToDouble(tbPrecioVenta.Text);
            else
                completed = false;
            if (!String.IsNullOrEmpty(tbMedida.Text))
                inventario.medida = tbMedida.Text;
            else
                completed = false;


            if (!String.IsNullOrEmpty(tbDescripcion.Text))
                inventario.descripcion = tbDescripcion.Text;
            else
                completed = false;

            if (!String.IsNullOrEmpty(tbCantidad.Text))
                inventario.existencias = Convert.ToInt32(tbCantidad.Text);
            else
                completed = false;


            if (completed)
            {

                Business business = new Business();
                business.ActualizarProducto(inventario);
                ShowMessage("Añadido correctamente.");
                limpiar();
            }
            else
                ShowMessage("Debe llenar todos los campos.");


        }

        private void limpiar()
        {

            tbMedida.Text = "";
            tbPrecioVenta.Text = "";
            tbPrecioCompra.Text = "";
            tbDescripcion.Text = "";
            tbCantidad.Text = "";
            FillDDLProducto();


        }


        private void ShowMessage(string v)
        {
            ClientScript.RegisterStartupScript(this.GetType(), "myalert", "alert('" + v + "')", true);
        }

        protected void DDLProducto_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (DDLProducto.SelectedIndex != 0)
            {
                Business business = new Business();
                DataSet dataSet = business.GetInventarioID(Convert.ToInt32(DDLProducto.SelectedValue));
                tbDescripcion.Text = dataSet.Tables[0].Rows[0][3].ToString();
                tbPrecioCompra.Text = dataSet.Tables[0].Rows[0][2].ToString();
                tbPrecioVenta.Text = dataSet.Tables[0].Rows[0][1].ToString();
                tbMedida.Text = dataSet.Tables[0].Rows[0][4].ToString();
                tbCantidad.Text = dataSet.Tables[0].Rows[0][5].ToString();

            }
        }

    }
}
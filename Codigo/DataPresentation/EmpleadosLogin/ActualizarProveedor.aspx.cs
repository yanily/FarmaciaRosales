using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DataEntity;
using DataLogic;

namespace DataPresentation
{
    public partial class ActualizarProveedor : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

            if (!IsPostBack)
            {
                FillDDLCamposProveedor();
            }

        }

        protected void btnActualizarProveedor_Click(object sender, EventArgs e)
        {


            bool completed = true;


            Proveedor proveedor = new Proveedor();
            if (DDLProveedor.SelectedIndex != 0)
            {
                proveedor.idProveedor = (Convert.ToInt32(DDLProveedor.SelectedValue));
            }

            else
                completed = false;

            if (!String.IsNullOrEmpty(tbDireccion.Text))
                proveedor.direccion = tbDireccion.Text;
            else
                completed = false;

            if (!String.IsNullOrEmpty(tbDescripcion.Text))
                proveedor.descripcion = tbDescripcion.Text;
            else
                completed = false;


            if (completed)
            {

                Business business = new Business();
                business.ActualizarProveedor(proveedor);
                ShowMessage("Actualizado correctamente.");
                limpiarProveedor();
            }
            else
                ShowMessage("Debe llenar todos los campos.");




        }

        protected void DDLProveedor_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (DDLProveedor.SelectedIndex != 0)
            {
                Business business = new Business();
                DataSet dataSet = business.GetProveedorID(Convert.ToInt32(DDLProveedor.SelectedValue));
                tbDireccion.Text = dataSet.Tables[0].Rows[0][1].ToString();
                tbDescripcion.Text = dataSet.Tables[0].Rows[0][2].ToString();



            }

        }

        private void FillDDLCamposProveedor()
        {
            Business business = new Business();
            DDLProveedor.DataSource = business.GetProveedores();
            DDLProveedor.DataTextField = "nombre";
            DDLProveedor.DataValueField = "idProveedor";
            DDLProveedor.DataBind();
            DDLProveedor.Items.Insert(0, "Seleccionar un Proveedor");
        }

        private void limpiarProveedor()
        {
            tbDescripcion.Text = "";
            tbDireccion.Text = "";
            DDLProveedor.SelectedIndex = 0;
        }

        private void ShowMessage(string v)
        {
            ClientScript.RegisterStartupScript(this.GetType(), "myalert", "alert('" + v + "')", true);
        }
    }
}
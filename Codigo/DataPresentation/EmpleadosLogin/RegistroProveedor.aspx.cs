using DataEntity;
using DataLogic;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace DataPresentation
{
    public partial class RegistroProveedor : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                GetProveedorID();
            }
        }

        private void GetProveedorID()
        {
            Business business = new Business();
            tbI.Text = business.GetNewID("Proveedores", "idProveedor").ToString();
        }

        protected void btnAgregarProveedorr_Click(object sender, EventArgs e)
        {

            string correo = "";
            string telefono = "";
            bool completed = true;
            Proveedor proveedor = new Proveedor();
            if (!String.IsNullOrEmpty(tbI.Text))

                proveedor.idProveedor = Convert.ToInt32(tbI.Text);
            else
                completed = false;

            if (!String.IsNullOrEmpty(tbNombre.Text))

                proveedor.nombre = tbNombre.Text;
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

            if (!String.IsNullOrEmpty(tbCorreo.Text))

                correo = tbCorreo.Text;
            else
                completed = false;

            if (!String.IsNullOrEmpty(tbTelefono.Text))

                telefono = tbTelefono.Text;
            else
                completed = false;

            if (completed)
            {
                Business business = new Business();
                business.AgregarProveedor(proveedor, correo, telefono);
                limpiarProveedor();
                ShowMessage("Agregado Correctamente");

            }
            else
                ShowMessage("Debe llenar todos los campos.");
        }

        private void limpiarProveedor()
        {
            GetProveedorID();
            tbNombre.Text = "";
            tbDescripcion.Text = "";
            tbDireccion.Text = "";
            tbTelefono.Text = "";
            tbCorreo.Text = "";
        }

        private void ShowMessage(string v)
        {
            ClientScript.RegisterStartupScript(this.GetType(), "myalert", "alert('" + v + "')", true);
        }
    }
}

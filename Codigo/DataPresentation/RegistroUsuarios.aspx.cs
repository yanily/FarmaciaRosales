using DataEntity;
using DataLogic;
using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace DataPresentation
{
    public partial class RegistroUsuarios : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                FillDDLCamposEmpleado();
            }

        }

        protected void DDLEmpleadol_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (DDLEmpleadol.SelectedIndex != 0)
            {
                Business business = new Business();
                tbRol.Text = business.GetRol(Convert.ToInt32(DDLEmpleadol.SelectedValue));
            }

        }

        private void FillDDLCamposEmpleado()
        {
            Business business = new Business();
            DDLEmpleadol.DataSource = business.GetAllEmpleado();
            DDLEmpleadol.DataTextField = "nombre";
            DDLEmpleadol.DataValueField = "idEmpleado";
            DDLEmpleadol.DataBind();
            DDLEmpleadol.Items.Insert(0, "Seleccionar Empleado");
        }

        protected void btnAgregarUsuario_Click(object sender, EventArgs e)
        {
            bool completed = true;
            Usuario usuario = new Usuario();

            if (!String.IsNullOrEmpty(tbUsuario.Text))
            {
                usuario.usuario = tbUsuario.Text;
            }
            else
                completed = false;

            if (!String.IsNullOrEmpty(tbPassword.Text))
            {
                usuario.contrasena = tbPassword.Text;
            }
            else
                completed = false;
            if (DDLEmpleadol.SelectedIndex != 0)
            {
                usuario.idEmpleado = Convert.ToInt32(DDLEmpleadol.SelectedValue);
                usuario.rol = tbRol.Text;
            }
            else
                completed = false;

            if (completed)
            {
                Business business = new Business();
                business.AgregarUsuario(usuario);
                limpiarUsuario();
                ShowMessage("Agregado Correctamente");
                FillDDLCamposEmpleado();
            }
            else
                ShowMessage("Debe llenar todos los campos.");



        }

        private void limpiarUsuario()
        {
            tbUsuario.Text = "";
            tbPassword.Text = "";
            tbRol.Text = "";
            DDLEmpleadol.SelectedIndex = 0;
        }

        private void ShowMessage(string v)
        {
            ClientScript.RegisterStartupScript(this.GetType(), "myalert", "alert('" + v + "')", true);
        }
    }
}
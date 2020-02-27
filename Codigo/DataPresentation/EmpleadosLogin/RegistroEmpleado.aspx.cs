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
    public partial class RegistroEmpleado : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                GetEmpleadoID();
                FillDDLRol();
            }
        }

        public void FillDDLRol()
        {
            DDLRol.Items.Insert(0, "Seleccionar estado");
            DDLRol.Items.Insert(1, "Admin");
            DDLRol.Items.Insert(2, "Cajero");
            DDLRol.Items.Insert(3, "Depend");
        }

        private void GetEmpleadoID()
        {

            Business business = new Business();
            tbIDEmpleado.Text = business.GetNewID("Empleados", "idEmpleado").ToString();
        }

        protected void btnAgregarEmpleado_Click(object sender, EventArgs e)
        {
            string correo = "";
            string telefono = "";
            bool completed=true;
            DataEntity.Empleados empleados = new DataEntity.Empleados();
            empleados.idFarmacia = 2;

            if (!String.IsNullOrEmpty(tbIDEmpleado.Text))
                empleados.idEmpleado = Convert.ToInt32(tbIDEmpleado.Text);
            else
                completed = false;

            if (!String.IsNullOrEmpty(tbNombre.Text))
                empleados.nombre = tbNombre.Text;
            else
                completed = false;
            if (DDLRol.SelectedIndex != 0)
                empleados.rol = DDLRol.SelectedItem.Text;
            else
                completed = false;

            if (!String.IsNullOrEmpty(tbSalario.Text))
                empleados.salario = Convert.ToDecimal(tbSalario.Text);
            else
                completed = false;

            if (!String.IsNullOrEmpty(tbDireccion.Text))
                empleados.direccion = tbDireccion.Text;

            else
                completed = false;

            if (!String.IsNullOrEmpty(tbCorreo.Text))
                correo = tbCorreo.Text;
            else completed = false;

            if (!String.IsNullOrEmpty(tbTelefono.Text))
                telefono = tbTelefono.Text;
            else
                completed = false;
            if (completed)
            {

                Business business = new Business();
                business.agregarEmpleado(empleados,correo,telefono);
                ShowMessage("Añadido correctamente.");
                Limpiar();
            }
            else
                ShowMessage("Debe llenar todos los campos.");

            
        }

        public void Limpiar()
        {
            tbCorreo.Text = "";
            tbDireccion.Text = "";
            tbNombre.Text = "";
            tbSalario.Text = "";
            tbTelefono.Text = "";
            GetEmpleadoID();
            FillDDLRol();
        }

        private void ShowMessage(string v)
        {
            ClientScript.RegisterStartupScript(this.GetType(), "myalert", "alert('" + v + "')", true);
        }



    }
}
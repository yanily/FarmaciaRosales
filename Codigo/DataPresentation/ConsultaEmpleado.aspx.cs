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
    public partial class ConsultaEmpleado : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

            if (!IsPostBack)
            {
                FillDDLCamposEmpleado();
            }
        }

        protected void DDLEmpleado_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (DDLEmpleado.SelectedIndex != 0)
            {
                Business business = new Business();
                gvConsultaEmpleado.DataSource = business.GetConsultarEmpleados(Convert.ToInt32(DDLEmpleado.SelectedValue));
                gvConsultaEmpleado.DataBind();
            }
        }
        private void FillDDLCamposEmpleado()
        {
            Business business = new Business();
            DDLEmpleado.DataSource = business.GetEmpleados();
            DDLEmpleado.DataTextField = "nombre";
            DDLEmpleado.DataValueField = "idEmpleado";
            DDLEmpleado.DataBind();
            DDLEmpleado.Items.Insert(0, "Seleccionar Empleado");
        }
    }
}
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace DataPresentation.Empleados
{
    public partial class Verificar : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string role = Request.Cookies["rol"].Value;
                if (role.Equals("admin") || role.Equals("Manager"))
                    Response.Redirect("/EmpleadosLogin/RegistroEmpleado.aspx");
                else
                    Response.Redirect("~/NoPermission.aspx");
            }
        }

    }


}
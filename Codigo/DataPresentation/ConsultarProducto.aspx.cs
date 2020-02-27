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
    public partial class ConsultarProducto : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                FillDDLCamposProducto();
            }
        }

        protected void DDLProducto_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (DDLProducto.SelectedIndex != 0)
            {
                Business business = new Business();
                gvConsultaProducto.DataSource = business.GetConsultarProducto(Convert.ToInt32(DDLProducto.SelectedValue));
                gvConsultaProducto.DataBind();
            }
        }
        private void FillDDLCamposProducto()
        {
            Business business = new Business();
            DDLProducto.DataSource = business.GetInventario();
            DDLProducto.DataTextField = "nombre";
            DDLProducto.DataValueField = "idProducto";
            DDLProducto.DataBind();
            DDLProducto.Items.Insert(0, "Seleccionar Producto");
        }
    }
}
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
    public partial class ConsultarProveedor : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                FillDDLCamposProveedor();
            }

        }

        private void FillDDLCamposProveedor()
        {
            Business business = new Business();
            DDLProveedor.DataSource = business.GetProveedores();
            DDLProveedor.DataTextField = "nombre";
            DDLProveedor.DataValueField = "idProveedor";
            DDLProveedor.DataBind();
            DDLProveedor.Items.Insert(0, "Seleccionar Proveedor");
        }

        protected void DDLProveedor_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (DDLProveedor.SelectedIndex != 0)
            {
                Business business = new Business();
                gvConsultaProveedor.DataSource = business.GetConsultarProveedor(Convert.ToInt32(DDLProveedor.SelectedValue));
                gvConsultaProveedor.DataBind();
            }
        }
    }
}
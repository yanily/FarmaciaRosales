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
    public partial class Catalogo : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                FillDataList();
            }
        }

        private void FillDataList()           
        {
            Business business = new Business();
            dlInventario.DataSource = business.GetInventario();
            dlInventario.DataBind();
        }

        
        protected void dlInventario_ItemCommand(object source, DataListCommandEventArgs e)
        {

        }
    }
}
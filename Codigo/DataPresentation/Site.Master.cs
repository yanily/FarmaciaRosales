using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace DataPresentation
{
    public partial class SiteMaster : MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }


        protected void LoginStatusNTier_LoggingOut(object sender, LoginCancelEventArgs e)
        {
            if (Request.Cookies["rol"] != null)
            {
                Response.Cookies["rol"].Expires = DateTime.Now.AddDays(-1);
            }
        }
    }
}
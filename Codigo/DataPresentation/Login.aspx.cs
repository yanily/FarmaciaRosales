using DataLogic;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace DataPresentation
{
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

       protected void LoginNTier_Authenticate(object sender, AuthenticateEventArgs e)
        {
            DataSet confirming = VerifyLogin(LoginNTier.UserName, LoginNTier.Password);
            if (confirming.Tables.Count > 0)
            {
                if (confirming.Tables[0].Rows.Count > 0)
                {
                    HttpCookie role = new HttpCookie("rol")
                    {
                        Value = confirming.Tables[0].Rows[0][0].ToString(),
                        Expires = DateTime.Now.AddHours(5)
                    };
                    Response.Cookies.Add(role);

                    FormsAuthentication.RedirectFromLoginPage(LoginNTier.UserName, LoginNTier.RememberMeSet);
                }
                else
                    Response.Redirect("Login.aspx");
            }
            else
                Response.Redirect("Login.aspx");
        }

        private DataSet VerifyLogin(string username, string password)
        {
            Business business = new Business();
            return business.VerifyLogin(username, password);
        }
    }

    
}

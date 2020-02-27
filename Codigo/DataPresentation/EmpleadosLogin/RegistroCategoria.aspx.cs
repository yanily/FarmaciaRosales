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
    public partial class RegistroCategoria : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                GetCategoriaID();
            }

        }

        private void GetCategoriaID()
        {

            Business business = new Business();
            tbCategoria.Text = business.GetNewID("Categorias", "idCategoria").ToString();
        }

        private void ShowMessage(string v)
        {
            ClientScript.RegisterStartupScript(this.GetType(), "myalert", "alert('" + v + "')", true);
        }

        protected void btnAgregarCategoria_Click(object sender, EventArgs e)
        {
            bool completed = true;
            Categoria categoria = new Categoria();

            if (!String.IsNullOrEmpty(tbCategoria.Text))//Inventario

                categoria.idCategoria = Convert.ToInt32(tbCategoria.Text);
            else
                completed = false;


            if (!String.IsNullOrEmpty(tbNombre.Text))//4
                categoria.nombre = tbNombre.Text;
            else
                completed = false;

            if (completed)
            {
                Business business = new Business();
                business.AgregarCategoria(categoria);
                ShowMessage("Añadido correctamente.");
                limpiar();


            }
            else
                ShowMessage("Debe llenar todos los campos.");
        }


        public void limpiar()
        {
            tbNombre.Text = "";
            GetCategoriaID();

        }
    }
}
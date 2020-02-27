using DataLogic;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DataLogic;
using DataEntity;

namespace DataPresentation
{
    public partial class Facturacion : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                FillDDLCampos();
                SetInitialRow();
                tbFecha.Text = DateTime.Now.ToString();
            }
        }

        private void SetInitialRow()
        {
            DataTable dt = new DataTable();
            dt.Columns.Add(new DataColumn("idProducto", typeof(string)));
            dt.Columns.Add(new DataColumn("nombreProducto", typeof(string)));
            dt.Columns.Add(new DataColumn("precio", typeof(string)));
            dt.Columns.Add(new DataColumn("cantidad", typeof(string)));
            dt.Columns.Add(new DataColumn("subtotal", typeof(string)));
            ViewState["CurrentTable"] = dt;
            gvProductos.DataSource = dt;
            gvProductos.DataBind();
        }

        private void FillDDLCampos()
        {
            Business business = new Business();
            tipoDDL.DataSource = business.GetTipoPagos();
            tipoDDL.DataTextField = "descripcion";
            tipoDDL.DataValueField = "idTipoPago";
            tipoDDL.DataBind();
            tipoDDL.Items.Insert(0, "Seleccione tipo pago");

            productosDDL.DataSource = business.GetProductos();
            productosDDL.DataTextField = "nombre";
            productosDDL.DataValueField = "idProducto";
            productosDDL.DataBind();
            productosDDL.Items.Insert(0, "Seleccione producto");

            empleadoDDL.DataSource = business.GetEmpleados();
            empleadoDDL.DataTextField = "nombre";
            empleadoDDL.DataValueField = "idEmpleado";
            empleadoDDL.DataBind();
            empleadoDDL.Items.Insert(0, "Seleccione el empleado");
        }

        protected void productosDDL_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (productosDDL.SelectedIndex != 0)
            {
                Business business = new Business();
                tbPrecio.Text = business.GetCosto(Convert.ToInt32(productosDDL.SelectedValue)).ToString();
            }
            else
                tbPrecio.Text = "";
        }

        protected void gvProductos_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            GridViewRow row = (GridViewRow)gvProductos.Rows[e.RowIndex];
            string idProducto = row.Cells[0].Text;
            DataTable dtCurrentTable = (DataTable)ViewState["CurrentTable"];

            for (int i = dtCurrentTable.Rows.Count - 1; i >= 0; i--)
            {
                DataRow dr = dtCurrentTable.Rows[i];
                if (dr["idProducto"].Equals(idProducto))
                    dr.Delete();
            }
            dtCurrentTable.AcceptChanges();
            ViewState["CurrentTable"] = dtCurrentTable;
            gvProductos.DataSource = dtCurrentTable;
            gvProductos.DataBind();

            VerificarDescuento();
            lbMontoTotal.Text = "" + calcularMonto();
        }

        protected void btnFacturar_Click(object sender, EventArgs e)
        {
            bool cantidad = false;
            string nombre = "";
            Business business = new Business();
            DataTable dtCurrentTable = (DataTable)ViewState["CurrentTable"];
            if (dtCurrentTable.Rows.Count > 0 && empleadoDDL.SelectedIndex != 0 && tipoDDL.SelectedIndex != 0)
            {
                Factura factura = new Factura()
                {
                    fecha = DateTime.Now,
                    montoTotal = calcularMonto(),
                    idEmpleado = Convert.ToInt32(empleadoDDL.SelectedValue),
                    tipoPago = Convert.ToInt32(tipoDDL.SelectedValue),
                    correo = tbCorreo.Text,
                    descuento = VerificarDescuento(),
                    IVA = 13,
                    IV = 2
                };
                List<DetalleFactura> detalles = new List<DetalleFactura>();

                for (int i = 0; i <= dtCurrentTable.Rows.Count - 1; i++)
                {
                    DataRow dr = dtCurrentTable.Rows[i];
                    if (business.VerificarExistencias(dr["cantidad"].ToString(), dr["idProducto"].ToString()) == 0)
                    {
                        DetalleFactura detalle = new DetalleFactura()
                        {
                            idProducto = Convert.ToInt32(dr["idProducto"]),
                            costo = Convert.ToDecimal(dr["precio"]),
                            cantidad = Convert.ToInt32(dr["cantidad"]),
                            subtotal = Convert.ToDecimal(dr["subtotal"]),
                            idFarmacia = 2
                        };
                        detalles.Add(detalle);
                    }
                    else
                    {
                        cantidad = true;
                        nombre = dr["nombreProducto"].ToString();
                        break;
                    }
                }

                if (!cantidad)
                {
                    if (business.agregarFactura(factura, detalles))
                    {
                        ShowMessage("Factura exitosa");
                        Correo correo = new Correo();
                        if (!String.IsNullOrEmpty(tbCorreo.Text))
                            correo.Send(factura, detalles, tbCorreo.Text, empleadoDDL.SelectedItem.Text, tipoDDL.SelectedItem.Text);
                        limpiar();
                    }
                    else
                        ShowMessage("Ha ocurrido un error al momento de realizar la transacción.");
                }
                else
                    ShowMessage("El producto " + nombre + " supera la cantidad de existencias disponibles.");
            }
            else
            {
                ShowMessage("Debe de llenar todos los campos (con excepción de correo, es opcional).");
            }
        }

        private decimal calcularMonto()
        {
            decimal montotal = 0;
            DataTable dtCurrentTable = (DataTable)ViewState["CurrentTable"];

            for (int i = 0; i <= dtCurrentTable.Rows.Count - 1; i++)
            {
                DataRow dr = dtCurrentTable.Rows[i];
                montotal += Convert.ToDecimal(dr["subtotal"].ToString());
            }

            montotal = montotal * (decimal)1.13;
            montotal = montotal * (decimal)1.02;
            montotal = montotal - (montotal * ((decimal)VerificarDescuento() / 100));

            return montotal;
        }

        protected void btnLimpiar_Click(object sender, EventArgs e)
        {
            limpiar();
        }

        private void limpiar()
        {
            tbCantidad.Text = "";
            tbPrecio.Text = "";
            productosDDL.SelectedIndex = 0;
            empleadoDDL.SelectedIndex = 0;
            tipoDDL.SelectedIndex = 0;
            DataTable dtCurrentTable = (DataTable)ViewState["CurrentTable"];

            for (int i = 0; i <= dtCurrentTable.Rows.Count - 1; i++)
            {
                DataRow dr = dtCurrentTable.Rows[i];
                dr.Delete();
            }

            dtCurrentTable.AcceptChanges();
            ViewState["CurrentTable"] = dtCurrentTable;
            gvProductos.DataSource = dtCurrentTable;
            gvProductos.DataBind();
            lbMontoTotal.Text = "";
            tbCorreo.Text = "";
            lbDescuento.Text = "";
        }

        protected void btnAgregar_Click(object sender, EventArgs e)
        {
            Business business = new Business();
            if (business.VerificarExistencias(tbCantidad.Text, productosDDL.SelectedValue.ToString()) == 0)
            {
                DataTable dtCurrentTable = (DataTable)ViewState["CurrentTable"];
                DataRow drCurrentRow = null;
                if (!String.IsNullOrEmpty(tbCantidad.Text) && productosDDL.SelectedIndex != 0)
                {
                    if (!CheckGridview(productosDDL.SelectedValue.ToString()))
                    {

                        drCurrentRow = dtCurrentTable.NewRow();
                        drCurrentRow["idProducto"] = productosDDL.SelectedValue.ToString();
                        drCurrentRow["nombreProducto"] = productosDDL.SelectedItem.Text;
                        drCurrentRow["precio"] = tbPrecio.Text;
                        drCurrentRow["cantidad"] = tbCantidad.Text;
                        decimal sub = Convert.ToInt32(tbCantidad.Text) * Convert.ToDecimal(tbPrecio.Text);
                        drCurrentRow["subtotal"] = sub;
                        dtCurrentTable.Rows.Add(drCurrentRow);
                        dtCurrentTable.AcceptChanges();
                        ViewState["CurrentTable"] = dtCurrentTable;
                        gvProductos.DataSource = dtCurrentTable;
                        gvProductos.DataBind();

                    }
                }
                else
                {
                    ShowMessage("Debe seleccionar y rellenar los campos para el producto");
                }
            }
            else
            {
                ShowMessage("La cantidad seleccionada supera las existencias del producto");
            }
            tbCantidad.Text = "";
            VerificarDescuento();
            lbMontoTotal.Text = "" + calcularMonto();
        }

        private int VerificarDescuento()
        {
            int cant = 0;
            DataTable dtCurrentTable = (DataTable)ViewState["CurrentTable"];
            for (int i = 0; i <= dtCurrentTable.Rows.Count - 1; i++)
            {
                DataRow dr = dtCurrentTable.Rows[i];
                cant += Convert.ToInt32(dr["cantidad"]);
            }

            if (cant >= 3 && cant <= 6)
            {
                lbDescuento.Text = "10%";
                return 10;
            }
            else if (cant >= 7 && cant <= 9)
            {
                lbDescuento.Text = "15%";
                return 15;
            }
            else if (cant >= 10 && cant <= 12)
            {
                lbDescuento.Text = "20%";
                return 20;
            }
            else if (cant >= 13)
            {
                lbDescuento.Text = "25%";
                return 25;
            }
            else
            {
                lbDescuento.Text = "0%";
                return 0;
            }
        }

        private bool CheckGridview(string idProducto)
        {
            DataTable dtCurrentTable = (DataTable)ViewState["CurrentTable"];
            for (int i = 0; i <= dtCurrentTable.Rows.Count - 1; i++)
            {
                DataRow dr = dtCurrentTable.Rows[i];
                if (dr["idProducto"].Equals(idProducto))
                {
                    int cant = Convert.ToInt32(dr["cantidad"].ToString()) + Convert.ToInt32(tbCantidad.Text);
                    dr["cantidad"] = cant;
                    dr["subtotal"] = cant * Convert.ToDecimal(tbPrecio.Text);
                    dtCurrentTable.AcceptChanges();
                    ViewState["CurrentTable"] = dtCurrentTable;
                    gvProductos.DataSource = dtCurrentTable;
                    gvProductos.DataBind();
                    return true;
                }
            }
            return false;
        }

        private void ShowMessage(string v)
        {
            ClientScript.RegisterStartupScript(this.GetType(), "myalert", "alert('" + v + "')", true);
        }
    }
}
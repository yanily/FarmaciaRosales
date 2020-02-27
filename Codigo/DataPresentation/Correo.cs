using DataEntity;
using DataLogic;
using iTextSharp.text;
using iTextSharp.text.pdf;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Net;
using System.Net.Mail;
using System.Web;
namespace DataPresentation
{
    public class Correo
    {
        public void Send(Factura factura, List<DetalleFactura> detalleFacturas, string destinatario, string nombreEmpleado, string tipoPago)
        {
            Business business = new Business();
            var document = new Document();

            MemoryStream memoryStream = new MemoryStream();

            PdfWriter writer = PdfWriter.GetInstance(document, memoryStream);

            document.Open();

            document.Add(new Paragraph("Farmacia Rosales"));
            document.Add(new Paragraph("      "));
            document.Add(new Paragraph("      "));

            document.Add(new Paragraph("Información de compra:"));
            document.Add(new Paragraph("Fecha de factura: " + factura.fecha));
            document.Add(new Paragraph("Empleado: " + nombreEmpleado));
            document.Add(new Paragraph("Tipo de pago: " + tipoPago));
            document.Add(new Paragraph("Monto total: " + factura.montoTotal));
            document.Add(new Paragraph("     "));
            document.Add(new Paragraph("      "));
            document.Add(new Paragraph("Productos comprados: "));

            foreach (var item in detalleFacturas)
            {
                document.Add(new Paragraph("Código de producto: " + item.idProducto));
                document.Add(new Paragraph("Nombre de producto: " + business.GetNombreProducto(item.idProducto)));
                document.Add(new Paragraph("Precio: " + item.costo));
                document.Add(new Paragraph("Cantidad: " + item.cantidad));
                document.Add(new Paragraph("Subtotal: " + item.subtotal));
                document.Add(new Paragraph("     "));
                document.Add(new Paragraph("     "));
            }


            document.Add(new Paragraph("¡Gracias por confiar en nuestro servicio!"));

            writer.CloseStream = false;

            document.Close();

            memoryStream.Position = 0;



            MailMessage email = new MailMessage();

            email.To.Add(new MailAddress(destinatario));

            email.From = new MailAddress("farmacia.rosales.sucursales@gmail.com");

            email.Subject = "Información de compra en Farmacia Rosales";

            email.Body = "Estimado cliente, dentro del presente correo se adjunta la información de la compra realizada.";

            email.Attachments.Add(new Attachment(memoryStream, "FacturaRosales.pdf"));

            email.IsBodyHtml = true;

            email.Priority = MailPriority.Normal;

            SmtpClient smtp = new SmtpClient();

            smtp.Host = "smtp.gmail.com";

            smtp.Port = 587;

            smtp.EnableSsl = true;

            smtp.UseDefaultCredentials = false;



            smtp.Credentials = new NetworkCredential("farmacia.rosales.sucursales@gmail.com", "ucr20191");

            smtp.Send(email);

            email.Dispose();

            smtp.Dispose();

            memoryStream.Close();
        }
    }
}
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DataEntity
{
    public class Inventario
    {
        public int idProducto { get; set; }
        public int idCategoria { get; set; }
        public string nombre { get; set; }
        public string medida { get; set; }
        public double precioVenta { get; set; }
        public double precioCompra { get; set; }
        public string descripcion { get; set; }
        public int existencias { get; set; }
        public char estado { get; set; }
        public string imagen { get; set; }
    }
}

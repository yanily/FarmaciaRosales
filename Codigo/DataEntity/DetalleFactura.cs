using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DataEntity
{
   public  class DetalleFactura
    {
        public int idProducto { get; set; }

        public decimal? costo { get; set; }

        public int? cantidad { get; set; }

        public decimal? subtotal { get; set; }

        public int? idFarmacia { get; set; }
    }
}

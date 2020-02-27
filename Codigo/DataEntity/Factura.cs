using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DataEntity
{
    public class Factura
    {
        public int idFactura { get; set; }

        public DateTime? fecha { get; set; }

        public decimal? montoTotal { get; set; }

        public int? idEmpleado { get; set; }

        public int? idFarmacia { get; set; }

        public int? tipoPago { get; set; }


        public string correo { get; set; }

        public int? descuento { get; set; }

        public int? IVA { get; set; }

        public int? IV { get; set; }
    }
}

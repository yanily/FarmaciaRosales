using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DataEntity
{
    public class Empleados
    {
        public int idEmpleado { get; set; }
        public string nombre { get; set; }
        public string direccion { get; set; }
        public decimal salario { get; set; }
        public string rol { get; set; }
        public int idFarmacia { get; set; }
    }
}

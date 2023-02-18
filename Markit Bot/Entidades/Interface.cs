using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
 
namespace Entidades
{
    // Representa os parâmetros de retorno da Interface

    public class Interface
    {
        public int codInstc { get; set; }
        public DateTime data { get; set; }
        public int tentativasExecucao { get; set; }
        public DateTime dataDefasagemDias { get; set; }
    }

}


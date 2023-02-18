using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Entidades
{
    public class ExtensaoTabela
    {
        // Declarações de alguns valores do rabo de tabela
        public int? ind_sit { get; set; }
        public DateTime? dat_cdm { get; set; }
        public string? usr_cdm { get; set; }

        // Atribuição dos valores declarados do rabo de tabela
        public ExtensaoTabela()
        {
            ind_sit = 1;
            dat_cdm = DateTime.Now;
            usr_cdm = Environment.UserDomainName + "/" + Environment.UserName;
        }
    }
}

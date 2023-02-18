using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Entidades;
using Markit.Utils;
using Markit.DAL;

namespace Markit.BLL
{
    public class LeitorBusiness
    {
        // Ler arquivo xml
        public List<string> LerArquivo()
        {
            return LeitorRepository.LerArquivo();
        }
    }
}

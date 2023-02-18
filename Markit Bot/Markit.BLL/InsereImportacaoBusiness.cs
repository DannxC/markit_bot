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
    public class InsereImportacaoBusiness
    {
        // Inserir importação e recuperar a instância da tabela
        public int InsereImportacao(int numImportacoes)
        {
            InsereImportacaoRepository objInsereImportacao = new InsereImportacaoRepository();

            return objInsereImportacao.InsereImportacao(numImportacoes);
        }
    }
}

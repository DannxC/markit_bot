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
    public class ProcessaExecucoesBusiness
    {
        // Enriquece os dados da Tabela Temporária
        public void ProcessaExecucoes(int codInstcIpc)
        {
            try
            {
                // Chamar proc 

                ProcessaDadosRepository objEnriqueceDados = new ProcessaDadosRepository();

                objEnriqueceDados.ProcessaExecucoes(codInstcIpc);
            }
            catch (Exception e)
            {
                throw e;
            }
        }
    }
}

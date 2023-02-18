using Entidades;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Markit.DAL;

namespace Markit.BLL
{
    public class InterfaceBusiness
    {
        public Interface VerificaImportacaoInterfaceComAgendamento(String itfc, String tarefa, String tipo, string mercado)
        {
            InterfaceRepository objInterfaceRepository = new InterfaceRepository();

            return objInterfaceRepository.VerificaImportacaoInterfaceComAgendamento(itfc, tarefa, tipo, mercado);
        }


        public bool FinalizaInterface(int codigoInstanciaInterfaceControle, Boolean erro, String descErr = null)
        {
            // Inicializa Instância do repositório

            InterfaceRepository obgFinalizaInterfaceRepository = new InterfaceRepository();

            var result = false;

            if (erro)
            {
                result = obgFinalizaInterfaceRepository.FinalizaInterface(codigoInstanciaInterfaceControle, "ERRO", erro, descErr);
            }
            else
            {
                result = obgFinalizaInterfaceRepository.FinalizaInterface(codigoInstanciaInterfaceControle, "EXECUTADA", erro);
            }

            return result;
        }
    }
}

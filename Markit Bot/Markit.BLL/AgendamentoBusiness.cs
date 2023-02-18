using System.Collections.Generic;
using Markit.DAL;

namespace Markit.BLL
{
    public class AgendamentoBusiness
    {
        public List<string> VerificaAgendamentos(string tipo, string tarefa)
        {
            AgendamentoRepository objAgendamento = new AgendamentoRepository();

            return objAgendamento.VerificaAgendamentos(tipo, tarefa);
        }
    }
}

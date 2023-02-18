using Markit.DAL;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Markit.BLL
{
    public class LogErroBusiness
    {
        LogErroRepository erroRepository = new LogErroRepository();

        //Insere no bd o log de erro
        public void InsereLogErro(String erro)
        {
            erroRepository.InsereLogErro(erro);
        }
    }
}

using Markit.DAL;
using System.Collections.Generic;

namespace Markit.BLL
{
    public class EnviaEmailNovasTagsBusiness
    {
        // Envia email avisando que há novas Tags nos arquivos XML
        public void EnviaEmail(List<string> novasTags)
        {
            EnviaEmailNovasTagsRepository enviaEmailNovasTagsRepository = new EnviaEmailNovasTagsRepository();

            enviaEmailNovasTagsRepository.EnviaEmail(novasTags);
        }
    }
}

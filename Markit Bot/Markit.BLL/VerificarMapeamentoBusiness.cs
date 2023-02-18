using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Entidades;
using Markit.Utils;
using Markit.DAL;
using System.Xml.Serialization;
using System.Xml;
using System.Xml.Schema;
using System.Xml.Linq;
using System.Collections;
using System.IO;

namespace Markit.BLL
{
    public class VerificarMapeamentoBusiness
    {
        // Verifica e retorna os XML com tags adicionais.
        public List<string> VerificaTagAdicional(List<string> xmlTexts, string caminhoTags)
        {
            // Declaração de variáveis

            VerificarMapeamentoRepository verificarMapeamentoRepository = new VerificarMapeamentoRepository();

            List<string> novasTags = new List<string>();

            foreach (string xmlText in xmlTexts)
            {
                novasTags.AddRange(verificarMapeamentoRepository.VerificaTagAdicional(xmlText, caminhoTags));
            }

            return novasTags;
        }
    }
}

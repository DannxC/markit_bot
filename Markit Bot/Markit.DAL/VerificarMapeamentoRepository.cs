using System.Collections.Generic;
using System.Linq;
using System.Xml.Linq;
using System.IO;
using System.Configuration;

namespace Markit.BLL
{
    public class VerificarMapeamentoRepository
    {
        // Verifica e retorna os XML com tags adicionais.
        public List<string> VerificaTagAdicional(string xmlText, string caminhoTags)
        {
            // Declaração de variáveis
            XDocument xDocument = new XDocument();
            List<string> novasTags = new List<string>();


            // Parseia o texto em XDocument
            xDocument = XDocument.Parse(xmlText);


            // tags do documento atual
            var tags = xDocument.Root.DescendantNodesAndSelf().OfType<XElement>();


            // tags mapeadas
            var tagsMapeadas = File.ReadAllLines(caminhoTags).ToList<string>();


            // Abre o arquivo de tags mapeadas para escrita
            StreamWriter fluxoTexto = new StreamWriter(caminhoTags, true);       // Habilita o "Append"

            
            // Verifica e Adiciona novas tags no arquivo de tags mapeadas
            foreach (var tag in tags)
            {
                string tagName = tag.Name.ToString();
                if (!tagsMapeadas.Contains(tagName))
                {
                    // Adiciona tag nova
                    fluxoTexto.WriteLine(tag.Name.ToString());

                    // Salva a nova tag e o Trade_ID que foi usado
                    tagsMapeadas.Add(tag.Name.ToString());

                    // Populando novas tags
                    novasTags.Add(tag.Name.ToString());
                }
            }
            fluxoTexto.Close();

            return novasTags;
        }
    }
}

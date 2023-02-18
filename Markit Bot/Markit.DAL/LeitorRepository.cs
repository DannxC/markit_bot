using System;
using System.Collections.Generic;
using System.Configuration;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Markit.Utils;

namespace Markit.DAL
{
    public class LeitorRepository
    {
        public static List<string> LerArquivo()
        {
            // Declaração dos Caminhos e dos arquivos XML encontrados nos caminhos

            List<string> xmlPaths = new List<string>();
            List<string> xmlTexts = new List<string>();


            // Declaração de variáveis auxiliares

            string xmlTextTemp;

            int length;
            int startIndex;
            int endIndex;
            string result;


            // Declaração da Lista com todas as start + end strings que configurarão a parte editada do xmlText

            List<string> startStringList = new List<string>();
            List<string> endStringList = new List<string>();


            // Atribuição de valores à Lista

            // SWML
            startStringList.Add(ConfigurationManager.AppSettings["SWML_string_de_inicio"]);
            endStringList.Add(ConfigurationManager.AppSettings["SWML_string_de_fim"]);

            // FpML
            startStringList.Add(ConfigurationManager.AppSettings["FpML_string_de_inicio"]);
            endStringList.Add(ConfigurationManager.AppSettings["FpML_string_de_fim"]);


            // Coletando os caminhos para os arquivos XML

            xmlPaths = Directory.EnumerateFiles(ConfigurationManager.AppSettings["caminho_pasta_xml_markit_processando"]).ToList();

            // Leitura dos arquivos XML

            foreach (string xmlPath in xmlPaths)
            {
                try
                {
                    // Ler o arquivo XML e popular uma string temporária

                    xmlTextTemp = File.ReadAllText(xmlPath);


                    // Modificar o XML lido na string temporária para que o parseador funcione corretamente
                    // obs: foram retirados os attributes do Root e do FpML nesse caso, diretamente no texto (os attributes "version", "xmlns", etc estavam dando algum problema)

                    for (int i = 0; i < startStringList.Count; i++)
                    {
                        // Retirando todas as repetições de cada uma das startStrings contidas na startStringList

                        int startIndexSearch = 0;
                        while (true)
                        {
                            // Coletando os parâmetros necessários

                            startIndex = xmlTextTemp.IndexOf(startStringList[i], startIndexSearch);
                            if (startIndex == -1)
                                break;
                            startIndex += startStringList[i].Length;
                            
                            endIndex = xmlTextTemp.IndexOf(endStringList[i], startIndex);
                            if (endIndex == -1)
                                break;

                            length = endIndex - startIndex;


                            // Editando o xmlTextTemp -- Removendo tudo que está entre o startString e o endString atual
                            
                            result = xmlTextTemp.Substring(startIndex, length);
                            
                            xmlTextTemp = xmlTextTemp.Replace(result, "");

                            
                            // Atualizando o valor do index de procura inicial do próximo loop
                            
                            startIndexSearch = startIndex;
                        }
                    }


                    // Adicionando o texto já corretamente modificado

                    xmlTexts.Add(xmlTextTemp);
                }
                catch (Exception e)
                {
                    throw e;
                }
            }

            return xmlTexts;
        }
    }
}

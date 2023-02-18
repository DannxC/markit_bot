using System;
using System.Collections.Generic;
using System.Configuration;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Markit.Utils
{
    public class InsereLogArquivo
    {
        public static void InsereLogMetadados(String metadados)
        {

            //Recupera o caminho atual da solução e adiciona o log.txt
            String caminho = ConfigurationManager.AppSettings["diretorioMetadados"] + "\\" + "Log_Metadados - " + String.Format("{0:yyyyMMdd_HHmmssff}", DateTime.Now) + ".txt";

            //Define cabeçalho
            String cabecalho = "/******************************************************************************/"
                               + "\r\n     Data-Hora Log: " + DateTime.Now.ToString()
                               + "\r\n/******************************************************************************/";

            //Se o log nao existir cria o arquivo
            //Caso exista insere log ao final do arquivo
            using (var fileStream = new FileStream(caminho, FileMode.Create))
            using (var fluxoTexto = new StreamWriter(fileStream))
            {
                //Insere o cabeçalho
                fluxoTexto.WriteLine(cabecalho);
                fluxoTexto.WriteLine("");

                //Insere os dados do console
                fluxoTexto.WriteLine("/************ Dados do console ***************/");
                fluxoTexto.WriteLine(metadados);
                fluxoTexto.WriteLine("");

                fluxoTexto.Close();
            }

        }//InsereLogMetadados
    }
}

using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;


namespace Markit.Utils
{
    public class LimpadorLog
    {
        // Limpa o Log salvo a "diasCorte" atrás
        public static void LimpaPastaLog(String dirLog, int diasCorte, DateTime diaContagemCorte, String sufixo)
        {
            try
            {
                List<String> listaArquivos = new List<String>();
                List<String> diasParaManterArquivos = new List<String>();

                if (Directory.Exists(dirLog))
                {
                    listaArquivos.AddRange(Directory.EnumerateFiles(dirLog));
                }

                int startIndex = dirLog.Length + sufixo.Length;
                int length = 8;

                for (int i = 0; i < diasCorte; i++)
                {
                    String diasParaNaoCortarFormatado = String.Format("{0:yyyyMMdd}", DateTime.Now.AddDays(-i));
                    diasParaManterArquivos.Add(diasParaNaoCortarFormatado);
                }

                var b = listaArquivos[0].Substring(startIndex, length);
                var a = listaArquivos.Where(x => !diasParaManterArquivos.Any(y => x.Substring(startIndex, length) == y));
                List <String> listaArquivosParaSeremDeletados = listaArquivos.Where(x => !diasParaManterArquivos.Any(y => x.Substring(startIndex, length) == y)).ToList();                 // Check if file exists with its full path    

                if (listaArquivosParaSeremDeletados.Count >= 1)
                {
                    foreach (String arquivo in listaArquivosParaSeremDeletados)
                    {
                        File.Delete(arquivo);
                    }
                }
            }
            catch (Exception e)
            {

            }
        }
    }
}
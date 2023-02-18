using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Markit.Utils
{
    public class MoveArquivos
    {
        public static void MoveArquivo(string entrada, string saida)
        {
            List<string> listaArquivos = Directory.EnumerateFiles(entrada).ToList();
            
            foreach (string arquivo in listaArquivos)
            {
                FileInfo fi = new FileInfo(arquivo);

                // Deleta o arquivo com o mesmo nome daquele sendo movido, na pasta destino.
                if (File.Exists(saida + "\\" + fi.Name))
                {
                    File.Delete(saida + "\\" + fi.Name);
                }

                Directory.Move(entrada + "\\" + fi.Name, saida + "\\" + fi.Name);
            }
        }
    }
}

using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data;
using System.Reflection;
using Entidades;

namespace Markit.Utils
{
    public class ConvertDataTable
    {
        public static DataTable CriaTabelaExecucoes(int codInstcIpc, List<XMLDadosLinearizados> xmlDadosLista, ExtensaoTabela extensaoTabela)
        {

            // Define os types que serão utilizados

            Type typeXMLDados = typeof(Entidades.XMLDadosLinearizados);
            Type typeExtensaoTabela = typeof(Entidades.ExtensaoTabela);


            // Define as propriedades dos objetos que serão utilizados

            PropertyInfo[] propriedadesXMLDados = typeXMLDados.GetProperties();
            PropertyInfo[] propriedadesExtensaoTabela = typeExtensaoTabela.GetProperties();


            // Objeto genérico expansível que conterá todas as colunas necessárias

            int numeroColunas = 1 + propriedadesXMLDados.Length + propriedadesExtensaoTabela.Length;        // codInstcIpc + xmlDados + ExtensãoTabela
            object[] values = new object[numeroColunas];


            // Cria a DataTable

            DataTable dataTable = new DataTable();
            dataTable.TableName = typeof(XMLDadosLinearizados).FullName;

            dataTable.Columns.Add(nameof(codInstcIpc), typeof(int));
            dataTable.Columns.AddRange(DataTableHelper(propriedadesXMLDados).ToArray());
            dataTable.Columns.AddRange(DataTableHelper(propriedadesExtensaoTabela).ToArray());
            
            
            // Inserir linhas na tabela

            int numeroLinhas = xmlDadosLista.Count;
            for(int i = 0; i < numeroLinhas; i++)
            {
                /* Valor do código da importação */

                values[0] = codInstcIpc;


                /* Valores do XML */

                int j = 0;
                foreach (var prop in propriedadesXMLDados)
                {
                    values[j + 1] = prop.GetValue(xmlDadosLista[i]);
                    j++;
                }


                /* Valores da extensão da Tabela */

                values[numeroColunas - 3] = extensaoTabela.ind_sit;
                values[numeroColunas - 2] = extensaoTabela.dat_cdm;
                values[numeroColunas - 1] = extensaoTabela.usr_cdm;


                // Insere nova linha

                dataTable.Rows.Add(values);
            }

            return dataTable;
        }

        public static List<DataColumn> DataTableHelper(PropertyInfo[] propriedadesTabela)
        {
            List<DataColumn> dataColumnList = new List<DataColumn>();

            foreach (PropertyInfo info in propriedadesTabela)
            {
                if (!(info.PropertyType != typeof(string) && typeof(IEnumerable).IsAssignableFrom(info.PropertyType) == true))
                {
                    dataColumnList.Add(new DataColumn(info.Name, Nullable.GetUnderlyingType(info.PropertyType) ?? info.PropertyType));
                }
            }

            return dataColumnList;
        }
    }
}

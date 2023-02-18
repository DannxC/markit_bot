using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data;
using Entidades;
using Markit.Utils;
using Markit.DAL;

namespace Markit.BLL
{
    public class BulkInsertBusiness
    {
        public void BulkInsert(int codInstcIpc, List<XMLDadosLinearizados> xmlDadosLista)
        {
            try
            {
                // Criar e popular DataTable local antes de upar os dados no bd

                DataTable dataTable = new DataTable();

                dataTable = ConvertDataTable.CriaTabelaExecucoes(codInstcIpc, xmlDadosLista, new ExtensaoTabela());


                // Inserir os dados no bd

                BulkInsertRepository insereDadosRep = new BulkInsertRepository();

                insereDadosRep.BulkInsert(codInstcIpc, dataTable);
            }
            catch(Exception e)
            {
                throw e;
            }
        }
    }
}

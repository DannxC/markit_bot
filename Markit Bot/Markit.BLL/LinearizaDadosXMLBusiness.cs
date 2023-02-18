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
    public class LinearizaDadosXMLBusiness
    {
        public List<XMLDadosLinearizados> LinearizaDadosXML(List<SWML> xmlObjects)
        {
            // Declara uma lista de objetos que contém dados úteis para a inserção na tabela

            List<XMLDadosLinearizados> xmlDadosLista = new List<XMLDadosLinearizados>();


            // Separar os dados requisitados para a confecção da tabela de dados

            foreach (SWML xmlObject in xmlObjects)
            {
                xmlDadosLista.Add(LinearizadorXMLObj.Linearizador(xmlObject));
            }

            return xmlDadosLista;
        }
    }
}

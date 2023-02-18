using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Entidades;
using Markit.Utils;
using Markit.DAL;

namespace Markit.BLL
{
    public class ConversorBusiness
    {
        // Parseia todos os textos em xml para objetos

        public List<SWML> ConverterXmlParaObjeto(List<string> xmlTexts, List<string> xmlTextsComErro)
        {
            List<SWML> xmlObjects = new List<SWML>();

            foreach (string xmlText in xmlTexts)
            {
                try 
                { 
                    xmlObjects.Add(ParseadorXML.xmlParaObjetoGenerico<SWML>(xmlText));
                }
                catch(Exception e)
                {
                    xmlTextsComErro.Add(xmlText);
                    throw e;
                }
            }

            return xmlObjects;
        }
    }
}

using System;
using System.IO;
using System.Xml.Serialization;

namespace Markit.Utils
{
    public class ParseadorXML
    {
        // Converte XML para Objeto genérico

        // T is the type of the Root of the XML object
        // xml is the string that contains all the XML text

        public static T xmlParaObjetoGenerico<T>(String xml)
        {
            // Serializa o XML

            XmlSerializer serializer = new XmlSerializer(typeof(T));


            // Desserializa o XML diretamente em um objeto, já com as tipagens corretas.

            T objeto = (T)serializer.Deserialize(new StringReader(xml));

            return objeto;
        }
    }
}

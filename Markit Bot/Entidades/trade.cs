using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Xml.Serialization;

namespace Entidades
{
    [Serializable]
    public class trade        // Father: FpML
    {
        // Declarando filhos como Attributes e como XmlElements

        [XmlElement("tradeHeader")]
        public tradeHeader? tradeHeader { get; set; }

        [XmlElement("swap")]
        public swap? swap { get; set; }

        [XmlElement("documentation")]
        public documentation? documentation { get; set; }

        // Constructor

        public trade()
        {
            tradeHeader = new tradeHeader();
            swap = new swap();
            documentation = new documentation();
        }
    }
}

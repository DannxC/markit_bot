using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Xml.Serialization;

namespace Entidades
{
    [Serializable]
    public class swExtendedTradeDetails       // Father: swStructuredTradeDetails
    {
        // Declarando filhos como Attributes e como XmlElements

        [XmlElement("swTradeHeader")]
        public swTradeHeader? swTradeHeader { get; set; }

        // Constructor

        public swExtendedTradeDetails()
        {
            swTradeHeader = new swTradeHeader();
        }
    }
}

using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Xml.Serialization;

namespace Entidades
{
    [Serializable]
    public class swTradeHeader       // Father: swExtendedTradeDetails
    {
        // Declarando filhos como Attributes e como XmlElements

        [XmlElement("swClientClearing")]
        public bool? swClientClearing { get; set; }     // Leaf

        [XmlElement("swClearingHouse")]
        public swClearingHouse? swClearingHouse { get; set; }

        // Constructor

        public swTradeHeader()
        {
            swClearingHouse = new swClearingHouse();
        }
    }
}

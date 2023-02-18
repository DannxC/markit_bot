using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Xml.Serialization;

namespace Entidades
{
    [Serializable]
    public class swNegotiationParties      // Father: swHeader
    {
        // Declarando filhos como Attributes e como XmlElements

        [XmlElement("swTrader")]
        public List<swTrader>? swTrader { get; set; }

        // Constructor
        public swNegotiationParties()
        {
            swTrader = new List<swTrader>();
        }
    }
}

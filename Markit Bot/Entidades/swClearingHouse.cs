using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Xml.Serialization;

namespace Entidades
{
    [Serializable]
    public class swClearingHouse        // Father: swTradeHeader
    {
        // Declarando filhos como Attributes e como XmlElements

        [XmlElement("partyId")]
        public string? partyId { get; set; }     // Leaf
    }
}

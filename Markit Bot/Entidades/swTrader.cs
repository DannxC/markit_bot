using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Xml.Serialization;

namespace Entidades
{
    [Serializable]
    public class swTrader      // Father: swNegotiationParties
    {
        // Attributes do Node

        [XmlAttribute("id")]
        public string? id { get; set; }
       
        
        // Declarando filhos como Attributes e como XmlElements

        [XmlElement("swParticipantId")]
        public string? swParticipantId { get; set; }        // Leaf
    }
}

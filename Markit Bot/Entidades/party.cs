using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Xml.Serialization;

namespace Entidades
{
    [Serializable]
    public class party        // Father: FpML
    {
        // Attributes do Node

        [XmlAttribute("id")]
        public string? id { get; set; }

        
        // Declarando filhos como Attributes e como XmlElements

        [XmlElement("partyId")]
        public string? partyId { get; set; }      // Leaf

        [XmlElement("partyName")]
        public string? partyName { get; set; }     // Leaf
    }
}

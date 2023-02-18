using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Xml.Serialization;

namespace Entidades
{
    [Serializable]
    public class swStructuredTradeDetails       // Father: SWML
    {
        // Declarando filhos como Attributes e como XmlElements

        [XmlElement("swProductType")]
        public string? swProductType { get; set; }      // Leaf

        [XmlElement("swTemplateName")]
        public string? swTemplateName { get; set; }     // Leaf

        [XmlElement("FpML")]
        public FpML? FpML { get; set; }

        [XmlElement("swExtendedTradeDetails")]
        public swExtendedTradeDetails? swExtendedTradeDetails { get; set; }

        // Constructor

        public swStructuredTradeDetails()
        {
            FpML = new FpML();
            swExtendedTradeDetails = new swExtendedTradeDetails();
        }
    }
}

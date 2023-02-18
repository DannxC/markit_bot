using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Xml.Serialization;

namespace Entidades
{
    [Serializable]
    public class FpML       // Father: swStructuredTradeDetails
    {
        // Declarando filhos como Attributes e como XmlElements

        [XmlElement("trade")]
        public trade? trade { get; set; }

        // Declarando filhos como Attributes e como XmlElements

        [XmlElement("party")]
        public List<party>? party { get; set; }


        // Constructor

        public FpML()
        {
            trade = new trade();
            party = new List<party>();
        }
    }
}

using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Xml.Serialization;

namespace Entidades
{
    [XmlRoot("SWML")]
    [Serializable]
    public class SWML       // Root
    {
        // Declarando filhos como Attributes e como XmlElement

        [XmlElement("swHeader")]
        public swHeader? swHeader { get; set; }
         
        [XmlElement("swStructuredTradeDetails")]
        public swStructuredTradeDetails swStructuredTradeDetails { get; set; }
        
        // [XmlElement("swNegotiation")]
        // public swNegotiation swNegotiation { get; set; }
        //
        //[XmlElement("swPrivateData")]
        //public swPrivateData swPrivateData { get; set; }

        // Constructor
        public SWML()
        {
            swHeader = new swHeader();

            swStructuredTradeDetails = new swStructuredTradeDetails();
        //
        //    swNegotiation = new swNegotiation();
        //
        //    swPrivateData = new swPrivateData();
        }
    }
}

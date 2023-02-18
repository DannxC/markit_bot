using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Xml.Serialization;

namespace Entidades
{
    [Serializable]
    public class swHeader      // Father: SWML
    {
        // Declarando filhos como Attributes e como XmlElements

        [XmlElement("tradeId")]
        public long? tradeId { get; set; }       // Leaf

        [XmlElement("swTradeVersionId")]
        public long? swTradeVersionId { get; set; }      // Leaf

        [XmlElement("swTradeVersionTimestamp")]
        public DateTime? swTradeVersionTimestamp { get; set; }      // Leaf

        [XmlElement("swTradeStatus")]
        public string? swTradeStatus { get; set; }      // Leaf

        [XmlElement("swNegotiationParties")]
        public swNegotiationParties? swNegotiationParties { get; set; }

        // Constructor

        public swHeader()
        {
            swNegotiationParties = new swNegotiationParties();
        }
    }
}

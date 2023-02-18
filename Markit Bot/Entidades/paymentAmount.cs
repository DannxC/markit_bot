using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Xml.Serialization;

namespace Entidades
{
    [Serializable]
    public class paymentAmount        // Father: additionalPayment
    {
        // Declarando filhos como Attributes e como XmlElements

        [XmlElement("currency")]
        public string? currency { get; set; }       // Leaf

        [XmlElement("amount")]
        public decimal? amount { get; set; }        // Leaf
    }
}

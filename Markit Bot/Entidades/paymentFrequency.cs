using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Xml.Serialization;

namespace Entidades
{
    [Serializable]
    public class paymentFrequency        // Father: paymentDates
    {
        // Declarando filhos como Attributes e como XmlElements

        [XmlElement("periodMultiplier")]
        public long? periodMultiplier { get; set; }      // Leaf

        [XmlElement("period")]
        public string? period { get; set; }     // Leaf
    }
}

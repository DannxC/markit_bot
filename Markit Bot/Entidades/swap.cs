using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Xml.Serialization;

namespace Entidades
{
    [Serializable]
    public class swap        // Father: trade
    {
        // Declarando filhos como Attributes e como XmlElements

        [XmlElement("swapStream")]
        public List<swapStream>? swapStream { get; set; }

        [XmlElement("additionalPayment")]
        public additionalPayment? additionalPayment { get; set; }


        // Constructor

        public swap()
        {
            swapStream = new List<swapStream>();
            additionalPayment = new additionalPayment();
        }
    }
}

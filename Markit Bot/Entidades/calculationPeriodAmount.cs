using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Xml.Serialization;

namespace Entidades
{
    [Serializable]
    public class calculationPeriodAmount        // Father: swapStream
    {
        // Declarando filhos como Attributes e como XmlElements

        [XmlElement("calculation")]
        public calculation? calculation { get; set; }

        // Constructor

        public calculationPeriodAmount()
        {
            calculation = new calculation();
        }
    }
}

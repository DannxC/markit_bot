using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Xml.Serialization;

namespace Entidades
{
    [Serializable]
    public class spreadSchedule        // Father: floatingRateCalculation
    {
        // Declarando filhos como Attributes e como XmlElements

        [XmlElement("initialValue")]
        public double? initialValue { get; set; }       // Leaf
    }
}

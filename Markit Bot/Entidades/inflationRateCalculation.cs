using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Xml.Serialization;

namespace Entidades
{
    [Serializable]
    public class inflationRateCalculation        // Father: floatingRateCalculation
    {
        // Declarando filhos como Attributes e como XmlElements

        [XmlElement("floatingRateIndex")]
        public string? floatingRateIndex { get; set; }

        [XmlElement("inflationLag")]
        public inflationLag? inflationLag { get; set; }

        [XmlElement("indexSource")]
        public indexSource? indexSource { get; set; }       // Leaf

        [XmlElement("interpolationMethod")]
        public string? interpolationMethod { get; set; }        // Leaf

        [XmlElement("initialIndexLevel")]
        public double? initialIndexLevel { get; set; }      // Leaf

        [XmlElement("spreadSchedule")]
        public spreadSchedule? spreadSchedule { get; set; }

        // Constructor

        public inflationRateCalculation()
        {
            inflationLag = new inflationLag();
            indexSource = new indexSource();
        }
    }
}

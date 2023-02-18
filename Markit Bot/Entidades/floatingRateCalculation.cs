using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Xml.Serialization;

namespace Entidades
{
    [Serializable]
    public class floatingRateCalculation        // Father: calculation
    {
        // Declarando filhos como Attributes e como XmlElements

        [XmlElement("floatingRateIndex")]
        public string? floatingRateIndex { get; set; }      // Leaf

        [XmlElement("indexTenor")]
        public indexTenor? indexTenor { get; set; }

        [XmlElement("spreadSchedule")]
        public spreadSchedule? spreadSchedule { get; set; }

        // Constructor

        public floatingRateCalculation()
        {
            indexTenor = new indexTenor();
            spreadSchedule = new spreadSchedule();
        }
    }
}

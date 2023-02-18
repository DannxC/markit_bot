using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Xml.Serialization;

namespace Entidades
{
    [Serializable]
    public class dateAdjustments        // Father1: effectiveDate -- Father2: terminationDate -- Father3: paymentDate
    {
        // Declarando filhos como Attributes e como XmlElements

        [XmlElement("businessDayConvention")]
        public string? businessDayConvention { get; set; }      // Leaf

        [XmlElement("businessCenters")]
        public businessCenters? businessCenters { get; set; }
    }
}

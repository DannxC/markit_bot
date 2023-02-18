using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Xml.Serialization;

namespace Entidades
{
    [Serializable]
    public class notionalStepSchedule        // Father: notionalSchedule
    {
        // Declarando filhos como Attributes e como XmlElements

        [XmlElement("initialValue")]
        public long? initialValue { get; set; }      // Leaf

        [XmlElement("currency")]
        public string? currency { get; set; }       // Leaf
    }
}

using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Xml.Serialization;

namespace Entidades
{
    [Serializable]
    public class masterAgreement        // Father: documentation
    {
        // Declarando filhos como Attributes e como XmlElements

        [XmlElement("masterAgreementType")]
        public string? masterAgreementType { get; set; }        // Leaf

        // Constructor
    }
}

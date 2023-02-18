using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Xml.Serialization;

namespace Entidades
{
    [Serializable]
    public class documentation        // Father: trade
    {
        // Declarando filhos como Attributes e como XmlElements

        [XmlElement("masterAgreement")]
        public masterAgreement? masterAgreement { get; set; }

        [XmlElement("contractualDefinitions")]
        public List<string>? contractualDefinitions { get; set; }       // Leaf


        // Constructor
        public documentation()
        {
            masterAgreement = new masterAgreement();
            contractualDefinitions = new List<string>();
        }
    }
}

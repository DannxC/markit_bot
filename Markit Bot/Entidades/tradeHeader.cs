using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Xml.Serialization;

namespace Entidades
{
    [Serializable]
    public class tradeHeader        // Father: trade
    {
        // Declarando filhos como Attributes e como XmlElements

        [XmlElement("tradeDate")]
        public DateTime? tradeDate { get; set; }        // Leaf
    }
}

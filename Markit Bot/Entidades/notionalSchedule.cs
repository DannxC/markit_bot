using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Xml.Serialization;

namespace Entidades
{
    [Serializable]
    public class notionalSchedule        // Father: calculation
    {
        // Declarando filhos como Attributes e como XmlElements

        [XmlElement("notionalStepSchedule")]
        public notionalStepSchedule? notionalStepSchedule { get; set; }


        // Constructor
        public notionalSchedule()
        {
            notionalStepSchedule = new notionalStepSchedule();
        }
    }
}

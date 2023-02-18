﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Xml.Serialization;

namespace Entidades
{
    [Serializable]
    public class fixingDates     // Father: resetDates
    {
        // Declarando filhos como Attributes e como XmlElements
        
        [XmlElement("periodMultiplier")]
        public long? periodMultiplier { get; set; }      // Leaf

        [XmlElement("period")]
        public string? period { get; set; }      // Leaf

        [XmlElement("businessDayConvention")]
        public string? businessDayConvention { get; set; }      // Leaf

        [XmlElement("businessCenters")]
        public businessCenters? businessCenters { get; set; }

        // Constructor
        public fixingDates()
        {
            businessCenters = new businessCenters();
        }

    }
}
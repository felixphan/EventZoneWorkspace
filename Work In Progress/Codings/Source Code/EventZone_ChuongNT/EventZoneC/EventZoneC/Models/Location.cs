//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated from a template.
//
//     Manual changes to this file may cause unexpected behavior in your application.
//     Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace EventZoneC.Models
{
    using System;
    using System.Collections.Generic;
    
    public partial class Location
    {
        public Location()
        {
            this.EventPlaces = new HashSet<EventPlace>();
        }
    
        public long LocationID { get; set; }
        public double Longitude { get; set; }
        public double Lagitude { get; set; }
        public string LocationName { get; set; }
    
        public virtual ICollection<EventPlace> EventPlaces { get; set; }
    }
}

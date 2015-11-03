﻿using System;
using System.Security.Cryptography;
using System.Text;
namespace EventZone.Helpers
{
    public class EventZoneUtility:SingletonBase<EventZoneUtility>
    {
        private EventZoneUtility(){}
        public string HashPassword(string password)
        {
            // byte array representation of that string
            byte[] encodedPassword = new UTF8Encoding().GetBytes(password);

            // need MD5 to calculate the hash
            byte[] hash = ((HashAlgorithm)CryptoConfig.CreateFromName("MD5")).ComputeHash(encodedPassword);

            // string representation (similar to UNIX format)
            string encoded = BitConverter.ToString(hash)
                // without dashes
               .Replace("-", string.Empty)
                // make lowercase
               .ToLower();
            return encoded;
        }
    }
}
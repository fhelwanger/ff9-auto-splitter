using System;

namespace FF9Extractor
{
    public class BitUtil
    {
        public static uint ReadBits(uint input, ref byte startBit, byte numBits)
        {
            uint num1 = (uint)MathF.Pow(2f, (float)numBits) - 1U;
            uint num2 = input >> (int)startBit & num1;
            startBit += numBits;
            return num2;
        }
    }
}

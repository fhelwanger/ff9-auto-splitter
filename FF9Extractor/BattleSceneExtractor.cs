using System;
using System.IO;

namespace FF9Extractor
{
    public class BattleSceneExtractor
    {
        public BattleScene Extract(string filePath)
        {
            var battleScene = new BattleScene();

            using (var binaryReader = new BinaryReader(new FileStream(filePath, FileMode.Open)))
            {
                battleScene.Header = new Header();

                battleScene.Header.Ver = binaryReader.ReadByte();
                battleScene.Header.PatCount = binaryReader.ReadByte();
                battleScene.Header.TypCount = binaryReader.ReadByte();
                battleScene.Header.AtkCount = binaryReader.ReadByte();
                battleScene.Header.Flags = binaryReader.ReadUInt16();
                battleScene.Header.Pad1 = binaryReader.ReadInt16();

                battleScene.PatAddr = new Pat[battleScene.Header.PatCount];
                battleScene.MonAddr = new MonParm[battleScene.Header.TypCount];
                battleScene.Atk = new AAData[battleScene.Header.AtkCount];

                for (var i = 0; i < battleScene.Header.PatCount; i++)
                {
                    var pat = battleScene.PatAddr[i] = new Pat();

                    pat.Rate = binaryReader.ReadByte();
                    pat.MonCount = binaryReader.ReadByte();
                    pat.Camera = binaryReader.ReadByte();
                    pat.Pad0 = binaryReader.ReadByte();
                    pat.AP = binaryReader.ReadUInt32();

                    for (int j = 0; j < 4; j++)
                    {
                        var put = pat.Put[j] = new Put();

                        put.TypeNo = binaryReader.ReadByte();
                        put.Flags = binaryReader.ReadByte();
                        put.Pease = binaryReader.ReadByte();
                        put.Pad = binaryReader.ReadByte();
                        put.Xpos = binaryReader.ReadInt16();
                        put.Ypos = binaryReader.ReadInt16();
                        put.Zpos = binaryReader.ReadInt16();
                        put.Rot = binaryReader.ReadInt16();
                    }
                }

                for (var i = 0; i < battleScene.Header.TypCount; i++)
                {
                    var monParm = battleScene.MonAddr[i] = new MonParm();

                    for (int j = 0; j < 3; j++)
                        monParm.Status[j] = binaryReader.ReadUInt32();

                    monParm.MaxHP = binaryReader.ReadUInt16();
                    monParm.MaxMP = binaryReader.ReadUInt16();
                    monParm.WinGil = binaryReader.ReadUInt16();
                    monParm.WinExp = binaryReader.ReadUInt16();

                    for (int index2 = 0; index2 < 4; ++index2)
                        monParm.WinItems[index2] = binaryReader.ReadByte();

                    for (int index2 = 0; index2 < 4; ++index2)
                        monParm.StealItems[index2] = binaryReader.ReadByte();

                    monParm.Radius = binaryReader.ReadUInt16();
                    monParm.Geo = binaryReader.ReadUInt16();

                    for (int index2 = 0; index2 < 6; ++index2)
                        monParm.Mot[index2] = binaryReader.ReadUInt16();

                    for (int index2 = 0; index2 < 2; ++index2)
                        monParm.Mesh[index2] = binaryReader.ReadUInt16();

                    monParm.Flags = binaryReader.ReadUInt16();
                    monParm.AP = binaryReader.ReadUInt16();

                    var element = monParm.Element = new Element();
                    element.Dex = binaryReader.ReadByte();
                    element.Str = binaryReader.ReadByte();
                    element.Mgc = binaryReader.ReadByte();
                    element.Wpr = binaryReader.ReadByte();
                    element.Pad = binaryReader.ReadByte();
                    element.Trans = binaryReader.ReadByte();
                    element.CurCapa = binaryReader.ReadByte();
                    element.MaxCapa = binaryReader.ReadByte();

                    for (int index2 = 0; index2 < 4; ++index2)
                        monParm.Attr[index2] = binaryReader.ReadByte();

                    monParm.Level = binaryReader.ReadByte();
                    monParm.Category = binaryReader.ReadByte();
                    monParm.HitRate = binaryReader.ReadByte();
                    monParm.P_DP = binaryReader.ReadByte();
                    monParm.P_AV = binaryReader.ReadByte();
                    monParm.M_DP = binaryReader.ReadByte();
                    monParm.M_AV = binaryReader.ReadByte();
                    monParm.Blue = binaryReader.ReadByte();

                    for (int index2 = 0; index2 < 4; ++index2)
                        monParm.Bone[index2] = binaryReader.ReadByte();

                    monParm.DieSfx = binaryReader.ReadUInt16();
                    monParm.Konran = binaryReader.ReadByte();
                    monParm.MesCnt = binaryReader.ReadByte();

                    for (int index2 = 0; index2 < 6; ++index2)
                        monParm.IconBone[index2] = binaryReader.ReadByte();

                    for (int index2 = 0; index2 < 6; ++index2)
                        monParm.IconY[index2] = binaryReader.ReadSByte();

                    for (int index2 = 0; index2 < 6; ++index2)
                        monParm.IconZ[index2] = binaryReader.ReadSByte();

                    monParm.StartSfx = binaryReader.ReadUInt16();
                    monParm.ShadowX = binaryReader.ReadUInt16();
                    monParm.ShadowZ = binaryReader.ReadUInt16();
                    monParm.ShadowBone = binaryReader.ReadByte();
                    monParm.Card = binaryReader.ReadByte();
                    monParm.ShadowOfsX = binaryReader.ReadInt16();
                    monParm.ShadowOfsZ = binaryReader.ReadInt16();
                    monParm.ShadowBone2 = binaryReader.ReadByte();
                    monParm.Pad0 = binaryReader.ReadByte();
                    monParm.Pad1 = binaryReader.ReadUInt16();
                    monParm.Pad2 = binaryReader.ReadUInt16();
                }

                for (var i = 0; i < battleScene.Header.AtkCount; i++)
                {
                    var aaData = battleScene.Atk[i] = new AAData();

                    uint input = binaryReader.ReadUInt32();
                    byte startBit = 0;

                    var cmdInfo = aaData.Info = new CmdInfo();

                    cmdInfo.Cursor = (byte)BitUtil.ReadBits(input, ref startBit, (byte)4);
                    cmdInfo.DefCur = (byte)BitUtil.ReadBits(input, ref startBit, (byte)1);
                    cmdInfo.SubWin = (byte)BitUtil.ReadBits(input, ref startBit, (byte)3);
                    cmdInfo.VfxNo = (short)BitUtil.ReadBits(input, ref startBit, (byte)9);
                    cmdInfo.SfxNo = (short)BitUtil.ReadBits(input, ref startBit, (byte)12);
                    cmdInfo.Dead = (byte)BitUtil.ReadBits(input, ref startBit, (byte)1);
                    cmdInfo.DefCam = (byte)BitUtil.ReadBits(input, ref startBit, (byte)1);
                    cmdInfo.DefDead = (byte)BitUtil.ReadBits(input, ref startBit, (byte)1);

                    var btlRef = aaData.Ref = new BtlRef();

                    btlRef.ProgNo = binaryReader.ReadByte();
                    btlRef.Power = binaryReader.ReadByte();
                    btlRef.Attr = binaryReader.ReadByte();
                    btlRef.Rate = binaryReader.ReadByte();

                    aaData.Category = binaryReader.ReadByte();
                    aaData.AddNo = binaryReader.ReadByte();
                    aaData.MP = binaryReader.ReadByte();
                    aaData.Type = binaryReader.ReadByte();
                    aaData.Vfx2 = binaryReader.ReadUInt16();
                    aaData.Name = binaryReader.ReadUInt16().ToString();
                }

                return battleScene;
            }
        }

        public class BattleScene
        {
            public Header Header { get; set; }
            public Pat[] PatAddr { get; set; }
            public MonParm[] MonAddr { get; set; }
            public AAData[] Atk { get; set; }

            public void Summary()
            {
                Console.WriteLine("Patterns: {0}", Header.PatCount);

                for (var i = 0; i < Header.PatCount; i++)
                {
                    Console.WriteLine("Pattern[{0}].AP = {1}", i, PatAddr[i].AP);
                    Console.WriteLine("Pattern[{0}].Rate = {1}", i, PatAddr[i].Rate);
                    Console.WriteLine("Pattern[{0}].MonCount = {1}", i, PatAddr[i].MonCount);

                    for (var j = 0; j < PatAddr[i].MonCount; j++)
                    {
                        Console.WriteLine("Pattern[{0}].Put[{1}].TypeNo = {2}", i, j, PatAddr[i].Put[j].TypeNo);
                    }
                }

                Console.WriteLine();

                Console.WriteLine("Monsters: {0}", Header.TypCount);

                for (var i = 0; i < Header.TypCount; i++)
                {
                    Console.WriteLine("Monster[{0}].MaxHP = {1}", i, MonAddr[i].MaxHP);
                    Console.WriteLine("Monster[{0}].MaxMP = {1}", i, MonAddr[i].MaxMP);
                }

                Console.WriteLine();
            }
        }

        public class Header
        {
            public byte Ver { get; set; }
            public byte PatCount { get; set; }
            public byte TypCount { get; set; }
            public byte AtkCount { get; set; }
            public ushort Flags { get; set; }
            public short Pad1 { get; set; }
        }

        public class Pat
        {
            public byte Rate { get; set; }
            public byte MonCount { get; set; }
            public byte Camera { get; set; }
            public byte Pad0 { get; set; }
            public uint AP { get; set; }
            public Put[] Put { get; set; } = new Put[4];
        }

        public class Put
        {
            public byte TypeNo { get; set; }
            public byte Flags { get; set; }
            public byte Pease { get; set; }
            public byte Pad { get; set; }
            public short Xpos { get; set; }
            public short Ypos { get; set; }
            public short Zpos { get; set; }
            public short Rot { get; set; }
        }

        public class MonParm
        {
            public uint[] Status { get; set; } = new uint[3];
            public ushort MaxHP { get; set; }
            public ushort MaxMP { get; set; }
            public ushort WinGil { get; set; }
            public ushort WinExp { get; set; }
            public byte[] WinItems { get; set; } = new byte[4];
            public byte[] StealItems { get; set; } = new byte[4];
            public ushort Radius { get; set; }
            public ushort Geo { get; set; }
            public ushort[] Mot { get; set; } = new ushort[6];
            public ushort[] Mesh { get; set; } = new ushort[2];
            public ushort Flags { get; set; }
            public ushort AP { get; set; }
            public Element Element { get; set; }
            public byte[] Attr { get; set; } = new byte[4];
            public byte Level { get; set; }
            public byte Category { get; set; }
            public byte HitRate { get; set; }
            public byte P_DP { get; set; }
            public byte P_AV { get; set; }
            public byte M_DP { get; set; }
            public byte M_AV { get; set; }
            public byte Blue { get; set; }
            public byte[] Bone { get; set; } = new byte[4];
            public ushort DieSfx { get; set; }
            public byte Konran { get; set; }
            public byte MesCnt { get; set; }
            public byte[] IconBone { get; set; } = new byte[6];
            public sbyte[] IconY { get; set; } = new sbyte[6];
            public sbyte[] IconZ { get; set; } = new sbyte[6];
            public ushort StartSfx { get; set; }
            public ushort ShadowX { get; set; }
            public ushort ShadowZ { get; set; }
            public byte ShadowBone { get; set; }
            public byte Card { get; set; }
            public short ShadowOfsX { get; set; }
            public short ShadowOfsZ { get; set; }
            public byte ShadowBone2 { get; set; }
            public byte Pad0 { get; set; }
            public ushort Pad1 { get; set; }
            public ushort Pad2 { get; set; }
        }

        public class Element
        {
            public byte Dex { get; set; }
            public byte Str { get; set; }
            public byte Mgc { get; set; }
            public byte Wpr { get; set; }
            public byte Pad { get; set; }
            public byte Trans { get; set; }
            public byte CurCapa { get; set; }
            public byte MaxCapa { get; set; }
        }

        public class AAData
        {
            public CmdInfo Info { get; set; }
            public BtlRef Ref { get; set; }
            public byte Category { get; set; }
            public byte AddNo { get; set; }
            public byte MP { get; set; }
            public byte Type { get; set; }
            public ushort Vfx2 { get; set; }
            public string Name { get; set; }
        }

        public class BtlRef
        {
            public byte ProgNo { get; set; }
            public byte Power { get; set; }
            public byte Attr { get; set; }
            public byte Rate { get; set; }
        }

        public class CmdInfo
        {
            public byte Cursor { get; set; }
            public byte DefCur { get; set; }
            public byte SubWin { get; set; }
            public short VfxNo { get; set; }
            public short SfxNo { get; set; }
            public byte Dead { get; set; }
            public byte DefCam { get; set; }
            public byte DefDead { get; set; }
        }
    }
}

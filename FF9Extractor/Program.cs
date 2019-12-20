using System;
using System.IO;
using System.Linq;

namespace FF9Extractor
{
    class Program
    {
        static void Main(string[] args)
        {
            var filePath = args[0];
            var battleSceneExtractor = new BattleSceneExtractor();
            var battleScene = battleSceneExtractor.Extract(filePath);

            battleScene.Summary();
        }
    }
}

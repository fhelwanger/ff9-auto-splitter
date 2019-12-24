state("FF9")
{
    int sceneId: "FF9.exe", 0x0116FDC0, 0x8, 0x7A0, 0x748, 0x28, 0x10, 0x10, 0x5C;
    int sceneType: "FF9.exe", 0x0115BEA8, 0x48, 0x10, 0x98, 0x270, 0x10, 0x140; // Bundle = 0, Field = 1, World = 2, Battle = 3, Title = 4, QuadMist = 5, Pure = 6, Ending = 7, EndGame = 8, None = 9
    int battleId: "FF9.exe", 0x0115DDC8, 0xE0, 0x20, 0x10, 0x98, 0x7D0, 0x68, 0x7E0, 0x64;
    bool isRandomEncounter: "FF9.exe", 0x0108CD60, 0x8, 0x18, 0xE0, 0x0, 0x30, 0x208, 0x364;
    ushort necronHp: "FF9.exe", 0x011167F0, 0x50, 0x2A8, 0xC8, 0x120, 0xD0, 0x38, 0x40, 0x30, 0x10;
    string50 focusedElement: "FF9.exe", 0x01116790, 0x10, 0x0, 0x10, 0x58, 0x0;
    bool buttonPressed: "mono.dll", 0x002635B8, 0x0, 0x38, 0x100, 0xB8, 0x138;
}

startup
{
    vars.FindComponentByLeftText = (Func<string, dynamic>)(
        text => timer.Layout.Components.FirstOrDefault((dynamic x) => x.GetType().Name == "TextComponent" && x.Settings.Text1 == text)
    );

    vars.UpdateEncounterCounter = (Action<int>)(
        count =>
        {
            vars.encounters = count;

            var componentEncounters = vars.FindComponentByLeftText("Encounters:");

            if (componentEncounters != null)
            {
                componentEncounters.Settings.Text2 = vars.encounters.ToString();
            }
        }
    );

    vars.splits = new List<string>();
    vars.splitsOldSceneId = new Dictionary<string, int>();
    vars.splitsCurrentSceneId = new Dictionary<string, int>();
    vars.executedSplits = new List<string>();

    Action<string, string, string, int, int> AddSplit = (discId, splitId, splitDescription, oldSceneId, currentSceneId) => {
        splitId = discId + "." + splitId;

        vars.splits.Add(splitId);
        vars.splitsOldSceneId.Add(splitId, oldSceneId);
        vars.splitsCurrentSceneId.Add(splitId, currentSceneId);

        settings.Add(splitId, true, splitDescription, discId);
    };

    settings.Add("disc1", true, "Disc 1 Splits");
    AddSplit("disc1", "magemasher", "Mage Masher", 336, 50);
    AddSplit("disc1", "kingleo", "King Leo", 338, 63);
    AddSplit("disc1", "steiner1", "Steiner 1", 337, 58);
    AddSplit("disc1", "steiner2", "Steiner 2", 335, 67);
    AddSplit("disc1", "steiner3", "Steiner 3", 334, 60);
    AddSplit("disc1", "prisoncage", "Prison Cage", 301, 251);
    AddSplit("disc1", "baku", "Baku", 295, 202);
    AddSplit("disc1", "plantbrain", "Plant Brain", 303, 257);
    AddSplit("disc1", "evilforest", "Evil Forest Done", 259, 260);
    AddSplit("disc1", "sealion", "Sealion", 21, 309);
    AddSplit("disc1", "dali", "Enter Dali", 9011, 359);
    AddSplit("disc1", "blackwaltz2", "Black Waltz 2", 294, 453);
    AddSplit("disc1", "blackwaltz3", "Black Waltz 3", 296, 501);
    AddSplit("disc1", "mu", "Mu", 13, 566);
    AddSplit("disc1", "entergizamaluke", "Enter Gizamaluke's", 9000, 701);
    AddSplit("disc1", "gizamaluke", "Gizamaluke", 326, 707);
    AddSplit("disc1", "burmercia", "Enter Burmercia", 9000, 750);
    AddSplit("disc1", "beatrix1", "Beatrix 1", 4, 768);

    settings.Add("disc2", true, "Disc 2 Splits");
    AddSplit("disc2", "blackwaltz32", "Black Waltz 3 2", 52, 811);
    AddSplit("disc2", "ralvurahva", "Ralvurahva", 76, 956);
    AddSplit("disc2", "cleyra", "Cleyra Settlement", 1050, 1051);
    AddSplit("disc2", "antlion", "Antlion", 300, 1052);
    AddSplit("disc2", "beatrix2", "Beatrix 2", 299, 1108);
    AddSplit("disc2", "guards", "Guards", 1209, 1211);
    AddSplit("disc2", "tantarian", "Tantarian", 930, 1216);
    AddSplit("disc2", "zornandthorn", "Zorn & Thorn", 74, 1205);
    AddSplit("disc2", "beatrix3", "Beatrix 3", 73, 1225);
    AddSplit("disc2", "ralvuimago", "Ralvuimago", 75, 955);
    AddSplit("disc2", "lani", "Lani", 83, 1424);
    AddSplit("disc2", "fossilroo", "Exit Fossil Roo", 1425, 9003);
    AddSplit("disc2", "blackmagevillage", "Exit Black Mage Village", 1450, 9003);
    AddSplit("disc2", "hilgigars", "Hilgigars", 107, 1555);
    AddSplit("disc2", "enteriifatree", "Enter Iifa Tree", 9003, 1650);
    AddSplit("disc2", "soulcage", "Soulcage", 116, 1756);
    AddSplit("disc2", "amarant", "Amarant", 132, 1605);
    AddSplit("disc2", "iifatreedone", "Iifa Tree Done", 1655, 1656);

    settings.Add("disc3", true, "Disc 3 Splits");
    AddSplit("disc3", "cards", "Card Tournament", 1903, 2054);
    AddSplit("disc3", "mistodons", "Mistodons", 915, 1807);
    AddSplit("disc3", "bluenarciss", "Blue Narciss", 2173, 2855);
    AddSplit("disc3", "sand", "Sand", 9003, 2200);
    AddSplit("disc3", "oeilvert", "Enter Oeilvert", 9005, 2250);
    AddSplit("disc3", "ark", "Ark", 0, 2260);
    AddSplit("disc3", "valiapira", "Valia Pira", 525, 2222);
    AddSplit("disc3", "estogaza", "Enter Esto Gaza", 9003, 2300);
    AddSplit("disc3", "reddragons", "Red Dragons", 195, 2361);
    AddSplit("disc3", "meltigemini", "Meltigemini", 200, 2364);
    AddSplit("disc3", "ipsencastle", "Enter Ipsen's Castle", 9007, 2500);
    AddSplit("disc3", "taharka", "Taharka", 871, 2510);
    AddSplit("disc3", "earthshrine", "Enter Earth Shrine", 9007, 2550);
    AddSplit("disc3", "earthguardian", "Earth Guardian", 2, 2553);
    AddSplit("disc3", "branbal", "Enter Bran Bal", 2650, 2651);
    AddSplit("disc3", "amdusias", "Amdusias", 155, 2706);
    AddSplit("disc3", "abadon", "Abadon", 160, 2707);
    AddSplit("disc3", "shelldragon", "Shell Dragon", 163, 2708);
    AddSplit("disc3", "silverdragon", "Silver Dragon", 889, 2715);
    AddSplit("disc3", "garland", "Garland", 890, 2715);
    AddSplit("disc3", "kuja", "Kuja", 891, 2720);

    settings.Add("disc4", true, "Disc 4 Splits");
    AddSplit("disc4", "novadragon", "Nova Dragon", 931, 2753);
    AddSplit("disc4", "maliris", "Maliris", 932, 2904);
    AddSplit("disc4", "tiamat", "Tiamat", 933, 2908);
    AddSplit("disc4", "kraken", "Kraken", 934, 2915);
    AddSplit("disc4", "lich", "Lich", 935, 2919);
    AddSplit("disc4", "deathguise", "Deathguise", 936, 2926);
    AddSplit("disc4", "trancekuja", "Trance Kuja", 937, 2928);
    AddSplit("disc4", "necron", "Necron", 938, 938);

    settings.Add("counter", true, "Encounter Counter");
    settings.SetToolTip("counter", "Add a TextComponent with \"Encounters:\" on the left text to show the counter.");

    settings.Add("debug", false, "Debug Stuff");
    settings.SetToolTip("debug", "Add a TextComponent with \"SceneId:\", \"SceneType:\", \"BattleId:\" or \"IsRandom:\" on the left text to show the variables' values. Used only to debug problems in the auto splitter.");

    vars.newGameButtonFocused = false;
    vars.necronHpLoaded = false;
    vars.encounters = 0;
}

update
{
    if (current.sceneType == 4)
    {
        if (current.focusedElement == "New Game Button Pointer")
        {
            vars.newGameButtonFocused = true;
        }
        else if (current.focusedElement == "Continue Button Pointer" || current.focusedElement == "Load Game Button Pointer" || current.focusedElement == "Cloud Button Pointer")
        {
            vars.newGameButtonFocused = false;
        }
    }
    else
    {
        vars.newGameButtonFocused = false;
    }

    if (current.sceneId != 938)
    {
        vars.necronHpLoaded = false;
    }

    if (settings["counter"] && old.sceneType != 3 && current.sceneType == 3)
    {
        var ragtimeBattleIds = new List<int> { 627, 634, 753, 755, 941, 942, 943, 944 };

        if (current.isRandomEncounter || ragtimeBattleIds.Contains(current.battleId))
        {
            vars.UpdateEncounterCounter(vars.encounters + 1);
        }
    }

    if (settings["debug"])
    {
        if (old.sceneId != current.sceneId)
        {
            var componentSceneId = vars.FindComponentByLeftText("SceneId:");

            if (componentSceneId != null)
            {
                componentSceneId.Settings.Text2 = current.sceneId.ToString();
            }
        }

        if (old.sceneType != current.sceneType)
        {
            var componentSceneType = vars.FindComponentByLeftText("SceneType:");

            if (componentSceneType != null)
            {
                componentSceneType.Settings.Text2 = current.sceneType.ToString();
            }
        }

        if (old.battleId != current.battleId)
        {
            var componentBattleId = vars.FindComponentByLeftText("BattleId:");

            if (componentBattleId != null)
            {
                componentBattleId.Settings.Text2 = current.battleId.ToString();
            }
        }

        if (old.isRandomEncounter != current.isRandomEncounter)
        {
            var componentIsRandom = vars.FindComponentByLeftText("IsRandom:");

            if (componentIsRandom != null)
            {
                componentIsRandom.Settings.Text2 = current.isRandomEncounter.ToString();
            }
        }
    }
}

start
{
    if (vars.newGameButtonFocused && current.buttonPressed)
    {
        vars.UpdateEncounterCounter(0);
        vars.executedSplits.Clear();
        return true;
    }
}

split
{
    foreach (var split in vars.splits)
    {
        if (!settings[split] || vars.executedSplits.Contains(split))
        {
            continue;
        }

        if (old.sceneId == vars.splitsOldSceneId[split] && current.sceneId == vars.splitsCurrentSceneId[split])
        {
            if (split == "disc4.necron")
            {
                // Necron (and some other bosses) has 10k "extra" HP to trigger cutscenes after death
                if (current.necronHp == 64100)
                {
                    vars.necronHpLoaded = true;
                    continue;
                }

                if (!vars.necronHpLoaded || current.necronHp > 10000)
                {
                    continue;
                }
            }

            vars.executedSplits.Add(split);
            return true;
        }
    }
}

isLoading
{
    return current.sceneType == 9;
}

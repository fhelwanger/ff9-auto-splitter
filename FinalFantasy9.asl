// Author(s): fhelwanger
// Description: Auto start, split, load remover and encounter counter for PC (by fhelwanger)
// URL: https://github.com/fhelwanger/ff9-auto-splitter

state("FF9")
{
    int      SceneId        : 0x1071080, 0x28, 0x10, 0x0, 0x120, 0x30, 0x28, 0x10, 0x10, 0x5C;
    int      SceneType      : 0x115BEA8, 0x48, 0x10, 0x98, 0x270, 0x10, 0x140; // Bundle = 0, Field = 1, World = 2, Battle = 3, Title = 4, QuadMist = 5, Pure = 6, Ending = 7, EndGame = 8, None = 9
    string50 FocusedElement : 0x1116790, 0x10, 0x0, 0x10, 0x58, 0x0;
    bool     ButtonPressed  : "mono.dll", 0x2635B8, 0x0, 0x38, 0x100, 0xB8, 0x138;
}

startup
{
    vars.FindComponentByLeftText = (Func<string, dynamic>)(text
        => timer.Layout.Components.FirstOrDefault<dynamic>(cmp => cmp.GetType().Name == "TextComponent" && cmp.Settings.Text1 == text));

    Action<string, string> addParent = (id, label) =>
    {
        settings.Add(id, true, label);
        settings.CurrentDefaultParent = id;
    };

    Action<string, int, int> addSplit = (label, oldSceneId, currentSceneId)
        => settings.Add(oldSceneId + "->" + currentSceneId, true, label);

    addParent("disc1", "Disc 1 Splits");
        addSplit("Mage Masher",         336,  50);
        addSplit("King Leo",            338,  63);
        addSplit("Steiner 1",           337,  58);
        addSplit("Steiner 2",           335,  67);
        addSplit("Steiner 3",           334,  60);
        addSplit("Prison Cage",         301, 251);
        addSplit("Prison Cage Skip",    251, 252);
        addSplit("Baku",                295, 202);
        addSplit("Plant Brain",         303, 257);
        addSplit("Evil Forest Done",    259, 260);
        addSplit("Sealion",              21, 309);
        addSplit("Enter Dali",         9011, 359);
        addSplit("Black Waltz 2",       294, 453);
        addSplit("Black Waltz 3",       296, 501);
        addSplit("Mu",                   13, 566);
        addSplit("Enter Gizamaluke's", 9000, 701);
        addSplit("Gizamaluke",          326, 707);
        addSplit("Enter Burmercia",    9000, 750);
        addSplit("Beatrix 1",             4, 768);
        addSplit("End of Disc 1",        70, 800);

    addParent("disc2", "Disc 2 Splits");
        addSplit("Black Waltz 3 2",           52,  811);
        addSplit("Ralvurahva",                76,  956);
        addSplit("Cleyra Settlement",       1050, 1051);
        addSplit("Antlion",                  300, 1052);
        addSplit("Beatrix 2",                299, 1108);
        addSplit("Guards",                  1209, 1211);
        addSplit("Tantarian",                930, 1216);
        addSplit("Zorn & Thorn",              74, 1205);
        addSplit("Beatrix 3",                 73, 1225);
        addSplit("Ralvuimago",                75,  955);
        addSplit("Lani",                      83, 1424);
        addSplit("Exit Fossil Roo",         1425, 9003);
        addSplit("Exit Black Mage Village", 1450, 9003);
        addSplit("Hilgigars",                107, 1555);
        addSplit("Enter Iifa Tree",         9003, 1650);
        addSplit("Soulcage",                 116, 1756);
        addSplit("Amarant",                  132, 1605);
        addSplit("Iifa Tree Done",          1655, 1656);
        addSplit("End of Disc 2",           1800, 1812);

    addParent("disc3", "Disc 3 Splits");
        addSplit("Card Tournament",      1903, 2054);
        addSplit("Mistodons",             915, 1807);
        addSplit("Blue Narciss",         2173, 2855);
        addSplit("Sand",                 9003, 2200);
        addSplit("Enter Oeilvert",       9005, 2250);
        addSplit("Ark",                     0, 2260);
        addSplit("Desert Palace Start",  2206, 2213);
        addSplit("Valia Pira",            525, 2222);
        addSplit("Enter Esto Gaza",      9003, 2300);
        addSplit("Red Dragons",           195, 2361);
        addSplit("Meltigemini",           200, 2364);
        addSplit("Enter Ipsen's Castle", 9007, 2500);
        addSplit("Taharka",               871, 2510);
        addSplit("Enter Earth Shrine",   9007, 2550);
        addSplit("Earth Guardian",          2, 2553);
        addSplit("Enter Bran Bal",       2650, 2651);
        addSplit("Amdusias",              155, 2706);
        addSplit("Abadon",                160, 2707);
        addSplit("Shell Dragon",          163, 2708);
        addSplit("Silver Dragon",         889, 2715);
        addSplit("Garland",               890, 2715);
        addSplit("Kuja",                  891, 2720);
        addSplit("End of Disc 3",        2750, 3052);

    addParent("disc4", "Disc 4 Splits");
        addSplit("Nova Dragon",      931, 2753);
        addSplit("Maliris",          932, 2904);
        addSplit("Maliris Skip",    2904, 2905);
        addSplit("Tiamat",           933, 2908);
        addSplit("Tiamat Skip",     2908, 2909);
        addSplit("Kraken",           934, 2915);
        addSplit("Kraken Skip",     2915, 2916);
        addSplit("Lich",             935, 2919);
        addSplit("Lich Skip",       2919, 2920);
        addSplit("Deathguise",       936, 2926);
        addSplit("Deathguise Skip", 2926, 2927);
        addSplit("Trance Kuja",      937, 2928);

    settings.Add("debug", false, "Debug Stuff");
        settings.SetToolTip("debug", "Add a TextComponent with \"SceneId:\" or \"SceneType:\" on the left text\nto show the variables' values.\nUsed only to debug problems in the auto splitter.");

    vars.ExecutedSplits = new HashSet<string>();
}

onReset
{
    vars.ExecutedSplits.CLear();
}

update
{
    if (!settings["debug"])
        return;

    if (old.SceneId != current.SceneId)
    {
        var componentSceneId = vars.FindComponentByLeftText("SceneId:");

        if (componentSceneId != null)
            componentSceneId.Settings.Text2 = current.SceneId.ToString();
    }

    if (old.SceneType != current.SceneType)
    {
        var componentSceneType = vars.FindComponentByLeftText("SceneType:");

        if (componentSceneType != null)
            componentSceneType.Settings.Text2 = current.SceneType.ToString();
    }
}

start
{
    return !old.ButtonPressed && current.ButtonPressed
        && current.SceneType == 4
        && current.FocusedElement == "New Game Button Pointer";
}

split
{
    string splitId = old.SceneId + "->" + current.SceneId;
    return settings[splitId] && vars.ExecutedSplits.Add(splitId);
}

isLoading
{
    return current.SceneType == 9;
}

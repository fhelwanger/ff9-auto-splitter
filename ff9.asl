state("FF9")
{
    bool isLoading: 0x0115BEA8, 0x3A0, 0x78, 0x98, 0x710, 0x84;
    int sceneId: 0x0106EBB8, 0x38, 0x20, 0x80, 0x210, 0x28, 0x10, 0x10, 0x5C;
}

startup
{
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

    vars.componentSceneId = null;

    foreach (dynamic component in timer.Layout.Components.Where(x => x.GetType().Name == "TextComponent"))
    {
        if (component.Settings.Text1 == "SceneId:")
        {
            vars.componentSceneId = component;
        }
    }
}

update
{
    if (vars.componentSceneId != null)
    {
        vars.componentSceneId.Settings.Text2 = current.sceneId.ToString();
    }
}

start
{
    // The value changes only after 0.65 seconds of "New Game" input
    if (old.sceneId == 0 && current.sceneId == 70)
    {
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
            vars.executedSplits.Add(split);
            return true;
        }
    }
}

isLoading
{
    return current.isLoading;
}

state("FF9")
{
    bool isLoading: 0x0115BEA8, 0x3A0, 0x78, 0x98, 0x710, 0x84;
    int sceneId: 0x0106EBB8, 0x38, 0x20, 0x80, 0x210, 0x28, 0x10, 0x10, 0x5C;
}

startup
{
    settings.Add("disc1", true, "Disc 1 Splits");
    settings.Add("disc1.magemasher", true, "Mage Masher", "disc1");
    settings.Add("disc1.kingleo", true, "King Leo", "disc1");
    settings.Add("disc1.steiner1", true, "Steiner 1", "disc1");
    settings.Add("disc1.steiner2", true, "Steiner 2", "disc1");
    settings.Add("disc1.steiner3", true, "Steiner 3", "disc1");
    settings.Add("disc1.prisoncage", true, "Prison Cage", "disc1");
    settings.Add("disc1.plantbrain", true, "Plant Brain", "disc1");
    settings.Add("disc1.evilforest", true, "Evil Forest Done", "disc1");
    settings.Add("disc1.sealion", true, "Sealion", "disc1");
    settings.Add("disc1.dali", true, "Enter Dali", "disc1");
    settings.Add("disc1.blackwaltz2", true, "Black Waltz 2", "disc1");
    settings.Add("disc1.blackwaltz3", true, "Black Waltz 3", "disc1");
    settings.Add("disc1.mu", true, "Mu", "disc1");
    settings.Add("disc1.entergizamaluke", true, "Enter Gizamaluke's", "disc1");
    settings.Add("disc1.gizamaluke", true, "Gizamaluke", "disc1");
    settings.Add("disc1.burmercia", true, "Enter Burmercia", "disc1");
    settings.Add("disc1.beatrix1", true, "Beatrix 1", "disc1");
}

start
{
    // The value changes only after 0.65 seconds of "New Game" input
    return old.sceneId == 0 && current.sceneId == 70;
}

split
{
    if (old.sceneId == 336 && current.sceneId == 50)
    {
        return true;
    }
}

isLoading
{
    return current.isLoading;
}

function Print_White_Resign_Message() {
    ClientPrint(null, 3, "\x0787CEEB[\x0740E0D0Chess Manager\x0787CEEB]\x01 Black has won by resignation!");
}

function Print_Black_Resign_Message() {
    ClientPrint(null, 3, "\x0787CEEB[\x0740E0D0Chess Manager\x0787CEEB]\x01 White has won by resignation!");
}

function PromptClassWarning() {
    if (activator == null || activator.IsPlayer() == false) {
        return;
    }

    if (activator.GetTeam() == 0 || activator.GetTeam() == 1) {
        return;
    }

    if (activator.GetPlayerClass() != 2 && activator.GetPlayerClass() != 8) {
        // Prompt a warning to a user who's not currently playing either Sniper or Spy.
        local playerclass = "";

        switch (activator.GetPlayerClass()) {
            case 1:
                playerclass = "Scout";
                break;
            case 3:
                playerclass = "Soldier";
                break;
            case 4:
                playerclass = "Demoman";
                break;
            case 5:
                playerclass = "Medic";
                break;
            case 6:
                playerclass = "Heavy";
                break;
            case 7:
                playerclass = "Pyro";
                break;
            case 9:
                playerclass = "Engineer";
                break;
        }
        ClientPrint(activator, 3, "\x0787CEEB[\x0740E0D0Chess Manager\x0787CEEB]\x07ffe600 Notice: \x01Sniper or Spy is recommended for this area! You are playing as a \x07b3ffca" + playerclass + "\x01!");
    }
}
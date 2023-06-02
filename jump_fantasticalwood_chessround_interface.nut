function Print_White_Resign_Message() {
    ClientPrint(null, 3, "\x0787CEEB[\x0740E0D0Chess Manager\x0787CEEB]\x01 White has resigned! Black wins!");
}

function Print_Black_Resign_Message() {
    ClientPrint(null, 3, "\x0787CEEB[\x0740E0D0Chess Manager\x0787CEEB]\x01 Black has resigned! White wins!");
}

function AutoChangeToSpyClass() {
    if (activator == null || activator.IsPlayer() == false) {
        return;
    }

    if (activator.GetTeam() == 0 || activator.GetTeam() == 1) {
        return;
    }

    if (activator.GetPlayerClass() != 8) {
        // Set player class to Spy
        activator.SetPlayerClass(8);
    }
}
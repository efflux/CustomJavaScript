# --
# Copyright (C) 2019–present Efflux GmbH, https://efflux.de/
# Part of the CustomJavaScript package.
# --
# This software comes with ABSOLUTELY NO WARRANTY. For details, see
# the enclosed file COPYING for license information (AGPL). If you
# did not receive this file, see http://www.gnu.org/licenses/agpl.txt.
# --

package Kernel::Language::de_CustomJavaScript;

use strict;
use warnings;
use utf8;

sub Data {
    my $Self = shift;

    $Self->{Translation}->{'Custom JavaScript'} = 'Eigener JavaScript';
    $Self->{Translation}->{'Add custom JavaScript code to the system.'} = 'Eigenen JavaScript-Code in das System hinzufügen.';
    $Self->{Translation}->{'Manage JavaScript'} = 'JavaScript-Verwaltung';
    $Self->{Translation}->{'JavaScript for agents'} = 'JavaScript für Agenten';
    $Self->{Translation}->{'This JavaScript code will be executed on all pages for agents.'} = 'Dieser JavaScript Code wird auf allen Agenten-Seiten ausgeführt.';
    $Self->{Translation}->{'*will be added to the bottom of the editor.'} = '*werden ans Ende des Editors hinzugefügt.';
    $Self->{Translation}->{'You should make a backup before a major update. You can use the build in export function.'} = 'Vor einem Major-Update sollten Sie eine Sicherheitskopie erstellen. Dafür können Sie die eingebaute Export-Funktion verwenden.';
    $Self->{Translation}->{'Export as .js'} = 'Als .js exportieren';
    # Templates
    $Self->{Translation}->{'Agent name to console.log'} = 'Agenten-Namen zu console.log';
    $Self->{Translation}->{'Execute in AgentTicketZoom'} = 'In AgentTicketZoom ausführen';
}

1;

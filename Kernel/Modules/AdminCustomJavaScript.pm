# --
# Copyright (C) 2019–present Efflux GmbH, https://efflux.de/
# Part of the CustomJavaScript package.
# --
# This software comes with ABSOLUTELY NO WARRANTY. For details, see
# the enclosed file COPYING for license information (GPL). If you
# did not receive this file, see https://www.gnu.org/licenses/gpl-3.0.txt.
# --

package Kernel::Modules::AdminCustomJavaScript;

use strict;
use warnings;

our $ObjectManagerDisabled = 1;

sub new {
    my ($Type, %Param) = @_;

    my $Self = {%Param};
    bless($Self, $Type);

    return $Self;
}

sub Run {
    my ($Self, %Param) = @_;

    my $LayoutObject = $Kernel::OM->Get('Kernel::Output::HTML::Layout');
    my $ParamObject  = $Kernel::OM->Get('Kernel::System::Web::Request');
    my $XMLObject    = $Kernel::OM->Get('Kernel::System::XML');
    my $CacheObject  = $Kernel::OM->Get('Kernel::System::Cache');


    if ($Self->{Subaction} eq 'AddAction') {
        $LayoutObject->ChallengeTokenCheck();

        my $JavaScriptField = $ParamObject->GetParam(Param => 'JavaScriptField') || '';

        # Flush old JavaScript.
        $XMLObject->XMLHashDelete(
            Type => 'CustomJavaScript',
            Key  => '1'
        );

        # Update new JavaScript.
        $XMLObject->XMLHashAdd(
            Key     => 1,
            Type    => 'CustomJavaScript',
            XMLHash => [({'Content' => $JavaScriptField})]
        );

        # Delete Cache.
        $CacheObject->Delete(
            Type => 'CustomJavaScript',
            Key  => '1'
        );
    
        return $LayoutObject->Redirect(OP => "Action=AdminCustomJavaScript");  # Prevent from resubmitting.
    } else {
        $Param{Action} = 'Add';

        # Get the current JavaScript.
        my @XMLHash = $XMLObject->XMLHashGet(
            Type => 'CustomJavaScript',
            Key  => '1'
        );

        $Param{'JavaScriptField'} = $XMLHash[0]{'Content'};

        $LayoutObject->Block(
            Name => 'Overview',
            Data => \%Param
        );

        # Create the CodeMirror editor.
        $LayoutObject->SetRichTextParameters(
            Data => {
                %Param,
                RichTextHeight => '600',
                RichTextWidth  => '99%',
                RichTextType   => 'CodeMirror'
            }
        );

        return  $LayoutObject->Header() .
                $LayoutObject->NavigationBar() . 
                $LayoutObject->Output(
                    TemplateFile => 'AdminCustomJavaScript',
                    Data         => \%Param
                ) . $LayoutObject->Footer();
    }
}

1;

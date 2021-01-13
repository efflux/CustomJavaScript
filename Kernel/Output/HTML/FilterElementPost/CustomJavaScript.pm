# --
# Copyright (C) 2019–present Efflux GmbH, https://efflux.de/
# Part of the CustomJavaScript package.
# --
# This software comes with ABSOLUTELY NO WARRANTY. For details, see
# the enclosed file COPYING for license information (GPL). If you
# did not receive this file, see https://www.gnu.org/licenses/gpl-3.0.txt.
# --

package Kernel::Output::HTML::FilterElementPost::CustomJavaScript;

use strict;
use warnings;

our @ObjectDependencies = (
	'Kernel::System::XML',
	'Kernel::System::Cache'
);

sub new {
	my ($Type, %Param) = @_;

	my $Self = {};
	bless($Self, $Type);

	return $Self;
}

sub Run {
	my ($Self, %Param) = @_;

	my $CacheObject	= $Kernel::OM->Get('Kernel::System::Cache');

	my $JavaScript = $CacheObject->Get(
		Type => 'CustomJavaScript',
		Key  =>'1'
	);

	if (!$JavaScript) {
		my $XMLObject	= $Kernel::OM->Get('Kernel::System::XML');

		# Get JavaScript from DB. 
		my @XMLHash = $XMLObject->XMLHashGet(
			Type	=> 'CustomJavaScript',
			Key		=> '1'
		);
		$JavaScript = $XMLHash[0]{'Content'};

		# Only cache is there is something to cache.
		if ($JavaScript) {
			$CacheObject->Set(
				Type	=> 'CustomJavaScript',
				Key		=> '1',
				TTL		=> 60 * 60 * 24 * 20,
				Value	=> $JavaScript
			);
		}
	}

	# Only return if something exists.
	${$Param{Data}} =~ s{</body>}{<script>Core.App.Ready(function () { $JavaScript });</script></body>}smx if ($JavaScript);

	return 1;
}

1;

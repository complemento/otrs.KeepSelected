# --
# Kernel/Output/HTML/OutputFilterMediaWiki.pm
# Copyright (C) 2011 - 2015 Complemento - Liberdade e Tecnologia http://www.complemento.net.br
# --
# --
# This software comes with ABSOLUTELY NO WARRANTY. For details, see
# the enclosed file COPYING for license information (AGPL). If you
# did not receive this file, see http://www.gnu.org/licenses/agpl.txt.
# --

package Kernel::Output::HTML::OutputFilterBulkActionPagination;

use strict;
use warnings;
require LWP::UserAgent;
use List::Util qw(first);
use HTTP::Status qw(:constants :is status_message);
use Kernel::System::Encode;
use Kernel::System::DB;
use Kernel::System::CustomerUser;
use Kernel::System::CustomerCompany;

sub new {
    my ( $Type, %Param ) = @_;

    # allocate new hash for object
    my $Self = {};
    bless( $Self, $Type );

    # get needed objects
    return $Self;
}

sub Run {
    my ( $Self, %Param ) = @_;
    my %Data = ();

	# Verifica se já incluímos o javascript
	if  (${ $Param{Data} } !~ /id="BulkAction"/){
		return;
	}
	
    my $ParamObject = $Kernel::OM->Get('Kernel::System::Web::Request');
    my $ConfigObject = $Kernel::OM->Get('Kernel::Config');
    my $LayoutObject = $Kernel::OM->Get('Kernel::Output::HTML::Layout')
;
    my $TicketObject = $Kernel::OM->Get('Kernel::System::Ticket');
    my @TicketIDs = grep {$_}
        $ParamObject->GetArray( Param => 'BulkTicketID' );

	if(scalar @TicketIDs > 0){
		$Data{TicketList} = "'".(join "','",@TicketIDs)."'";	
	}

    # Enfileira javascript
	$LayoutObject->Output(
	    TemplateFile => 'ShowBulkActionPagination',
        Data         => \%Data,
	);



}
1;


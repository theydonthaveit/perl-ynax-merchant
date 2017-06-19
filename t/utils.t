use strict;
use warnings;

use Project::Libs lib_dirs => [qw(ynaxmerchant)];
use Data::Dumper;
use Test::More;

use utils::LogToDB;
use utils::Logger;

my $log = LogToDB->new(string => "things", status => "completed" )->send_to_db;
my $logger = Logger->new( info => "we are okay", status => "completed" )->send_to_db;
# print Dumper $logger;

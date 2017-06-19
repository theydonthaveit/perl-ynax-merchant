use strict;
use warnings;

use Project::Libs lib_dirs => [qw(ynaxmerchant)];
use Data::Dumper;
use Test::More;

use process::ReadFile;

my $file_data = ReadFile->new( file => '../data/clothing.csv' )->get_data;
my $result = $file_data->input_to_db;

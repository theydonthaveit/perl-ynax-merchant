use strict;
use warnings;

use Project::Libs lib_dirs => [qw(ynaxmerchant)];
use Data::Dumper;
use Test::More;

use process::ReadFile;

my $file_data = ReadFile->new( file => '../data/clothing.csv' )->get_data;
my $result = $file_data->input_to_db;

# my $tag_clothes = ReadFile->tag_clothes("iSwim Summer Bikini");
# print $tag_clothes;
#
# my $remove_whitespace = ReadFile->remove_whitespace(" iSwim Summer Bikini");
# print $remove_whitespace;

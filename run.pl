use strict;
use warnings;

use Project::Libs lib_dirs => [qw(lib)];
use process::ReadFile;

my $fh = ReadFile->new(file => 'data/clothing.csv');
my $result = $fh->get_data->input_to_db;

print "We have successfull inserted the data"
    unless $result->{completed} eq 0;

exit;

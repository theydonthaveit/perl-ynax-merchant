use strict;
use warnings;

use Project::Libs lib_dirs => [qw(lib)];

use process::ReadFile;
use Data::Dumper;
use MongoDB;
use Test::More tests => 2;
use Test::Mock::MongoDB qw( any );

my $mock_input_one = '../data/clothing.csv';
my $mock = Test::Mock::MongoDB->new(skip_init => 'all');
my $module_one =
    ReadFile->new(
        file => $mock_input_one );

# Test Case 1.0 -- Process ReadFIle  #
# {{{
subtest
  'Test Case 1.0 -- Process ReadFile -- Read the File to CSV object'
  => sub
  {
    plan tests => 1;

    is( $module_one->get_data->{completed}, '1', 'Successfully Read File' );
  };
#}}}

# Test Case 2.0 -- Test MongoDB Setup #
# {{{
subtest
  'Test Case 2.0 -- Test MongoDB Setup'
  => sub
  {
    plan tests => 3;

    $mock->get_collection->method(
        insert => {
            name => 'iSwim Summer Bikini',
            category => 'Bikinis',
            tag => 'iSwim' })
        ->callback(
            sub {
                return {
                    category => "Bikinis",
                    name => "iSwim Summer Bikini",
                    tag => "iSwim"
                };
            }
        );

    my $client = MongoDB->connect();
    my $db = $client->get_database('foo');
    my $collection = $db->get_collection('bar');

    my $int_result = $collection->insert({
            name => 'iSwim Summer Bikini',
            category => 'Bikinis',
            tag => 'iSwim' });

    is($int_result->{tag}, 'iSwim', 'Accurate Insert');
    is($int_result->{name}, 'iSwim Summer Bikini', 'Accurate Insert');
    is($int_result->{category}, 'Bikinis', 'Accurate Insert');
  };
#}}}

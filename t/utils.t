use strict;
use warnings;

use Project::Libs lib_dirs => [qw(lib)];

use utils::Cleanse;
use Test::More tests => 1;

my $mock_input_one = 'this+is+a+test';
my $mock_input_two = 'this&is&a&test';
my $mock_input_three = 'this is a test';

my $mock_output = 'this is a test';

my $module_one =
    Cleanse->new(
        string => $mock_input_one
    );

my $module_two =
    Cleanse->new(
        string => $mock_input_two
    );

my $module_three =
    Cleanse->new(
        string => $mock_input_three
    );

# Test Case 1.0 -- Utils Cleanse  #
# {{{
subtest
  'Test Case 1.0 -- Utils Cleanse -- Remove + OR & OR remain the same'
  => sub
  {
    plan tests => 3;

    is( $module_one->understand_string, $mock_output, 'Successfully Removed + Symbol' );
    is( $module_two->understand_string, $mock_output, 'Successfully Removed & Symbol' );
    is( $module_three->understand_string, $mock_output, 'Successfully Kept the Same' );

  };
#}}}

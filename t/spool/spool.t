use v5.14;
use warnings;
use utf8;

use Test::More;
use Data::Dumper;

$ENV{SHM_TEST} = 1;

use constant TASK_NEW => 0;
use constant TASK_SUCCESS => 1;
use constant TASK_FAIL => 2;
use constant TASK_DROP => 3;

use SHM;
use Core::System::ServiceManager qw( get_service );

SHM->new( user_id => 40092 );
my $obj = get_service('USObject', _id => 99 );

my $task1 = get_service('spool')->add(
    server_id => 1,
    category => 'dns',
    user_service_id => 16,
    event => 'create',
);

my $task2 = get_service('spool')->add(
    server_id => 162,
    category => 'dns',
    user_service_id => 16,
    event => 'create',
);

my $spool = get_service('spool');

while ( $spool->process_one ){};

my @ret = get_service('SpoolHistory')->list(
    where => { spool_id => { -in => [ $task1, $task2 ] } },
    order => [ spool_id => 'ASC' ],
);

is( $ret[0]->{status}, TASK_SUCCESS, 'Send test message for test services' );
is( $ret[1]->{status}, TASK_DROP, "Server: 162 not exists" );

my @list = $spool->list;
is ( @list, 0, 'Check for empty spool' );

done_testing();

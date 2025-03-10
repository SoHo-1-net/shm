package Core::Transport::Mikrotik;

use parent 'Core::Base';

use v5.14;
use utf8;
use Core::Base;
use Net::OpenSSH;
use Core::Utils qw(is_host);

sub exec {
    my $self = shift;
    my %args = (
        host     => undef,
        port     => 22,
        key_id   => undef,
        timeout  => 10,
        cmd      => undef,
        task     => undef,
        @_,
    );

    # Проверка и сборка хоста
    my $host = get_ssh_host( $args{host} ) or return undef, { error => "Invalid SSH host: $args{host}" };

    # Ключ доступа
    my $key_file;
    if ( my $ident = get_service( 'Identities', _id => $args{key_id} ) ) {
        $key_file = $ident->private_key_file;
    } else {
        return undef, { error => "Key ID $args{key_id} not found" };
    }

    my $ssh = Net::OpenSSH->new(
        $host,
        port                  => $args{port},
        key_path              => $key_file,
        batch_mode            => 1,
        timeout               => $args{timeout},
        kill_ssh_on_timeout   => 1,
        strict_mode           => 0,
        master_opts           => ['-o', 'StrictHostKeyChecking=no'],
    );
    unlink $key_file;

    if ( $ssh->error ) {
        return undef, { error => "SSH error: " . $ssh->error };
    }

    # Передаем команду чисто, без оберток
    my $cmd = $args{cmd};
    my ($out, $err) = $ssh->capture2( $cmd );  # ВАЖНО: БЕЗ shell

    my $ret_code = $ssh->error ? 1 : 0;

    return ($ret_code == 0) ? SUCCESS : FAIL, {
        cmd       => $cmd,
        ret_code  => $ret_code,
        stdout    => $out,
        stderr    => $err,
    };
}

sub get_ssh_host {
    my $host = shift;

    my ($user, $host_name);
    if ( $host =~ /@/ ) {
        ($user, $host_name) = split( /\@/, $host );
    }
    $host_name //= $host;
    $user      //= 'shmadmin'; # default user for Mikrotik

    return is_host($host_name) ? "$user\@$host_name" : undef;
}

1;

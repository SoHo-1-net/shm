package Core::Transport::mydevice;

use strict;
use warnings;

sub new {
    my ($class, $args) = @_;
    my $self = {
        ip   => $args->{ip},
        port => $args->{port} || 22,
        user => $args->{user},
        pass => $args->{pass},
    };
    bless $self, $class;
    return $self;
}

sub send_command {
    my ($self, $command) = @_;
    
    # Здесь код отправки команды на устройство (по SSH, API и т.д.)
    print "Sending command to $self->{ip}: $command\n";

    # Возвращаем результат
    return 1;
}

1;

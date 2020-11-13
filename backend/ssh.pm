# Copyright © 2020 SUSE LLC
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License along
# with this program; if not, see <http://www.gnu.org/licenses/>.

package backend::ssh;

use strict;
use warnings;

use base 'backend::baseclass';

sub new { shift->SUPER::new }

sub do_start_vm {
    my ($self) = @_;
    $self->truncate_serial_file;

    return {};
}

sub do_stop_vm {
    my ($self) = @_;

    $self->stop_serial_grab;
    return {};
}

sub run_cmd { }

sub can_handle {
    my ($self, $args) = @_;
    return undef;
}

sub is_shutdown { 1 }

sub stop_serial_grab {
    my ($self) = @_;

    $self->stop_ssh_serial;
    return;
}

sub check_socket {
    my ($self, $fh, $write) = @_;

    if ($self->check_ssh_serial($fh)) {
        return 1;
    }
    return $self->SUPER::check_socket($fh, $write);
}

1;

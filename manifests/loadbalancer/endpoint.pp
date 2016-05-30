# Copyright 2014 Red Hat, Inc.
# All Rights Reserved.
#
# Licensed under the Apache License, Version 2.0 (the "License"); you may
# not use this file except in compliance with the License. You may obtain
# a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS, WITHOUT
# WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the
# License for the specific language governing permissions and limitations
# under the License.

# == Class: tripleo::loadbalancer::endpoint
#
# Configure a HAProxy listen endpoint
#
# [*internal_ip*]
#  The IP in which the proxy endpoint will be listening in the internal
#  network.
#
# [*service_port*]
#  The default port on which the endpoint will be listening.
#
# [*ip_addresses*]
#  The ordered list of IPs to be used to contact the balancer member.
#
# [*server_names*]
#  The names of the balancer members, which usually should be the hostname.
#
# [*member_options*]
#  Options for the balancer member, specified after the server declaration.
#  These should go in the member's configuration block.
#
# [*public_virtual_ip*]
#  Address in which the proxy endpoint will be listening in the public network.
#  If this service is internal only this should be ommited.
#  Defaults to undef.
#
# [*mode*]
#  HAProxy mode in which the endpoint will be listening. This can be undef,
#  tcp, http or health.
#  Defaults to undef.
#
# [*haproxy_listen_bind_param*]
#  A list of params to be added to the HAProxy listener bind directive.
#  Defaults to undef.
#
# [*listen_options*]
#  Options specified for the listening service's configuration block (in
#  HAproxy terms, the frontend).
#  defaults to {'option' => []}
#
# [*public_ssl_port*]
#  The port used for the public proxy endpoint if it differs from the default
#  one. This is used only if SSL is enabled, and it's used in order to avoid
#  overriding with the internal proxy endpoint (which could happen if they were
#  in the same network).
#  Defaults to undef.
#
# [*public_certificate*]
#  Certificate path used to enable TLS for the public proxy endpoint.
#  Defaults to undef.
#
# [*internal_certificate*]
#  Certificate path used to enable TLS for the internal proxy endpoint.
#  Defaults to undef.
#
define tripleo::loadbalancer::endpoint (
  $internal_ip,
  $service_port,
  $ip_addresses,
  $server_names,
  $member_options,
  $public_virtual_ip         = undef,
  $mode                      = undef,
  $haproxy_listen_bind_param = undef,
  $listen_options            = {
    'option' => [],
  },
  $public_ssl_port           = undef,
  $public_certificate        = undef,
  $internal_certificate      = undef,
) {
  ::tripleo::haproxy::endpoint { $name:
    internal_ip               => $internal_ip,
    service_port              => $service_port,
    ip_addresses              => $ip_addresses,
    server_names              => $server_names,
    member_options            => $member_options,
    public_virtual_ip         => $public_virtual_ip,
    mode                      => $mode,
    haproxy_listen_bind_param => $haproxy_listen_bind_param,
    listen_options            => $listen_options,
    public_ssl_port           => $public_ssl_port,
    public_certificate        => $public_certificate,
    internal_certificate      => $internal_certificate
  }
}
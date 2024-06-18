{ lib, ... }: {
    services.postgresql = {
      enable = true;
      enableJIT = true;
      enableTCPIP = true;
      authentication = lib.mkOverride 10 ''
        #type database  DBuser  auth-method
        local all       all     trust
        # ipv4
        host  all       all 127.0.0.1/32   trust
        host  all       all 192.168.1.0/23 scram-sha-256
        # ipv6
        host all        all     ::1/128    trust
      '';
    };
}
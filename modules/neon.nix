{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.services.neon;
in
{
  options.services.neon = {
    enable = mkEnableOption "Neon database service";

    package = mkOption {
      type = types.package;
      default = pkgs.neon;
      description = "The Neon package to use.";
    };

    dataDir = mkOption {
      type = types.path;
      default = "/var/lib/neon";
      description = "Directory to store Neon data.";
    };

    user = mkOption {
      type = types.str;
      default = "neon";
      description = "User account under which Neon runs.";
    };

    group = mkOption {
      type = types.str;
      default = "neon";
      description = "Group account under which Neon runs.";
    };

    port = mkOption {
      type = types.port;
      default = 55432;
      description = "Port for Neon compute node.";
    };

    settings = mkOption {
      type = types.attrs;
      default = { };
      description = "Neon configuration settings.";
    };
  };

  config = mkIf cfg.enable {
    users.users.${cfg.user} = {
      isSystemUser = true;
      group = cfg.group;
      home = cfg.dataDir;
      createHome = true;
      description = "Neon database user";
    };

    users.groups.${cfg.group} = { };

    systemd.services.neon-pageserver = {
      description = "Neon Page Server";
      wantedBy = [ "multi-user.target" ];
      after = [ "network.target" ];

      serviceConfig = {
        Type = "simple";
        User = cfg.user;
        Group = cfg.group;
        ExecStart = "${cfg.package}/bin/pageserver --config ${cfg.dataDir}/pageserver.toml";
        Restart = "always";
        StateDirectory = "neon";
        StateDirectoryMode = "0750";
        RuntimeDirectory = "neon";
        RuntimeDirectoryMode = "0750";
      };

      preStart = ''
        mkdir -p ${cfg.dataDir}
        chown ${cfg.user}:${cfg.group} ${cfg.dataDir}
        
        if [ ! -f ${cfg.dataDir}/pageserver.toml ]; then
          cat > ${cfg.dataDir}/pageserver.toml << EOF
        listen_pg_addr = '127.0.0.1:${toString cfg.port}'
        listen_http_addr = '127.0.0.1:9898'
        data_dir = '${cfg.dataDir}/pageserver'
        EOF
        fi
      '';
    };

    systemd.services.neon-safekeeper = {
      description = "Neon Safekeeper";
      wantedBy = [ "multi-user.target" ];
      after = [ "network.target" ];

      serviceConfig = {
        Type = "simple";
        User = cfg.user;
        Group = cfg.group;
        ExecStart = "${cfg.package}/bin/safekeeper --config ${cfg.dataDir}/safekeeper.toml";
        Restart = "always";
        StateDirectory = "neon";
        StateDirectoryMode = "0750";
        RuntimeDirectory = "neon";
        RuntimeDirectoryMode = "0750";
      };

      preStart = ''
        mkdir -p ${cfg.dataDir}
        chown ${cfg.user}:${cfg.group} ${cfg.dataDir}
        
        if [ ! -f ${cfg.dataDir}/safekeeper.toml ]; then
          cat > ${cfg.dataDir}/safekeeper.toml << EOF
        id = 1
        pg_listen_addr = '127.0.0.1:5454'
        broker_endpoint = 'http://127.0.0.1:50051'
        data_dir = '${cfg.dataDir}/safekeepers/sk1'
        EOF
        fi
      '';
    };

    systemd.services.neon-compute = {
      description = "Neon Compute Node";
      wantedBy = [ "multi-user.target" ];
      after = [ "network.target" "neon-pageserver.service" "neon-safekeeper.service" ];
      requires = [ "neon-pageserver.service" "neon-safekeeper.service" ];

      serviceConfig = {
        Type = "simple";
        User = cfg.user;
        Group = cfg.group;
        ExecStart = "${cfg.package}/bin/postgres -D ${cfg.dataDir}/compute";
        Restart = "always";
        StateDirectory = "neon";
        StateDirectoryMode = "0750";
        RuntimeDirectory = "neon";
        RuntimeDirectoryMode = "0750";
      };

      preStart = ''
        mkdir -p ${cfg.dataDir}/compute
        if [ ! -d ${cfg.dataDir}/compute/base ]; then
          ${cfg.package}/bin/initdb -D ${cfg.dataDir}/compute \
            --username=${cfg.user} \
            --pwfile=<(echo "initial-password")
        fi

        # Configure postgres
        cat > ${cfg.dataDir}/compute/postgresql.conf << EOF
        listen_addresses = '127.0.0.1'
        port = ${toString cfg.port}
        EOF

        chown -R ${cfg.user}:${cfg.group} ${cfg.dataDir}/compute
      '';
    };

    environment.systemPackages = [ cfg.package ];
  };
}

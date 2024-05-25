let inputs = import "./nickel.lock.ncl" in
let organist = inputs.organist in

let http_port = 9000 in

{
  shells = organist.shells.Bash,

  shells.build = {
    packages = {},
  },

  shells.dev = {
    packages = {
    },
  },

  services = {
    caddy = nix-s%"
%{organist.import_nix "nixpkgs#caddy"}/bin/caddy file-server --listen :%{std.to_string http_port} 
    "%,
  },
}
  | (
    organist.OrganistExpression
    & organist.services.Schema
    # & organist.tools.direnv.Schema
  )

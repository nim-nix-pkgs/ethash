{
  description = ''A Nim implementation of Ethash, the ethereum proof-of-work hashing function'';

  inputs.flakeNimbleLib.owner = "riinr";
  inputs.flakeNimbleLib.ref   = "master";
  inputs.flakeNimbleLib.repo  = "nim-flakes-lib";
  inputs.flakeNimbleLib.type  = "github";
  inputs.flakeNimbleLib.inputs.nixpkgs.follows = "nixpkgs";
  
  inputs.src-ethash-master.flake = false;
  inputs.src-ethash-master.owner = "status-im";
  inputs.src-ethash-master.ref   = "refs/heads/master";
  inputs.src-ethash-master.repo  = "nim-ethash";
  inputs.src-ethash-master.type  = "github";
  
  inputs."nimcrypto".dir   = "nimpkgs/n/nimcrypto";
  inputs."nimcrypto".owner = "riinr";
  inputs."nimcrypto".ref   = "flake-pinning";
  inputs."nimcrypto".repo  = "flake-nimble";
  inputs."nimcrypto".type  = "github";
  inputs."nimcrypto".inputs.nixpkgs.follows = "nixpkgs";
  inputs."nimcrypto".inputs.flakeNimbleLib.follows = "flakeNimbleLib";
  
  outputs = { self, nixpkgs, flakeNimbleLib, ...}@deps:
  let 
    lib  = flakeNimbleLib.lib;
    args = ["self" "nixpkgs" "flakeNimbleLib" "src-ethash-master"];
  in lib.mkRefOutput {
    inherit self nixpkgs ;
    src  = deps."src-ethash-master";
    deps = builtins.removeAttrs deps args;
    meta = builtins.fromJSON (builtins.readFile ./meta.json);
  };
}
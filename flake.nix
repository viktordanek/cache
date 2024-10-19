{
    inputs =
        {
            environment-variable-lib.url = "github:viktordanek/environment-variable" ;
            flake-utils.url = "github:numtide/flake-utils" ;
            has-standard-input-lib.url = "github:viktordanek/has-standard-input" ;
            nixpkgs.url = "github:NixOs/nixpkgs" ;
            strip-lib.url = "github:viktordanek/strip" ;
            temporary-lib.url = "github:viktordanek/temporary" ;
        } ;
    outputs =
        { environment-variable-lib , flake-utils , has-standard-input-lib , nixpkgs , self , strip-lib , temporary } :
            let
                fun =
                    system :
                        let
                            environment-variable = builtins.getAttr system ( builtins.getAttr "lib" environment-variable-lib ) ;
                            has-standard-input = builtins.getAttr system ( builtins.getAttr "lib" has-standard-input-lib ) ;
                            lib =
                                {
                                    hash ? "aa6c893e3652ad06faf199905e41493b205651e539aeeaee8351c9e8d320411f9361f3b6e6246585c6c200196906093235add2db2bc01077ee7a2127fe23cad6" ,
                                    timestamp ? "5be6cfe04c3e87a29ed30051f255ae0da5449e03a6b59aba5628f87ac3a06cd1664a3e578d65d03f1e312b7bf23f0a1e9ff40cd8d4670eb83bfea4ddda3ba70d"
                                } :
                                    let
                                        mapper =

                                        compute =
                                            ''
                                                export ${ timestamp }=${ environment-variable "${ timestamp }:=$( ${ pkgs.coreutils }/bin/date +%s )" } &&
                                                    export PARENT_HASH=${ environment-variable hash } &&
                                                    export ${ hash }=$( ${ pkgs.coreutils }/bin/echo $( ${ pkgs.coreutils }/bin/whoami ) | ${ pkgs.coreutils }/bin/sha512sum | ${ pkgs.coreutils }/bin/cut --bytes -128 )
                                            '' ;
                                        t =
                                            temporary
                                                {
                                                    mask-reference = "/tmp/*.07fc96fde7604d87f75cce3be32ff65b72b8dd46" ;
                                                    out = "e8811f21a16257eec4d385622ae4c60c5445d2c8da6ce6768972964c83b1151348bd7d7018b15f5bc3bdae2a39e33a29c6ad5f53115bf0c9d4b5904d41ddb4f" ;
                                                    resource = "d620d4ee6791e0b3fce665f0c129e3c7e669f0c5da3ea6c9da8c210df583e8a90978e57a38905d9ecf2bbb966313f9f0a5def7d8c3955e3a16937ae7ad9aee84" ;
                                                    # scripts = secondary : temporary-scripts ;
                                                    target = "f2d39ffa261aa8f6e1fa365271e595fe3348fef09a7f5f635c7b36fc80bdf52d695eb7d8c296bffbd27565494f82237af1902893fc409b2e59e6a154dd682d98" ;
                                                    temporary-resource-directory = "${ pkgs.coreutils }/bin/mktemp --directory -t XXXXXXXX.07fc96fde7604d87f75cce3be32ff65b72b8dd46" ;
                                                    temporary-broken-directory = "${ pkgs.coreutils }/bin/mktemp --directory -t XXXXXXXX.d8356a508c830ab54e27c182d20d6f71eaedeace"
                                                } ;
                                        in null ;
                            pkgs = import nixpkgs { system = system ; } ;
                            strip = builtins.getAttr system ( builtins.getAttr "lib" strip-lib ) ;
                            temporary = builtins.getAttr system ( builtins.getAttr "lib" temporary-lib ) ;
                            in
                                {
                                    checks.testLib =
                                        pkgs.stdenv.mkDerivation
                                            {
                                                name = "test-lib" ;
                                                builder = "${pkgs.bash}/bin/bash" ;
                                                args =
                                                    [
                                                        "-c"
                                                        ''
                                                        ''
                                                    ] ;
                                            } ;
                                    lib = lib ;
                                } ;
                in flake-utils.lib.eachDefaultSystem fun ;
}

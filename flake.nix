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
                                    at ? "/run/wrappers/bin/at" ,
                                    cache ? { } ,
                                    directory ? "/tmp/1ec9efe065edf985cbc546e9d0267cdcb5c2b9bb" ;
                                    hash ? "aa6c893e3652ad06faf199905e41493b205651e539aeeaee8351c9e8d320411f9361f3b6e6246585c6c200196906093235add2db2bc01077ee7a2127fe23cad6" ,
                                    invalid-cache-throw ? value : "1c7b556a5015fb0e1f25cdc86a2263d67db1ec6a8a89e7b3d214ae71b210925da7aa33b1a3ab607df423397434d0d36c53a64e82ac4b1235feb61145c16bcec6 ${ builtins.typeOf value }" ,
                                    invalid-script-throw ? value : "c17bfd9b3387602ede2ec5616c9e00ae2b2e89e514e63995cd1e5c978aa1dc56b180f5e638e36f1ca64eabad2581075f53ddd7915c3590c87b50b086bba963fa ${ builtins.typeOf value }" ,
                                    invalid-cache-throw ? value : "c40ec39bf3fd871f3742a8be6bb2f2a836018b6443658a418814c9cf49b6cba902bcc62b32936dff38ee3cc75da0aa68f49b65558617e67ca36c0fbe8e48e38d ${ builtins.typeOf value }" ,
                                    salt ? "2bcb8318af769ce4d8543f546018a507a28b6f92f74f6bbc3fbd0d6e510619be962459dd430fad9d9065a38a13f823c1cad40500c20a1851043b68709343f74c" ,
                                    timestamp ? "5be6cfe04c3e87a29ed30051f255ae0da5449e03a6b59aba5628f87ac3a06cd1664a3e578d65d03f1e312b7bf23f0a1e9ff40cd8d4670eb83bfea4ddda3ba70d"
                                } :
                                    let
                                        mapper =
                                            path : name : value :
                                                if builtins.typeOf value == "lambda" then
                                                    let
                                                        prepare =
                                                            let
                                                                cache = value temporary-scripts ;
                                                                temporary-scripts =
                                                                    temporary
                                                                        {
                                                                            at = at ;
                                                                            invalid-script-throw = invalid-script-throw ;
                                                                            invalid-temporary-throw = invalid-temporary-throw ;
                                                                            mask-reference = "/tmp/*.27aab8b58c44dd9fd9e4f2d642b1862c94a793c8" ;
                                                                            out = "b8130c9c6908f0c6bda2b92d8e145c537304412410ef9e86773688b0c3801869f1209a933f0f8dad4c900cfebcb37a986319a81e003ce7dc24c20249029dcf41" ;
                                                                            resource = "b7525e1989f7c9828bf8f80706fc2cb52d8af2127d9bdc07f09af5f93901236eae001d620466b59ced64156531715778c4a59ec713e797ebb9bbfa64d06966db" ;
                                                                            target = "c9288b6c7ba6701be9f06896c2af5d0402b8893b138ac810b84fbe70f041962a15e11251c9f55741ad4ea09f2f37f1570bdc579029e47c22a34fd14a89566344" ;
                                                                            temporary-resource-directory = "${ pkgs.coreutils }/bin/mktemp -t XXXXXXXX.27aab8b58c44dd9fd9e4f2d642b1862c94a793c8" ;
                                                                            temporary-broken-directory = "${ pkgs.coreutils }/bin/mktemp -t XXXXXXXX.4220e8baf832809cb6a27e0e5709ba4b8a94046b" '
                                                                        } ;
                                                                in
                                                                    ''
                                                                        export ${ timestamp }=${ environment-variable "${ timestamp }:=$( ${ pkgs.coreutils }/bin/date +%s )" } &&
                                                                            PARENT_HASH=${ environment-variable hash } &&
                                                                            ARGUMENTS=${ environment-variable "@" } &&]
                                                                            if ${ has-standard-input }
                                                                            then
                                                                                HAS_STANDARD_INPUT=true &&
                                                                                    STANDARD_INPUT=$( ${ pkgs.coreutils }/bin/tee ) &&
                                                                            else
                                                                                HAS_STANDARD_INPUT=false &&
                                                                                    STANDARD_INPUT=
                                                                            fi &&
                                                                            export ${ hash }=$( ${ pkgs.coreutils }/bin/echo $( ${ pkgs.coreutils }/bin/whoami ) $(( ${ environment-variable timestamp } / ${ builtins.toString cache.lifespan } )) ${ builtins.toString cache.provision } ${ environment-variable "ARGUMENTS" } ${ environment-variable "HAS_STANDARD_INPUT" } ${ environment-variable "STANDARD_INPUT" } ${ salt } | ${ pkgs.coreutils }/bin/sha512sum | ${ pkgs.coreutils }/bin/cut --bytes -128 ) &&
                                                                            if [ ! -d ${ directory }/${ environment-variable hash } ]
                                                                            then
                                                                                ${ pkgs.coreutils }/bin/mkdir ${ directory }/${ environment-variable hash } &&
                                                                                    ${ pkgs.coreutils }/bin/echo ${ environment-variable "ARGUMENTS" } > ${ directory }/${ environment-variable hash }/arguments.asc &&
                                                                                    ${ pkgs.coreutils }/bin/echo ${ environment-variable "HAS_STANDARD_INPUT" } > ${ directory }/${ environment-variable hash }/has-standard-input.asc &&
                                                                                    ${ pkgs.coreutils }/bin/echo ${ environment-variable "STANDARD_INPUT" } > ${ directory }/${ environment-variable hash }/standard-input.asc &&
                                                                                    ${ pkgs.coreutils }/bin/ln --symbolic ${ cache.provision } > ${ directory }/environment-variable hash }/provision.sh &&
                                                                                    ${ pkgs.coreutils }/bin/chmod 0400 ${ directory }/${ environment-variable hash }/arguments.asc ${ directory }/${ environment-variable hash }/has-standard-input.asc ${ directory }/${ environment-variable hash }/standard-input.asc
                                                                            fi &&
                                                                            ${ pkgs.coreutils }/bin/readlink ${ directory }/${ environment-variable hash }/link

                                                                    '' ;
                                                        maintain =
                                                            ''
                                                            '' ;
                                                        in pkgs.writeShellScript name prepare ;
                                                else if builtins.typeOf value == "set" then builtins.mapAttrs ( mapper ( builtins.concatLists [ path [ name ] ] ) ) value
                                                else builtins.throw ( invalid-cache-throw value ) ;
                                        in builtins.mapAttrs ( mapper [ ] ) cache ;
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

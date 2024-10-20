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
        { environment-variable-lib , flake-utils , has-standard-input-lib , nixpkgs , self , strip-lib , temporary-lib } :
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
                                    cache-broken-directory ? "${ pkgs.coreutils }/bin/mktemp --dry-run -t XXXXXXXX.68202bb7d407f0a83e8d1e63bbce51cca125b46c" ,
                                    directory ? "/tmp/1ec9efe065edf985cbc546e9d0267cdcb5c2b9bb" ,
                                    hash ? "aa6c893e3652ad06faf199905e41493b205651e539aeeaee8351c9e8d320411f9361f3b6e6246585c6c200196906093235add2db2bc01077ee7a2127fe23cad6" ,
                                    invalid-cache-throw ? value : "1c7b556a5015fb0e1f25cdc86a2263d67db1ec6a8a89e7b3d214ae71b210925da7aa33b1a3ab607df423397434d0d36c53a64e82ac4b1235feb61145c16bcec6 ${ builtins.typeOf value }" ,
                                    invalid-script-throw ? value : "c17bfd9b3387602ede2ec5616c9e00ae2b2e89e514e63995cd1e5c978aa1dc56b180f5e638e36f1ca64eabad2581075f53ddd7915c3590c87b50b086bba963fa ${ builtins.typeOf value }" ,
                                    invalid-temporary-throw ? value : "c40ec39bf3fd871f3742a8be6bb2f2a836018b6443658a418814c9cf49b6cba902bcc62b32936dff38ee3cc75da0aa68f49b65558617e67ca36c0fbe8e48e38d ${ builtins.typeOf value }" ,
                                    lock-error-code ? 65 ,
                                    preparation-error-code ? 66 ,
                                    salt ? "2bcb8318af769ce4d8543f546018a507a28b6f92f74f6bbc3fbd0d6e510619be962459dd430fad9d9065a38a13f823c1cad40500c20a1851043b68709343f74c" ,
                                    scripts ? secondary : { } ,
                                    secondary ? { } ,
                                    temporaryX ? { } ,
                                    timestamp ? "5be6cfe04c3e87a29ed30051f255ae0da5449e03a6b59aba5628f87ac3a06cd1664a3e578d65d03f1e312b7bf23f0a1e9ff40cd8d4670eb83bfea4ddda3ba70d"
                                } :
                                    let
                                        mapper =
                                            path : name : value :
                                                if builtins.typeOf value == "lambda" then
                                                    let
                                                        evict =
                                                            ''
                                                            ${ pkgs.findutils }/bin/find ${ environment-variable "BASE" } -mindepth 1 -maxdepth 1 -type f | while read HASH_FILE
                                                                do
                                                                    HASH=$( ${ pkgs.coreutils }/bin/cat ${ environment-variable "HASH_FILE" } ) &&
                                                                        ${ pkgs.inotify-tools }/bin/inotifywait --event delete_self ${ directory }/${ environment-variable "HASH" } &&
                                                                        ${ pkgs.coreutils }/bin/rm ${ environment-variable "HASH_FILE" }
                                                                done &&
                                                                ${ pkgs.findutils }/bin/find ${ environment-variable "BASE" } -mindepth 1 -maxdepth 1 -type f | while read PID_FILE
                                                                do
                                                                    PID=$( ${ pkgs.coreutils }/bin/cat ${ environment-variable "PID_FILE" } ) &&
                                                                        ${ pkgs.coreutils }/bin/tail --follow /dev/null --pid ${ environment-variable "PID" } &&
                                                                        ${ pkgs.coreutils }/bin/rm ${ environment-variable "PID_FILE" }
                                                                done &&
                                                                ${ pkgs.coreutils }/bin/rm --recursive --force ${ environment-variable "BASE" }
                                                            '' ;
                                                        invoke =
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
                                                                            scripts = scripts ;
                                                                            secondary = secondary ;
                                                                            temporary = temporaryX ;
                                                                            temporary-resource-directory = "${ pkgs.coreutils }/bin/mktemp -t XXXXXXXX.27aab8b58c44dd9fd9e4f2d642b1862c94a793c8" ;
                                                                            temporary-broken-directory = "${ pkgs.coreutils }/bin/mktemp -t XXXXXXXX.4220e8baf832809cb6a27e0e5709ba4b8a94046b" ;
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
                                                                                    PARENT_ID=$( ${ pkgs.ps }/bin/ps -o ppid= -p $( ${ pkgs.ps }/bin/ps -o ppid= -p ${ environment-variable "$" } ) )
                                                                            else
                                                                                HAS_STANDARD_INPUT=false &&
                                                                                    STANDARD_INPUT= &&
                                                                                    PARENT_ID=$( ${ pkgs.ps }/bin/ps -o ppid= -p ${ environment-variable "$" } )
                                                                            fi &&
                                                                            EXPIRY=$(( ( ${ builtins.toString cache.life } * ( ${ environment-variable timestamp } / ${ builtins.toString cache.life } ) ) + ${ builtins.toString cache.life } )) &&
                                                                            export ${ hash }=$( ${ pkgs.coreutils }/bin/echo $( ${ pkgs.coreutils }/bin/whoami ) ${ environment-variable "EXPIRY" } ${ builtins.hashString "sha512" ( builtins.concatStringsSep "-" ( builtins.concatLists [ path [ name cache.provision ( builtins.toString cache.life ) ( builtins.toString cache.force ) salt ] ] ) ) } ${ environment-variable "ARGUMENTS" } ${ environment-variable "HAS_STANDARD_INPUT" } ${ environment-variable "STANDARD_INPUT" } | ${ pkgs.coreutils }/bin/sha512sum | ${ pkgs.coreutils }/bin/cut --bytes -128 ) &&
                                                                            exec 200> ${ directory }/${ environment-variable hash }.lock &&
                                                                            if ${ pkgs.flock }/bin/flock 200
                                                                            then
                                                                                if [ ! -d ${ directory }/${ environment-variable hash } ]
                                                                                then
                                                                                    ${ pkgs.coreutils }/bin/mkdir ${ directory }/${ environment-variable hash } &&
                                                                                        ${ pkgs.coreutils }/bin/echo ${ environment-variable "ARGUMENTS" } > ${ directory }/${ environment-variable hash }/arguments.asc &&
                                                                                        ${ pkgs.coreutils }/bin/echo ${ environment-variable "HAS_STANDARD_INPUT" } > ${ directory }/${ environment-variable hash }/has-standard-input.asc &&
                                                                                        ${ pkgs.coreutils }/bin/echo ${ environment-variable "STANDARD_INPUT" } > ${ directory }/${ environment-variable hash }/standard-input.asc &&
                                                                                        ${ pkgs.coreutils }/bin/echo $(( ${ environment-variable "EXPIRY" } > ${ directory }/${ environment-variable hash }/expiry.asc &&
                                                                                        ${ pkgs.coreutils }/bin/echo ${ if cache.force then "true" else "false" } > ${ directory }/${ environment-variable hash }/force.asc &&
                                                                                        ${ pkgs.coreutils }/bin/ln --symbolic ${ cache.provision } ${ directory }/${ environment-variable hash }/provision.sh &&
                                                                                        ${ pkgs.coreutils }/bin/ln --symbolic ${ pkgs.writeShellScript "prepare" prepare } ${ directory }/${ environment-variable hash }/prepare.sh &&
                                                                                        ${ pkgs.coreutils }/bin/ln --symbolic ${ pkgs.writeShellScript "evict" evict } ${ directory }/${ environment-variable hash }/evict.sh &&
                                                                                        ${ pkgs.coreutils }/bin/chmod 0400 ${ directory }/${ environment-variable hash }/arguments.asc ${ directory }/${ environment-variable hash }/has-standard-input.asc ${ directory }/${ environment-variable hash }/standard-input.asc ${ directory }/${ environment-variable hash }/expiry.asc ${ directory }/${ environment-variable hash }/force.asc &&
                                                                                        ${ pkgs.coreutils }/bin/echo "${ directory }/${ environment-variable hash }/prepare.sh" | ${ at } now > /dev/null 2>&1 &&
                                                                                        ${ pkgs.inotify-tools }/bin/inotifywait --event create ${ directory }/${ environment-variable hash } &&
                                                                                        ${ pkgs.inotify-tools }/bin/inotifywait --event create ${ directory }/${ environment-variable hash } &&
                                                                                        ${ pkgs.inotify-tools }/bin/inotifywait --event create ${ directory }/${ environment-variable hash } &&
                                                                                        if [ $( ${ pkgs.coreutils }/bin/cat ${ directory }/${ environment-variable hash }/status.asc ) != 0 ]
                                                                                        then
                                                                                            ${ pkgs.coreutils }/bin/mv ${ directory }/${ environment-variable hash } $( ${ cache-broken-directory } ) &&
                                                                                                exit ${ builtins.toString preparation-error-code }
                                                                                        fi
                                                                                fi &&
                                                                                if [ ! -f ${ directory }/${ environment-variable hash }/${ environment-variable "PARENT_HASH" }.hash ]
                                                                                then
                                                                                    ${ pkgs.coreutils }/bin/echo ${ environment-variable "PARENT_HASH" } > ${ directory }/${ environment-variable hash }/${ environment-variable "PARENT_HASH" }.hash &&
                                                                                        ${ pkgs.coreutils }/bin/chmod 0400 ${ directory }/${ environment-variable hash }/${ environment-variable "PARENT_HASH" }.hash
                                                                                fi &&
                                                                                if [ ! -f ${ directory }/${ environment-variable hash }/${ environment-variable "PARENT_PID" }.pid ]
                                                                                then
                                                                                    ${ pkgs.coreutils }/bin/echo ${ environment-variable "PARENT_PID" } > ${ directory }/${ environment-variable hash }/${ environment-variable "PARENT_PID" }.pid &&
                                                                                        ${ pkgs.coreutils }/bin/chmod 0400 ${ directory }/${ environment-variable hash }/${ environment-variable "PARENT_PID" }.pid
                                                                                fi &&
                                                                                ${ pkgs.coreutils }/bin/readlink ${ directory }/${ environment-variable hash }/link
                                                                            else
                                                                                exit ${ builtins.toString lock-error-code }
                                                                            fi
                                                                    '' ;
                                                        prepare =
                                                            ''
                                                                BASE=$( ${ pkgs.coreutils }/bin/dirname ${ environment-variable 0 } ) &&
                                                                    if [ $( ${ pkgs.coreutils }/bin/cat ${ environment-variable "BASE" }/has-standard-input.asc ) == true ]
                                                                    then
                                                                        if ${ pkgs.coreutils }/bin/tee ${ environment-variable "BASE" }/standard-input.asc | ${ environment-variable "BASE" }/provision.sh ${ environment-variable "ARGUMENTS" } > ${ environment-variable "BASE" }/out 2> ${ environment-variable "BASE" }/err
                                                                        then
                                                                            STATUS=${ environment-variable "?" }
                                                                        else
                                                                            STATUS=${ environment-variable "?" }
                                                                        fi
                                                                    else
                                                                        if ${ environment-variable "BASE" }/provision.sh ${ environment-variable "ARGUMENTS" } > ${ environment-variable "BASE" }/out 2> ${ environment-variable "BASE" }/err
                                                                        then
                                                                            STATUS=${ environment-variable "?" }
                                                                        else
                                                                            STATUS=${ environment-variable "?" }
                                                                        fi
                                                                    fi &&
                                                                    ${ pkgs.coreutils }/bin/echo ${ environment-variable "STATUS" } > ${ environment-variable "BASE" }/status.asc &&
                                                                    ${ pkgs.coreutils }/bin/chmod 0400 ${ environment-variable "BASE" }/status.asc &&
                                                                    if [ ${ environment-variable "STATUS" } == 0 ]
                                                                    then
                                                                        ${ pkgs.coreutils }/bin/sleep $(( $( ${ pkgs.coreutils }/bin/cat ${ environment-variable "BASE" }/expiry.sh ) - $( ${ pkgs.coreutils }/bin/date +%s ) )) &&
                                                                            if [ -L ${ environment-variable "BASE" }/evict.sh ]
                                                                            then
                                                                                ${ environment-variable "BASE" }/evict.sh
                                                                            fi
                                                                    fi
                                                            '' ;
                                                        in pkgs.writeShellScript name invoke
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
                                                src = ./. ;
                                                installPhase =
                                                    let
                                                        resource =
                                                            lib
                                                                {
                                                                    at =
                                                                        pkgs.writeShellScript
                                                                            "at"
                                                                            ''
                                                                            '' ;
                                                                    cache = { } ;
                                                                    cache-broken-directory = "${ pkgs.coreutils }/bin/mktemp --dry-run -t XXXXXXXX.d9f62079fdb278a0cc34320b3ab49be1294c3fac" ;
                                                                    directory = "/tmp/328c9d7ba28416ac686ff86392fd1870763ff682" ;
                                                                    hash = "d52b8a8e6e8e5e36fdce2bcf2f620290dabebaaaef7b63b970ba89c7a5947c604078eb1913886d8c8eb2fec58f878951dd623e8adeb3435b1bca8cc62f8d448f" ;
                                                                    invalid-cache-throw = value : "c90d6874943e76a301596fb32145a3a472f40d89d91936398f1f06d0b02f1c0e93952f8b5abae1b27df04738fcfaf2ea8997929932369cb1475290cf6150f114 ${ builtins.typeOf value }" ;
                                                                    invalid-script-throw = value : "fd87768efd0728b1247349f41019a852c53b2cdc0d0bcff02ac09f939830db5bb15f2b135502a28cf8b0ff63517c3e617426cb259999b1f28c34a7eadc412fdc ${ builtins.typeOf value }" ;
                                                                    invalid-temporary-throw = value : "5179f769b99da50803c0c42a8606bba9aa657545d6f81b9f27f2dd5692d9e81e3a0d8e98ce0aca5d7b4a4cdcfeff2bb84898edd413788a5e36ce780ca9d1a4a6 ${ builtins.typeOf value }" ;
                                                                    lock-error-code = 75 ;
                                                                    preparation-error-code = 76 ;
                                                                    salt = "ad9f64392f6673cb7b30dd3b44a4c6acdd13ae507dbcc3998b62dd8a9f72c1199532598d261c374dc4073548fa8abd757ed714ce37b5f01b7aaac4bfe439cfa7" ;
                                                                    timestamp = "c9e48583e0eb029b6c6feeedf011cd26ae1fb5e6a7cf6ec6a06f263284e5a57217b71a32647e6dfc33b3d4ea275ff4c1e644d11de7bde89ac7edd60fff5ba1f8" ;
                                                                } ;
                                                        test =
                                                            ''
                                                                test ( )
                                                                    {
                                                                        ${ pkgs.coreutils }/bin/echo fail wtf
                                                                    }
                                                            '' ;
                                                        in
                                                            ''
                                                                export EXPECTED_DIRECTORY=$out &&
                                                                    ${ pkgs.coreutils }/bin/touch ${ environment-variable "EXPECTED_DIRECTORY" } &&
                                                                    export PATH=${ pkgs.coreutils }/bin:${ environment-variable "PATH" } &&
                                                                    ${ pkgs.bash_unit }/bin/bash_unit ${ pkgs.writeShellScript "test" test }
                                                            '' ;
                                            } ;
                                    lib = lib ;
                                } ;
                in flake-utils.lib.eachDefaultSystem fun ;
}

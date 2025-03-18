{
    inputs =
        {
            flake-utils.url = "github:numtide/flake-utils" ;
            nixpkgs.url = "github:NixOs/nixpkgs" ;
        } ;
    outputs =
        { flake-utils , nixpkgs , self } :
            let
                fun =
                    system :
                        let
                            lib =
                                {
                                    activation ? null ,
                                    duration ? 60 * 60 ,
                                    flock-error ? 66 ,
                                    initializer ? 67 ,
                                    post ? null ,
                                    standard-error ? 68 ,
                                    tests ? null
                                } :
                                    let
                                        primary =
                                            {
                                                activation =
                                                    if builtins.typeOf activation == "null" then activation
                                                    else if builtins.typeOf activation == "string" then activation
                                                    else builtins.throw "activation is not null, string but ${ builtins.typeOf activation }." ;
                                                duration = if builtins.typeOf duration == "int" then builtins.toString duration else builtins.throw "duration is not int but ${ builtins.typeOf duration }." ;
                                                flock-error = if builtins.typeOf flock-error == "int" then builtins.toString flock-error else builtins.throw "flock-error is not int but ${ builtins.typeOf flock-error }." ;
                                                initializer = if builtins.typeOf initializer == "int" then builtins.toString initializer else builtins.throw "initializer is not int but ${ builtins.typeOf initializer }." ;
                                                post =
                                                    if builtins.typeOf post == "null" then post
                                                    else if builtins.typeOf post == "string" then post
                                                    else builtins.throw "post is not null, string but ${ builtins.typeOf post }." ;
                                                standard-error = if builtins.typeOf standard-error == "int" then builtins.toString standard-error else builtins.throw "standard-error is not int but ${ builtins.typeOf standard-error }." ;
                                                tests =
                                                    if builtins.typeOf tests == "lambda" then tests
                                                    else if builtins.typeOf tests == "list" then tests
                                                    else if builtins.typeOf tests == "null" then tests
                                                    else if builtins.typeOf tests == "set" then tests
                                                    else builtins.throw "tests is not lambda, list, null, set but ${ builtins.typeOf tests }." ;
                                            } ;
                                        provision =
                                            activation : duration : post : host-path :
                                                let
                                                    evict =
                                                        pkgs.stdenv.mkDerivation
                                                            {
                                                                installPhase =
                                                                    let
                                                                        source =
                                                                            pkgs.stdenv.mkDerivation
                                                                                {
                                                                                    installPhase =
                                                                                        if builtins.typeOf post == "null" then
                                                                                            ''
                                                                                                ${ pkgs.gnused }/bin/sed -n -e "0,17p" -e "21,23p" ${ self + "/scripts/evict.sh" } > $out &&
                                                                                                    ${ pkgs.coreutils }/bin/chmod 0555 $out
                                                                                            ''
                                                                                        else
                                                                                            ''
                                                                                                ${ pkgs.gnused }/bin/sed -n -e "0,17p" -e "19,19p" -e "21,23p" ${ self + "/scripts/evict.sh" } > $out &&
                                                                                                    ${ pkgs.coreutils }/bin/chmod 0555 $ou
                                                                                            '' ;
                                                                                    name = "evict" ;
                                                                                    src =./. ;
                                                                                } ;
                                                                        in
                                                                            if builtins.typeOf post == "null" then
                                                                                ''
                                                                                    makeWrapper ${ source } $out --set CAT ${ pkgs.coreutils }/bin/cat --set FIND ${ pkgs.findutils }/bin/find --set FLOCK ${ pkgs.flock }/bin/flock --set HOST_PATH ${ host-path } --MKTEMP ${ pkgs.coreutils }/bin/mktemp --set MV ${ pkgs.coreutils }/bin/mv --set RM ${ pkgs.coreutils }/bin/rm --set TAIL ${ pkgs.coreutils }/bin/tail
                                                                                ''
                                                                            else
                                                                                ''
                                                                                    makeWrapper ${ source } $out --set CAT ${ pkgs.coreutils }/bin/cat --set FIND ${ pkgs.findutils }/bin/find --set FLOCK ${ pkgs.flock }/bin/flock --set HOST_PATH ${ host-path } --MKTEMP ${ pkgs.coreutils }/bin/mktemp --set MV ${ pkgs.coreutils }/bin/mv --set POST ${ post } --set RM ${ pkgs.coreutils }/bin/rm --set TAIL ${ pkgs.coreutils }/bin/tail --set TRUE ${ pkgs.coreutils }/bin/true
                                                                                '' ;
                                                                name = "evict" ;
                                                                src = ./. ;
                                                            } ;
                                                    keep =
                                                        pkgs.stdenv.mkDerivation
                                                            {
                                                                installPhase =
                                                                    let
                                                                        source =
                                                                            pkgs.stdenv.mkDerivation
                                                                                {
                                                                                    installPhase =
                                                                                        if builtins.typeOf activation == "null" then
                                                                                            ''
                                                                                                ${ pkgs.gnused }/bin/sed -n -e "1,3p" -e "18,18p" -e "20,25p" ${ self + "/scripts/keep.sh" } > $out &&
                                                                                                    ${ pkgs.coreutils }/bin/chmod 0555 $out
                                                                                            ''
                                                                                        else
                                                                                            ''
                                                                                                ${ pkgs.gnused }/bin/sed -n -e "1,3p" -e "5,15p" -e "20,25p" ${ self + "/scripts/keep.sh" } > $out &&
                                                                                                    ${ pkgs.coreutils }/bin/chmod 0555 $out
                                                                                            '' ;
                                                                                    name = "keep" ;
                                                                                    src = ./. ;
                                                                                } ;
                                                                        in
                                                                            if builtins.typeOf activation == "null" then
                                                                                ''
                                                                                    makeWrapper ${ source } $out --set ECHO ${ pkgs.coreutils }/bin/echo --set HOST_PATH ${ host-path } --set INOTIFY_WAIT ${ pkgs.inotify-tools }/bin/inotify-wait --set RM ${ pkgs.coreutils }/bin/rm
                                                                                ''
                                                                            else
                                                                                ''
                                                                                    makeWrapper ${ source } $out --set ACTIVATION ${ activation } --set ECHO ${ pkgs.coreutils }/bin/echo --set HOST_PATH ${ host-path } --set INOTIFY_WAIT ${ pkgs.inotify-tools }/bin/inotify-wait --set LN ${ pkgs.coreutils }/bin/ln --set RM ${ pkgs.coreutils }/bin/rm
                                                                                '' ;
                                                                name = "keep" ;
                                                                src = ./. ;
                                                            } ;
                                                    in
                                                        pkgs.stdenv.mkDerivation
                                                            {
                                                                installPhase =
                                                                    let
                                                                        source =
                                                                            pkgs.stdenv.mkDerivation
                                                                                {
                                                                                    installPhase =
                                                                                        ''
                                                                                            ${ pkgs.coreutils }/bin/cat ${ self + "/scripts/provision.sh" } > $out &&
                                                                                                ${ pkgs.coreutils }/bin/chmod 0555 $out
                                                                                        '' ;
                                                                                    name = "provision" ;
                                                                                    src = ./. ;
                                                                                } ;
                                                                        in
                                                                            ''
                                                                                ${ pkgs.coreutils }/bin/mkdir $out &&
                                                                                    ${ pkgs.coreutils }/bin/mkdir $out/bin &&
                                                                                    makeWrapper provision  $out/bin/cache --set CUT ${ pkgs.coreutils }/bin/cut --set DURATION ${ duration } --set ECHO ${ pkgs.coreutils }/bin/echo --set FLOCK ${ pkgs.flock }/bin/flock --set HOST_PATH ${ host-path } --set INOTIFY_WAIT ${ pkgs.inotify-tools }/bin/inotify-wait --set KEEP ${ keep }--set MAKE_WRAPPER ${ pkgs.makeWrapper } --set MAKE_WRAPPER_EVICT ${ evict } --set PREHASH ${ builtins.hashString "sha512" ( builtins.concatStringsSep "" ( builtins.map builtins.toJSON [ activation duration post host-path ] ) ) } --set READLINK ${ pkgs.coreutils }/bin/readlink --set SHA512SUM ${ pkgs.coreutils }/bin/sha512sum --set TOUCH ${ pkgs.coreutils }/bin/touch
                                                                            '' ;
                                                                name = "provision" ;
                                                                src = ./. ;
                                                            } ;
                                        in
                                            {
                                                cache = provision primary.activation primary.duration primary.post ;
                                            } ;
                            pkgs = builtins.import nixpkgs { system = system ; } ;
                            in
                                {
                                    checks =
                                        {
                                            foobar =
                                                pkgs.stdenv.mkDerivation
                                                    {
                                                        installPhase =
                                                            let
                                                                cache =
                                                                    lib
                                                                        {
                                                                            activation = null ;
                                                                            duration = 10 ;
                                                                            flock-error = 69 ;
                                                                            initializer = 70 ;
                                                                            post = null ;
                                                                            standard-error = 71 ;
                                                                            tests = null ;
                                                                        } ;
                                                                in
                                                                    ''
                                                                        ${ pkgs.coreutils }/bin/mkdir $out &&
                                                                            ${ pkgs.coreutils }/bin/echo ${ cache.cache "/tmp" }
                                                                            exit 64
                                                                    '' ;
                                                        name = "foobar" ;
                                                        src = ./. ;
                                                    } ;
                                        } ;
                                    lib = lib ;
                                } ;
                in flake-utils.lib.eachDefaultSystem fun ;
}
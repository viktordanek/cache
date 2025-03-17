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
                                    at ? "/run/wrappers/bin/at" ,
                                    duration ? 60 * 60 ,
                                    initializer ? 66 ,
                                    post ? null ,
                                    standard-error ? 67 ,
                                    tests ? null
                                } :
                                    let
                                        primary =
                                            {
                                                activation =
                                                    if builtins.typeOf activation == "null" then activation
                                                    else if builtins.typeOf activation == "string" then activation
                                                    else builtins.throw "activation is not null, string but ${ builtins.typeOf activation }." ;
                                                at = if builtins.typeOf at == "string" then at else builtins.throw "at is not string but ${ builtins.typeOf at }." ;
                                                duration = if builtins.typeOf duration == "int" then builtins.toString duration else builtins.throw "duration is not int but ${ builtins.typeOf duration }." ;
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
                                        in { } ;
                            in
                                {
                                    lib = lib ;
                                } ;
                in flake-utils.lib.eachDefaultSystem fun ;
}
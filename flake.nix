{
    inputs =
        {
            environment-variable.url = "github:/viktordanek/environment-variable" ;
            flake-utils.url = "github:numtide/flake-utils" ;
            nixpkgs.url = "github:NixOs/nixpkgs" ;
            shell-script.url = "github:viktordanek/shell-script/scratch/b6bb8f5b-7d48-4542-810c-58b5e36a3b0a" ;
            visitor.url = "github:viktordanek/visitor/scratch/1bd1c881-b72b-43d7-a819-f6072a9dfdf7" ;
        } ;
    outputs =
        { environment-variable , flake-utils , nixpkgs , self , shell-script , visitor } :
            let
                fun =
                    system :
                        let
                            _environment-variable = builtins.getAttr system environment-variable.lib ;
                            _shell-script = builtins.getAttr system shell-script.lib ;
                            _visitor = builtins.getAttr system visitor.lib ;
                            lib =
                                {
                                    init ,
                                    lifespan ? 60 60 ,
                                    name ,
                                    resources ? "RESOURCES" ,
                                    self-teardown ? true
                                } :
                                    let
                                        primary =
                                            {
                                                init =
                                                    if builtins.typeOf init == "string" then init
                                                    else builtins.throw "init is not string but ${ builtins.typeOf init }." ;
                                            } ;
                                        in
                                            {

                                            } ;
                            pkgs = builtins.import nixpkgs { system = system ; } ;
                            in
                                {
                                    apps = { } ;
                                    checks = { } ;
                                    lib = lib ;
                                } ;
                in flake-utils.lib.eachDefaultSystem fun ;
}
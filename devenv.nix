{
  pkgs,
  lib,
  config,
  inputs,
  ...
}:

{
  # https://devenv.sh/basics/
  env.GREET = "devenv";
  env.AIRFLOW_HOME = "${config.env.DEVENV_ROOT}/airflow";
  env.PYTHONUNBUFFERED = "1";

  # https://devenv.sh/packages/
  packages = [ pkgs.git pkgs.mprocs];

  languages = {
    # https://devenv.sh/languages/python/
    python = {
      enable = true;
      version = "3.13";
      venv = {
        enable = true;
        requirements = "./requirements.txt";
      };
    };
  };

  process.manager.implementation = "mprocs";
  # https://devenv.sh/languages/
  # languages.rust.enable = true;

  # https://devenv.sh/processes/
  # processes.dev.exec = "${lib.getExe pkgs.watchexec} -n -- ls -la";

  # https://devenv.sh/services/
  # services.postgres.enable = true;

  # https://devenv.sh/scripts/
  scripts.hello.exec = ''
    echo hello from $GREET
  '';

  # https://devenv.sh/basics/
  enterShell = ''
    echo $AIRFLOW_HOME
  '';

  processes = {
    scheduler = {
      exec = "airflow scheduler";
      cwd = "./airflow";
    };

    webserver = {
      exec = "airflow api-server --port 8080";
      cwd = "./airflow";
    };

    dagprocessor = {
      exec = "airflow dag-processor";
      cwd = "./airflow";
    };

    triggerer = {
      exec = "airflow triggerer";
      cwd = "./airflow";
    };
  };

  # https://devenv.sh/tasks/
  # tasks = {
  #   "myproj:setup".exec = "mytool build";
  #   "devenv:enterShell".after = [ "myproj:setup" ];
  # };

  tasks = {
    "airflow:install".exec = ''
      pip install -r requirements.txt;
      airflow db migrate;
    '';
    "airflow:uninstall".exec = ''
      pip freeze | xargs pip uninstall -y;
      rm -rf ${config.env.AIRFLOW_HOME};'';
  };

  # https://devenv.sh/tests/
  enterTest = ''
    echo "Running tests"
    git --version | grep --color=auto "${pkgs.git.version}"
  '';

  # https://devenv.sh/git-hooks/
  # git-hooks.hooks.shellcheck.enable = true;

  # See full reference at https://devenv.sh/reference/options/
}

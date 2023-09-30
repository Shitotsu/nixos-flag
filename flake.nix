{
  apps = rec {
    default = runme;

    runme = {
      type = "app";
      program = "/flag";
    };
  };
}

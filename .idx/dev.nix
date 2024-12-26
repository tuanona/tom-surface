{pkgs, ... }: {
  channel = "stable-24.05";
  packages = [
    pkgs.nodejs_22
    pkgs.yarn
    pkgs.typescript
    pkgs.docker-compose
  ];

  # Services in idx to turn on
  services.docker.enable = true;
  idx.extensions = [
    "esbenp.prettier-vscode"
    "bradlc.vscode-tailwindcss"
  ];
  
}
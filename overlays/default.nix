# This file defines overlays
{inputs, ...}: {
  # This one brings our custom packages from the 'pkgs' directory
  additions = final: _prev: import ../pkgs final.pkgs;

  # This one contains whatever you want to overlay
  # You can change versions, add patches, set compilation flags, anything really.
  # https://nixos.wiki/wiki/Overlays
  modifications = final: prev: {
    pythonPackagesExtensions =
      prev.pythonPackagesExtensions
      ++ [
        (python-final: python-prev: {
          # torch = python-prev.torch.override {
          #   cudaSupport = false;
          #   rocmSupport = false;
          # };
          # triton = python-prev.triton.override {
          #   cudaSupport = false;
          #   rocmSupport = false;
          # };
        })
      ];
  };
}

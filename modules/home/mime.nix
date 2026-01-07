{ ... }: {
    config = {
        xdg.mimeApps = {
            enable = true;
            defaultApplications = {
                "image/png" = "imv-dir";
                "image/jpeg" = "imv-dir";
                "image/jpg" = "imv-dir";
                "image/gif" = "imv-dir";
                "image/bmp" = "imv-dir";
            };
        };
    };
}
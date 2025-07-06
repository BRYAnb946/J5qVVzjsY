schema_version = 1

project {
  license        = "MPL-2.0"
  copyright_year = 2017
  # Supports doublestar glob patterns for more flexibility in defining which
  # files or folders should be ignored
    # Some ignores here are not strictly needed, but protects us if we change the types of files we put in those folders
    # See here for file extensions altered by copywrite CLI (all other extensions are ignored)
    # https://github.com/hashicorp/copywrite/blob/4af928579f5aa8f1dece9de1bb3098218903053d/addlicense/main.go#L357-L394
    "examples/**",
    "google/**/test-fixtures/**",
    ".goreleaser.yml",
  ]
  upstream = "GoogleCloudPlatform/magic-modules"
}
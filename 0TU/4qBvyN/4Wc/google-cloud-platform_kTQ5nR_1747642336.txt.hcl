schema_version = 1
project {
  copyright_year = 2017
  # Supports doublestar glob patterns for more flexibility in defining which
  # files or folders should be ignored
    # Some ignores here are not strictly needed, but protects us if we change the types of files we put in those folders
    "google/**/test-fixtures/**",
  ]
  upstream = "GoogleCloudPlatform/magic-modules"
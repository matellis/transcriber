# Transcriber

Command line audio to text transcriber for macOS

## Workstation Setup

```bash
# Install Homebrew, and ensure it's configured properly before proceeding.

brew install rbenv rbenv-gemset rbenv-binstubs

# Make sure rbenv is configured properly before proceeding.

rbenv install $(cat .ruby-version)

rbenv rehash
```

## Working With the Project

__NOTE: Be sure to open `Transcriber.xcworkspace`, not `Transcriber.xcodeproj`, or your builds will fail!__

Some tasks are available via Rake.  Run `rake -T` to see them.

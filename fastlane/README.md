fastlane documentation
----

# Installation

Make sure you have the latest version of the Xcode command line tools installed:

```sh
xcode-select --install
```

For _fastlane_ installation instructions, see [Installing _fastlane_](https://docs.fastlane.tools/#installing-fastlane)

# Available Actions

## iOS

### ios screenshots

```sh
[bundle exec] fastlane ios screenshots
```

Gera screenshots em todos os idiomas e dispositivos configurados no Snapfile

### ios flutter_screenshots

```sh
[bundle exec] fastlane ios flutter_screenshots
```

Gera todos os screenshots via Flutter widget tests

### ios flutter_mockup_screenshots

```sh
[bundle exec] fastlane ios flutter_mockup_screenshots
```

Gera apenas os screenshots com mockup (bg + título + frame)

### ios upload_metadata

```sh
[bundle exec] fastlane ios upload_metadata
```

Envia apenas os textos da loja (sem screenshots, sem binário)

### ios upload_screenshots

```sh
[bundle exec] fastlane ios upload_screenshots
```

Envia screenshots plain (sem frame) para o App Store Connect

### ios take_screenshot_upload

```sh
[bundle exec] fastlane ios take_screenshot_upload
```

Gera screenshots com mockup e sobe para o App Store Connect

### ios release_metadata

```sh
[bundle exec] fastlane ios release_metadata
```

Gera screenshots via Flutter tests e sobe metadata + screenshots para o App Store Connect

----

This README.md is auto-generated and will be re-generated every time [_fastlane_](https://fastlane.tools) is run.

More information about _fastlane_ can be found on [fastlane.tools](https://fastlane.tools).

The documentation of _fastlane_ can be found on [docs.fastlane.tools](https://docs.fastlane.tools).

# uuid_helper

[![pub package](https://img.shields.io/pub/v/uuid_helper.svg)](https://pub.dartlang.org/packages/uuid_helper) [![Licence](https://img.shields.io/github/license/nullptrX/uuid_helper)](https://github.com/nullptrX/uuid_helper/blob/master/LICENSE)
https://travis-ci.org/Daegalus/dart-uuid
## Introduction

A flutter plugin for generating a unique id

## Getting Started

### Instructions 

1. Open a command line and cd to your projects root folder
2. In your pubspec, add an entry for uuid_helper to your dependencies (example below)
3. pub install


### Pubspec 

```yaml
dependencies:
  uuid_helper: latest
```



```dart
import 'package:uuid_helper/uuid_helper.dart';

var uuid = await UUIDHelper.getUniqueId();
```



Just like as `10550fe1-849e-4bc9-8a6d-b4c78e010cb1`.



On Android, It implemented by `MediaDrm` and `PsuedoID`.

On iOS, It implemented by `KeyChains`.
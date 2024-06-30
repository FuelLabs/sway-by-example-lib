# Imports

Examples of imports in Sway

```sway
{{#include ../examples/imports/src/main.sw}}
```

## Project Structures

### Internal

```bash

└── imports
    ├── Forc.toml
    └── src
        ├── imports_library.sw
        └── main.sw

```

### External

```bash

├── imports
│   ├── Forc.toml
│   └── src
│       ├── imports_library.sw
│       └── main.sw
└── math_lib
    ├── Forc.toml
    └── src
        ├── Q64x64.sw
        ├── full_math.sw
        └── math_lib.sw

```

All external imports must be defined as dependencies within `Forc.toml`

```toml
{{#include ../examples/imports/Forc.toml}}
```
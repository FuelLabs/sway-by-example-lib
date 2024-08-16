# Script

Examples of a script program type in Sway

|                                | Predicates | Scripts  |
|--------------------------------|------------|-----------|
| Access data on chain           |      ❌     |     ✅     |
| Read data from smart contracts |      ❌     |     ✅     |
| Check date or time             |      ❌     |     ✅     |
| Read block hash or number      |      ❌     |     ✅     |
| Read input coins               |      ✅     |     ✅     |
| Read output coins              |      ✅     |     ✅     |
| Read transaction scripts       |      ✅     |     ✅     |
| Read transaction bytecode      |      ✅     |     ✅     |

```sway
{{#include ../examples/script/src/main.sw}}
```

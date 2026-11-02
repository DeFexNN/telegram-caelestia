# Changes against Telegram Desktop 7.3.3

The source of truth is [`patches/caelestia.patch`](../patches/caelestia.patch), generated from the 7.3.3 full release. The package also replaces the built-in night-green theme with the modified archive in `patches/`.

| Area | Changes represented in the patch |
| --- | --- |
| Dialog list | Animated focus card, rounded row styling, scroll cache changes and an experimental performance overlay. |
| Navigation | Animated filter tabs and slider changes, including a stretched moving indicator. |
| Chat | Revised compose field, quote and message styling; changes to voice recording, document and reaction views. |
| Motion | Adjusted transitions in panels, layers, window slides, menus, fields, scrolling and sliders. |
| Theme | Modified built-in night-green theme; the original is supplied separately. |

These describe code present in the patch, not a guarantee that every interaction is complete or regression-free. The Motion Lab is a separate design prototype: its 24 concepts are not a list of shipped features. Review the patch itself for exact implementation details.

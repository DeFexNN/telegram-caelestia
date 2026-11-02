# Profiling and known limitations

The current dialog-list patch contains an experimental on-screen HUD and appends to `/tmp/telegram_anim_perf.log` during relevant paint, animation, scroll and filter-switch events. It is enabled in the patch as shipped. The log includes timing and filter identifiers and is not rotated; remove it when no longer needed. Multiple runs can append to the same file. Synchronous per-event writes and flushing can themselves affect the measurements.

The displayed FPS is derived from time between paint events, not a compositor presentation timestamp. The HUD labels refer to 120 Hz and the dropped-frame counter uses a fixed 12 ms threshold; neither establishes the actual monitor refresh rate. Paint timing excludes parts of rendering outside the measured section. The reported 1% low comes from collected animation frame deltas and is not a general application-wide benchmark. Treat the output as a debugging signal, not a verified performance result.

## Suggested comparison

1. Build upstream 7.3.3 and the patched version with the same compiler, flags and dependencies. Record the commit, build configuration, hardware, compositor, scaling and display refresh rate.
2. Use the same representative local test data and repeat chat-list scrolling, filter switching and opening a chat. Allow a warm-up period and collect several runs for each build.
3. Capture frame timing with a compositor-aware profiler as well as CPU samples (for example Linux `perf`, where available). Compare distributions and CPU time, not a single peak FPS. Separate measurements with and without diagnostic logging; upstream and patched code need equivalent instrumentation for a fair comparison.
4. Record the commands, raw traces and summary alongside the scenario. Avoid publishing private chat data or identifiers.

No controlled baseline, profiler traces or speedup claims are currently supplied. The built-in HUD adds overhead, so removing or gating it is a prerequisite for trustworthy release measurements.

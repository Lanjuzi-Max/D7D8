# D7 / D8 LEO model-service migration experiments

This repository contains the source code, reports, and selected reproducibility artifacts for the D7 two-deadline counterexample experiments and D8 queue-observation ablation.

## D7 — independent coverage and path deadlines
- Compare fixed STOP, latest-feasible STOP, queue rule, and rolling planning in synthetic scenarios.
- Core model and runners: `D7/`
- Reports and aggregate result tables: `D7/results/`

## D8 — queue information ablation
- Tests whether exposing queue length / request slack adds value beyond the common migration-feasibility guard.
- Core model and runners: `D8/`
- Reports and aggregate result tables: `D8/results/`

## Scientific status
These are synthetic mechanism-exploration experiments, not satellite performance guarantees and not proof of novelty. Queue observation has not shown stable advantage over a tuned latest-feasible baseline. D7/D8 use synthetic parameters; Qwen3 KV-cache and real link goodput calibration remain separate follow-up work.

## Run
Python 3.12 standard library is sufficient for the experiment code and tests. See each task's README for commands.

## Artifact note
The repository stores source, reports, manifests, aggregate/paired summaries, and selected audit outputs. Large repeated per-run CSVs and duplicate smoke-test outputs from the local ZIP bundles are not mirrored here; the original ZIPs remain the canonical full archival bundles in the originating ChatGPT session.

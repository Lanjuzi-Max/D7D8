# D7 / D8 LEO model-service migration experiments

This repository is the handoff location for D7 (separate coverage/path deadlines) and D8 (queue-observation ablation).

## Currently in this repository
- `D7/README.md` and `D7/RESULTS_AND_DECISION.md`: experiment setup and reported findings.
- `D8/README.md` and `D8/RESULTS_AND_DECISION.md`: ablation setup and reported findings.

## Upload status
The documentation and summarized result tables described in the task reports have been added. **The complete source-code ZIP archives, full per-run CSVs, and test files have not yet been uploaded to this repository.** The local ZIPs remain the complete archival bundles; use the ChatGPT task links to download them, or upload them from a local terminal as described below.

## Local upload of the complete ZIPs
After downloading the D7 and D8 ZIPs from the ChatGPT conversation, place them in one local folder and run:

```powershell
git clone https://github.com/Lanjuzi-Max/D7D8.git
cd D7D8
New-Item -ItemType Directory -Force packages | Out-Null
Copy-Item ..\D7_Texit_Tpath_experiment.zip packages\D7_Texit_Tpath_experiment.zip
Copy-Item ..\D8_queue_ablation_experiment.zip packages\D8_queue_ablation_experiment.zip
git add packages
git commit -m "Add D7 and D8 experiment archives"
git push origin main
```

If your ZIP files are stored elsewhere, replace the two source paths with their actual locations. Git must be configured and authenticated for your GitHub account. These archives are small enough for ordinary Git; do not commit model weights or large unrelated data.

## Scientific status
These are synthetic mechanism-exploration experiments, not satellite performance guarantees and not proof of novelty. Queue observation has not shown stable advantage over a tuned latest-feasible baseline. D7/D8 use synthetic parameters; Qwen3 KV-cache and real link-goodput calibration remain separate follow-up work.

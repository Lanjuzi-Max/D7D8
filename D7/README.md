# D7: T_exit and T_path Minimal Counterexample

This task separates source coverage exit T_exit=12 s from inter-satellite state-transfer cutoff T_path=10/14 s. It compares tuned fixed STOP, latest-feasible online, queue rule, rolling planning, and an offline full-trace oracle.

## Run
```powershell
python d7_sanity.py --output-dir outputs/d7_rerun --train-seeds 20 --test-seeds 50
python run_d7_sensitivity.py --output-dir outputs/d7_sensitivity_rerun --train-seeds 10 --test-seeds 30
python run_d7_boundary_sweep.py --output-dir outputs/d7_boundary_rerun --train-seeds 20 --test-seeds 30
python analyze_d7_results.py
python -m unittest -v
```

## Read first
- `RESULTS_AND_DECISION.md`: conclusions and limitations.
- `results/policy_summary.csv`: policy means.
- `results/pairwise_ci.csv`: paired bootstrap intervals.
- `results/boundary_summary.csv`: T_path boundary sweep.

## Limitations
All state sizes, link rates, arrivals, and service times are synthetic. This is mechanism exploration, not satellite performance validation or proof of novelty.
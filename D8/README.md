# D8: Queue-Length Observation Ablation (follows D7)

Python 3.12 standard library. Tests whether exposing ingress queue length improves STOP decisions under the synthetic double-window model.

## Test
```powershell
python -m unittest discover -p "test_*.py" -v
```

## Reproduce extended grid
```powershell
python run_d8_queue_ablation.py --train 20 --holdout 50 --output-dir outputs/reproduce_extended
```

## Fresh confirmation using selected parameters
```powershell
python run_d8_confirmation.py --selected-parameters outputs/reproduce_extended/selected_parameters.csv --output-dir outputs/reproduce_confirmation --seeds 200 --seed-start 30000
```

The current conclusion is that queue-length observation did not reliably improve over latest-feasible after extending the STOP tuning grid. This is an ablation of the additional len(ingress) gate, not a complete removal of all queue information. All values are synthetic.
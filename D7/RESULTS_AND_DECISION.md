# D7 Results and Research Decision

Date: 2026-10-26. All migration, link, and request parameters are synthetic; this does not establish satellite performance or paper novelty.

## Scenario
T_exit=12 s; target user reachability starts at 8 s. T_path=10 s (link closes before coverage exit) or 14 s (after). Target model weights are assumed preinstalled; only growing session state is transferred. Synthetic state: 700 MB initial, 80 MB/s transfer, 30 MB/s growth. Poisson arrivals at 0.4/0.8/1.4 requests/s; service time U[0.3,1.0] s; SLA 3 s; time step 0.1 s.

## Main test results (mean request loss)
| T_path | Arrival rate | Tuned fixed STOP | Latest feasible | Queue rule | Rolling planning | Oracle |
|---:|---:|---:|---:|---:|---:|---:|
| 10 s | 0.4 | 19.57% | 3.73% | 4.39% | 3.73% | 3.73% |
| 10 s | 0.8 | 49.74% | 32.09% | 33.23% | 32.09% | 32.09% |
| 10 s | 1.4 | 83.32% | 73.42% | 74.19% | 73.42% | 73.42% |
| 14 s | 0.4 | 0.00% | 0.00% | 1.91% | 0.00% | 0.00% |
| 14 s | 0.8 | 3.81% | 2.87% | 14.97% | 2.87% | 2.87% |
| 14 s | 1.4 | 46.07% | 34.33% | 43.23% | 34.40% | 34.40% |

Latest-feasible improves over tuned fixed STOP most clearly when T_path=10 s and state-transfer pressure is high. Queue rule and rolling planning do not show stable additional benefit over latest-feasible. Oracle is offline and cannot be ranked as deployable.

## Boundary sweep
T_exit=12 s; T_path in {9,10,11,13,14,15}; arrival rates 0.4/0.8/1.4. At T_path=9 s, losses can approach 100% under high load. At T_path=10–11 s, differences are largest. Results for T_path=13/14/15 are identical because the model requires target activation before T_exit=12 s.

## Oracle ablation
Removing state-transfer constraints changes the offline best STOP in all 50 test traces when T_path=10 s (mean absolute STOP movement 3.07–7.12 s), but not universally when T_path=14 s. Removing queue-wait loss changes some offline decisions but does not prove an online queue-aware policy helps.

## Decision
Keep double-window feasibility as a candidate mechanism; do not claim novelty or design a new algorithm yet. Recalibrate state size/growth and link goodput with real measurements, then compare latest-feasible against fully tuned baselines. All figures are synthetic and do not represent real satellite/LLM performance.
# D8: Strict Queue-Length Observation Ablation — Results

Date: 2026-10-26. Conclusion: after widening the STOP tuning grid, no evidence shows that additional queue-length observation reliably improves the strong baseline in the tested synthetic scenarios.

## Model
T_exit=12 s, T_target_on=8 s, T_path in {10,11,13} s. Arrival rates 0.8/1.4/2.0 requests/s; synthetic service time U[0.3,1.0] s; SLA 3 s; initial session state 700 MB; link 80 MB/s; state growth 30 MB/s. None are real satellite or KV-cache measurements.

## Fresh confirmation (seeds 30000–30199): mean request loss
| T_path (s) | Arrival (req/s) | Queue visible tuned | Queue masked tuned | Latest-feasible | Tuned fixed STOP |
|---:|---:|---:|---:|---:|---:|
| 10 | 0.8 | 30.83% | 30.83% | 30.83% | 53.24% |
| 10 | 1.4 | 76.60% | 76.60% | 76.60% | 87.03% |
| 10 | 2.0 | 87.96% | 87.96% | 87.96% | 91.53% |
| 11 | 0.8 | 8.92% | 8.92% | 8.92% | 27.22% |
| 11 | 1.4 | 54.57% | 54.57% | 54.57% | 68.97% |
| 11 | 2.0 | 78.61% | 78.61% | 78.61% | 81.46% |
| 13 | 0.8 | 2.32% | 2.32% | 2.37% | 4.95% |
| 13 | 1.4 | 37.95% | 37.87% | 37.95% | 51.78% |
| 13 | 2.0 | 71.09% | 71.09% | 71.09% | 74.80% |

At T_path=10 and 11 s, visible and masked policies were identical. At T_path=13 s, differences were negligible; at arrival 1.4 req/s, visible was 0.073 percentage points worse than masked. Eight of nine configurations matched latest-feasible exactly; the remaining difference was tiny.

## Important scope limit
Both branches share the D7 safety guard. That guard still uses parts of the queue-related state transition, including whether a pending task is dispatched and its known workload. Thus this is an ablation of the *additional queue-length gate*, not all queue information or request slack.

## Decision
Do not develop a queue-aware algorithm yet. Next priorities: measure real Qwen KV-cache size/growth, establish plausible link-window ranges, then re-run latest-feasible against tuned fixed baselines. These results are synthetic mechanism evidence only, not satellite performance guarantees or proof of novelty.
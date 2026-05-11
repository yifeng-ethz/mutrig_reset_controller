# BUG_HISTORY.md - mutrig_reset_controller history ledger

Class legend:
- `R` = RTL / DUT bug
- `H` = harness / testcase / reporting bug

Severity legend:
- `non-datapath-refactor` = observability, reporting, contract refactor with no direct datapath effect

Encounterability legend:
- `directed-only` = requires targeted audit, formal/probe flow, or another non-operational stimulus

## Index

| bug_id | class | severity | encounterability | status | first seen | commit | summary |
|---|---|---|---|---|---|---|---|
| [BUG-001-R](#bug-001-r-runcontrol-sink-still-declared-asi-runcontrol-ready-against-the-rc-network-readyless-contract) | R | non-datapath-refactor | `directed-only (Qsys auto-inserts timing_adapter on rc fan-out)` | fixed | FEB v3 integration audit `tb_int_run_emulator_directed` | this commit | The `runcontrol` sink still declared `asi_runcontrol_ready` so Qsys auto-inserted `altera_avalon_st_timing_adapter` on the rc fan-out, carrying the B002 ready-default hazard on silicon. |

## 2026-05-11

### BUG-001-R: runcontrol sink still declared asi_runcontrol_ready against the rc-network readyless contract

- First seen:
  - FEB v3 integration audit during the rc-readyless rollout
  - Hub `runctl_mgmt_host._hw.tcl` advertises `USE_READY=0` for the broadcast `runctl` source; every sink that still declared `asi_*_ready` caused Qsys to silently auto-insert `altera_avalon_st_timing_adapter` on the rc fan-out
  - The timing_adapter is the structural carrier of the B002 ready-default hazard already documented for the FEB SC plane
- Symptom:
  - `mutrig_reset_controller.runcontrol` still exposed `asi_runcontrol_ready` on the entity boundary even though the hub source has no ready signal
  - Qsys-generated `feb_system_v3_data_path_subsystem_*` wrappers wired through an auto-inserted `timing_adapter` instance on the rc path
- Root cause:
  - The Avalon-ST sink interface contract is "readyless" only when both ends declare `USE_READY=0`. `mutrig_reset_controller` was still on the legacy backpressured-rc form, and the TODO line inside the run-management FSM only drove `asi_runcontrol_ready <= '1';` as a placeholder.
- Fix status:
  - state:
    - fixed
  - mechanism:
    - Removed the `asi_runcontrol_ready` entity port from `mutrig_reset_controller.vhd` and the matching `add_interface_port` line from `mutrig_reset_controller_hw.tcl`
    - Removed the TODO assignment `asi_runcontrol_ready <= '1';` from the run-management FSM body
    - Bumped `VERSION` 1.0.8 -> 1.1.0
  - after_fix_outcome:
    - FEB v3 Qsys regeneration produced `feb_system_v3.vhd` with the `mutrig_reset_controller_0` instance wired with `asi_runcontrol_valid` only, no paired ready wire
    - `tb_int` regression passed: `B065`, `B066`, `B067`, `B068`, `B069`, and the directed `RC_EMUL` run all reported `*** TEST PASSED ***` with zero UVM errors and zero UVM fatals
  - potential_hazard:
    - The change is interface-contract only; no internal logic was modified.
- Commit:
  - this commit (`[FIX] HW: Drop runcontrol ready output (rc-network readyless contract)`)

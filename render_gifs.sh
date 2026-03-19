#!/bin/bash
# Copy MPC episode GIFs (already rendered during planning) to the project page.
# No re-rendering needed — camera matches exactly.
#
# Usage: bash ~/tnijdam/local-world-models/render_gifs.sh

set -e

BASE=/ssdstore/azadaia/tnijdam/data/reproduction-new/mpc-data/raw
OUT=/home/azadaia/tnijdam/local-world-models/assets/gifs

mkdir -p "$OUT/results" "$OUT/bias_ablation"

# ── Helper: copy the mpc_episode_*.gif from an episode dir ────────────────────
copy_gif() {
    local src_dir="$1"
    local dst="$2"
    local gif
    gif=$(ls "$src_dir"/mpc_episode_*.gif 2>/dev/null | head -1)
    if [ -z "$gif" ]; then
        echo "  WARNING: no mpc_episode_*.gif in $src_dir"
        return 1
    fi
    cp "$gif" "$dst"
    echo "  $dst  (from $(basename "$gif"))"
}

# ── Results: LWM-100M + contact + kinematics (6 examples) ────────────────────
echo "=== Results ==="
copy_gif "$BASE/LWM-100M_contact_kinematics/45526/new_config_45526_2026-02-14-23-29-06_0343" \
         "$OUT/results/door_seen_45526.gif"

copy_gif "$BASE/LWM-100M_contact_kinematics/45443/new_config_45443_2026-02-13-20-37-10_0221" \
         "$OUT/results/door_unseen_45443.gif"

copy_gif "$BASE/LWM-100M_contact_kinematics/46092/new_config_46092_2026-02-13-14-06-49_0185" \
         "$OUT/results/door_seen_46092.gif"

copy_gif "$BASE/LWM-100M_contact_kinematics/46417/new_config_46417_2026-02-22-16-05-02_0086" \
         "$OUT/results/door_unseen_46417.gif"

copy_gif "$BASE/LWM-100M_contact_kinematics/44853/new_config_44853_2026-02-13-14-06-49_0062" \
         "$OUT/results/drawer_seen_44853.gif"

copy_gif "$BASE/LWM-100M_contact_kinematics/45290/new_config_45290_2026-02-14-23-29-11_0430" \
         "$OUT/results/drawer_unseen_45290.gif"

# ── Bias ablation: LWM-200M on drawer 45132 (3 conditions) ───────────────────
echo "=== Bias ablation ==="
copy_gif "$BASE/LWM-200M_kinematics/45132/new_config_45132_2026-02-13-14-06-49_0108" \
         "$OUT/bias_ablation/drawer_seen_45132_no_bias.gif"

copy_gif "$BASE/LWM-200M_contact/45132/new_config_45132_2026-02-14-23-29-06_0228" \
         "$OUT/bias_ablation/drawer_seen_45132_contact.gif"

copy_gif "$BASE/LWM-200M_contact_kinematics/45132/new_config_45132_2026-02-14-23-29-06_0232" \
         "$OUT/bias_ablation/drawer_seen_45132_contact_kin.gif"

echo "=== Done! GIFs in $OUT ==="

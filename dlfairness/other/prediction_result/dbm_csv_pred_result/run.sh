#!/bin/bash

CONFIG=/path/to/fairness_variance_test_config.json     ### I have an example json in this dir
RAW_RESULT_DIR=/home/USER/fairness-variance/dlfairness/original_code/DomainBiasMitigation/
OUTPUT_DIR=/home/USER/fairness-variance/dlfairness/original_code/DomainBiasMitigation/other/metric_calculation/prediction

for dir in $RAW_RESULT_DIR/record/cifar-s_uniconf_adv/*/; do
    seed_char=$(basename "$dir")
    seed=${seed_char:4:1}
    python3 main.py --config "$CONFIG" --raw_result_dir "$RAW_RESULT_DIR" --output_dir "$OUTPUT_DIR" --exp_name "$(basename "$dir")" --seed "$seed"
done
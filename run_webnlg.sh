export CUDA_VISIBLE_DEVICES=4
python3 run.py \
    --task_name UniRel \
    --max_seq_length 100 \
    --per_device_train_batch_size 6 \
    --per_device_eval_batch_size 9 \
    --learning_rate 5e-5 \
    --num_train_epochs 100 \
    --logging_dir ./tb_logs \
    --logging_steps 50 \
    --eval_steps 2000 \
    --save_steps 2000 \
    --evaluation_strategy steps \
    --warmup_ratio 0.1 \
    --model_dir ./bert-base-cased/ \
    --output_dir ./output \
    --overwrite_output_dir \
    --dataset_dir unirel_in_data \
    --dataloader_pin_memory \
    --dataloader_num_workers 4 \
    --lr_scheduler_type cosine \
    --seed 2023 \
    --do_test_all_checkpoints\
    --dataset_name webnlg_star \
    --test_data_type nyt_all_sa \
    --threshold 0.5 \
    --do_train
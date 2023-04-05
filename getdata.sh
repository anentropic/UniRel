# prerequisites:
# - poetry shell
# - brew install p7zip

git submodule update --init --recursive

mkdir -p casrel_out_data/nyt_star/test_data
mkdir -p tplinker_out_data
mkdir -p unirel_in_data/nyt_star

# see CasRel/data/NYT/raw_NYT/README.md for more details
# (the instructions sparse and I had to edit the generate.py script to make it usable,
# ...seems like they must have been manually editing filenames between runs)
if [ ! -f "./CasRel/data/NYT/raw_NYT/relations2id.json" ]; then
    curl -L -o "./CasRel/data/NYT/raw_NYT/nyt.7z" "https://drive.google.com/uc?export=download&id=10f24s9gM7NdyO3z5OqQxJgYud4NnCJg3"
    7z e "./CasRel/data/NYT/raw_NYT/nyt.7z" nyt/* -o"./CasRel/data/NYT/raw_NYT/" -r
    rm "./CasRel/data/NYT/raw_NYT/nyt.7z"
fi
if [ ! -f "./CasRel/data/NYT/test.json" ]; then
    pushd CasRel/data/NYT/raw_NYT
        python generate.py test.json ../test
        python generate.py train.json ../train
        python generate.py valid.json ../dev
    popd
fi
if [ ! -f "./CasRel/data/NYT/test_triples.json" ]; then
    pushd CasRel/data/NYT/
        python build_data.py
    popd
fi

# ugh, we're not done yet...
# we have to perform the "build data" steps here:
# https://github.com/131250208/TPlinker-joint-extraction#build-data
cp CasRel/data/NYT/train_triples.json ./casrel_out_data/nyt_star/train_data.json
cp CasRel/data/NYT/dev_triples.json ./casrel_out_data/nyt_star/valid_data.json
cp CasRel/data/NYT/test_triples.json ./casrel_out_data/nyt_star/test_data/

if [ ! -f "./tplinker_out_data/nyt_star/test_triples.json" ]; then
    pushd TPlinker-joint-extraction
        python -m preprocess.anentropic \
            --config=preprocess/build_data_config.yaml \
            --exp-name=nyt_star \
            --data-in-dir=../casrel_out_data \
            --data-out-dir=../tplinker_out_data \
            --bert-path=bert-base-cased
    popd
fi

# and now instructions from: https://github.com/wtangdev/UniRel
cp ./tplinker_out_data/nyt_star/test_triples.json ./unirel_in_data/nyt_star/test_data.json
cp ./tplinker_out_data/nyt_star/train_data.json ./unirel_in_data/nyt_star/train_split.json
cp ./tplinker_out_data/nyt_star/valid_data.json ./unirel_in_data/nyt_star/valid_data.json

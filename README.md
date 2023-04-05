## About this fork

For some reason I decided I wanted to train this model for myself.

From the README it looked like there were some instructions and it might be easy, but actually the process was kind of cumbersome and there were a lot of missing details.

To be fair the problems are mostly in other repos - the training data that UniRel expects to work on is derived from two other projects ([TPLinker](https://github.com/131250208/TPlinker-joint-extraction), which in turn depends on [CasRel](https://github.com/weizhepei/CasRel)). These both had poor instructions and needed some tweaks to be usable. (In fact CasRel in turn depends on some data stored in Google Drive, originating in yet another project here https://github.com/xiangrongzeng/copy_re#data)

The end result is I have forked all three, brought the two dependencies in as git submodules, and written a helper script that duct-tapes this messy toolchain together and generates the training data that UniRel expects.
 
I was unable to install the specified dependencies under Python 3.8 on my M1 Macbook. Instead I've just created a new `poetry` project and installed newer versions of everything, seems to work fine.

### Prerequisites

If you haven't already: https://python-poetry.org/docs/#installation

Then `poetry install` and `poetry shell` to activate the env.

The original data is in a 7-Zip archive, so you need the `7z` command installed in your shell. For mac you can `brew install p7zip`. You also need `curl`.

Now just:
```
./getdata.sh
```

NOTE: this only prepares the "NYT*" training data. To train WebNLG you're on your own for now.

### UniRel training scripts

`./run_nyt.sh` should work now!

We're running PyTorch 2.0.0 now, so on Apple Silicon you can `./run_nyt.sh --use_mps_device` and it will use the GPU.

It is still slow though, I ran for ~30 mins and it looked like there were around 5 days remaining 🐌⏱️

### Why bother?

I was interested in the model because it's a BERT derivative.

Also at time of writing (April 2023) UniRel holds the #1 spot for the "Relation Extraction on NYT" benchmark:  
https://paperswithcode.com/sota/relation-extraction-on-nyt

# UniRel

Released code for our EMNLP22 paper: UniRel: Unified Representation and Interaction for Joint Relational Triple Extraction.

Join the [Discord](https://discord.gg/RGSruSmA8s) if there are any questions.


# Model
![Model Structure](assets/model.png)


# Results

![Main Results](assets/main_results.png)

![Complex Scenarios](assets/overlap_results.png)

# Usage

## Prerequisites

UniRel is implemented with `Python == 3.8` and `pytorch == 1.7.1`, Other main requirments are:
- tdqm
- transformers == 4.12.5
- wandb 

The detail requirments could be found at `requirements.txt`

## Data

We obtain the data from TPLinker, please kindly refer to [TPLinker officail repository](https://github.com/131250208/TPlinker-joint-extraction). Change two filename of the download data: 
- `train_data.json` -> `train_split.json`
- `test_triples.json` -> `test_data.json`


## Pretrained Model

We use the `bert-base-cased` model from Huggingface, you can download it by following their [instrcution](https://huggingface.co/bert-base-cased?text=The+goal+of+life+is+%5BMASK%5D.) or let Transformers to automatically download. After that, place the files at the root directory of the project (`./bert-base-cased`).

## Train & Evalutaion

All parameter are listed in the script `run_nyt.sh` and `run_webnlg.sh`. By run with command `bash run_nyt.sh` can do train and evaluation.

# Citation
```
@inproceedings{tang-etal-2022-unirel,
    title = "{U}ni{R}el: Unified Representation and Interaction for Joint Relational Triple Extraction",
    author = "Tang, Wei  and
      Xu, Benfeng  and
      Zhao, Yuyue  and
      Mao, Zhendong  and
      Liu, Yifeng  and
      Liao, Yong  and
      Xie, Haiyong",
    booktitle = "Proceedings of the 2022 Conference on Empirical Methods in Natural Language Processing",
    month = dec,
    year = "2022",
    address = "Abu Dhabi, United Arab Emirates",
    publisher = "Association for Computational Linguistics",
    url = "https://aclanthology.org/2022.emnlp-main.477",
    pages = "7087--7099",
}
```

---

Have a nice day.

import sys, re

DEFAULT_PATH = "./"
DEFAULT_FILE = "pccb.tex"
FILE_OBJECT = None

TEX_COMMAND_HEAD = [
    "\\documentclass[dvipdfmx,a4paper,landscape]{article}",
    "\\usepackage[landscape,top=20truemm,bottom=20truemm,left=20truemm,right=20truemm]{geometry}",
    "\\usepackage{graphicx}",
    "\\usepackage{caption}",
    "\\captionsetup[figure]{labelformat=empty,labelsep=none}",
    "\\newcommand{\\yfigcap}[4]{",
    "\t\\begin{figure}[htb]",
    "\t\t\\centering",
    "\t\t\\includegraphics[width=\\textwidth,height=0.9\\textheight,keepaspectratio]{#1}",
    "\t\t\\caption{#2-#3-#4}",
    "\t\\end{figure}",
    "\t\\clearpage",
    "}",
    "\\begin{document}"
]
TEX_COMMAND_FOOT = [
    "\\end{document}"
]


def generate(fs: list, gen_file: str =None) -> None:
    if gen_file is None:
        gen_file = f"{DEFAULT_PATH}{DEFAULT_FILE}"
    initialize(gen_file)
    write_commands(fs)
    finalize()

def initialize(gen_file: str) -> None:
    global FILE_OBJECT
    FILE_OBJECT = open(gen_file, 'w', encoding='utf-8')
    for cmd in TEX_COMMAND_HEAD:
        fwriteln(cmd)

def write_commands(fs: list) -> None:
    for f in fs:
        fwriteln(f2cmd(f))

def f2cmd(fname: str) -> str:
    y, m, d = parse_ymd(fname)
    cmd = f"\\yfigcap{{{fname}}}{{{y}}}{{{m}}}{{{d}}}"
    return cmd

def parse_ymd(fname: str) -> tuple:
    ymd = re.search(r"_\d{8}_", fname)
    assert ymd is not None
    ymd = ymd.group()
    assert len(ymd) == len("_yyyymmdd_")
    y, m, d = ymd[1:5], ymd[5:7], ymd[7:9]
    return y, m, d

def fwriteln(str: str) -> None:
    assert FILE_OBJECT is not None
    FILE_OBJECT.write(str+"\n")

def finalize() -> None:
    global FILE_OBJECT
    for cmd in TEX_COMMAND_FOOT:
        fwriteln(cmd)
    FILE_OBJECT.close()
    FILE_OBJECT = None


if __name__ == "__main__":
    fs = [
        "./figure/______pcc02_pcc205_20200811_205.png",
        "./figure/______pcc03_pcc303_20210430_303.png",
        "./figure/______pcc03_pcc313_20210913_313.png"
    ]
    generate(fs)

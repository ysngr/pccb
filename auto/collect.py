import glob, random, os, shutil, re

DEFAULT_PATH = "../../"
DEFAULT_DIRS = ["pcc00", "pcc01", "pcc02", "pcc03"]
TARGET_EXT = ["png", "jpg"]
MKDIR_NAME = "./figure/"


def collect(target_dirs: list =None) -> list:
    if target_dirs is None:
        target_dirs = [f"{DEFAULT_PATH}{d}" for d in DEFAULT_DIRS]
    return duplicate(select_files(target_dirs))

def select_files(target_dirs: list, n: int =20) -> list:
    target_files = expansion(target_dirs)
    assert len(target_files) >= n, f"The number of files in the specified directories({len(target_files)}) does not reach the required value({n})."
    return random.sample(target_files, n)

def expansion(target_dirs: list) -> list:
    target_files = []
    for d in target_dirs:
        for ext in TARGET_EXT:
            target_files.append(glob.glob(f"{d}/**/*.{ext}"))
    target_files = sum(target_files, [])  # flatten
    target_files = [f.replace('\\', '/') for f in target_files]
    return target_files

def duplicate(target_files: list) -> list:
    # mkdir
    if os.path.isdir(MKDIR_NAME):
        shutil.rmtree(MKDIR_NAME)
    os.mkdir(MKDIR_NAME)
    # copy
    replaced_files = []
    for f in target_files:
        fname, ext = os.path.splitext(f)
        replaced_fname = re.sub(r"\W", "_", fname)
        replaced_file = f"{MKDIR_NAME}{replaced_fname}{ext}"
        shutil.copy(f, replaced_file)
        replaced_files.append(replaced_file)
    return replaced_files


if __name__ == "__main__":
    import pprint
    fs = collect()
    pprint.pprint(fs)

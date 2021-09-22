import os

for i,v in enumerate(os.listdir()):
    if v[-3:] == "jpg":
        os.rename(v, str(i) + ".jpg")
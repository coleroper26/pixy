import os
import random
import requests

bl_dir ='../blocklist'
prot='http://'
f_samps=30
bl_excl=["malware", "pornography", "illegal"]

sample_lines = []
blocklists = [f for f in os.listdir(bl_dir) if os.path.isfile(os.path.join(bl_dir, f)) and not f in bl_excl]
for blocklist in blocklists:
    # count total number of lines in blocklist
    with open(os.path.join(bl_dir, blocklist), 'r') as f_blocklist:
        for line_count, line in enumerate(f_blocklist):
            pass
    # choose lines to sample from blocklist
    sample_line_nums = random.sample(range(line_count), f_samps)
    # get sample lines
    with open(os.path.join(bl_dir, blocklist), 'r') as f_blocklist:
        for line_num, line in enumerate(f_blocklist):
            if line_num in sample_line_nums:
                sample_lines.append(prot+line.strip())

tmp = []

for line in sample_lines:
    tmp.append(line)
    try:
        requests.head(line, timeout=2.0)
    except requests.exceptions.RequestException as E:
        tmp.pop()
        pass


print(f"Writing {len(sample_lines)} URLs.")

with open('./bl_test', 'a') as bl_test:
    for line in tmp:
        bl_test.write('\"' + line + '\", ')






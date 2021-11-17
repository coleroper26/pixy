import os
import requests

blocklists_dir = '../blocklist'
protocol       = 'http://'

blocklists = [f for f in os.listdir(blocklists_dir) if os.path.isfile(os.path.join(blocklists_dir, f))]
for blocklist in blocklists:

    # count total number of lines
    with open(os.path.join(blocklists_dir, blocklist), 'r') as f_blocklist:
        for line_count, line in enumerate(f_blocklist):
            pass

    count = 0
    with open(os.path.join(blocklists_dir, blocklist), 'r') as f_blocklist:
        for line in f_blocklist:
            # make request
            try:
                requests.head(protocol+line.strip(), timeout=2.0)
            except:
                pass
            # progress bar
            count += 1
            if (count >= int(line_count * 0.1)):
                print('=', end='')
                count = 0
        print('\n')

